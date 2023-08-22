package message;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.catalina.connector.Request;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.DBConnectionMgr;
import familyEvent.UtilMgr;
import management.ManagementBean;

public class MsgMgr {

	private DBConnectionMgr pool;
	// 파일 업로드 관련 설정 작성
	private static final String SAVEFOLDER = "C:/GNCART/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5 * 1024 * 1024;
	
	public String savefolder = SAVEFOLDER;
	public String enctype = ENCTYPE;
	public int maxsize = MAXSIZE;
	
	public MsgMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
	public Vector<MsgBean> msgInboxList(String fromName) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		Vector<MsgBean> msglist = new Vector<MsgBean>();

		try {
			con = pool.getConnection();

			sql = "SELECT * FROM MESSAGE WHERE MSG_TONAME = ? ORDER BY MSG_SENDTIME DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromName);

			rs = pstmt.executeQuery();

			while (rs.next()) { 
				MsgBean bean = new MsgBean();
				bean.setMsg_no(rs.getInt("msg_no"));
				bean.setMsg_title(rs.getString("msg_title"));
				bean.setMsg_fromPartType(rs.getString("msg_fromparttype"));
				bean.setMsg_fromName(rs.getString("msg_fromname"));
				bean.setMsg_sendTime(rs.getString("msg_sendtime"));
				bean.setMsg_readTime(rs.getString("msg_readtime"));
				bean.setMsg_read(rs.getString("msg_read"));
				bean.setMsg_delCnt(rs.getInt("msg_delcnt"));
				bean.setMsg_showCheck(rs.getInt("msg_showcheck"));
					
				msglist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msglist;
	}
	
	public Vector<MsgBean> msgSentList(String toName) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		Vector<MsgBean> msglist = new Vector<MsgBean>();

		try {
			con = pool.getConnection();

			sql = "SELECT * FROM MESSAGE WHERE MSG_FROMNAME = ? ORDER BY MSG_SENDTIME DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, toName);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MsgBean bean = new MsgBean();
				bean.setMsg_no(rs.getInt("msg_no"));
				bean.setMsg_title(rs.getString("msg_title"));
				bean.setMsg_toPartType(rs.getString("msg_toparttype"));
				bean.setMsg_toName(rs.getString("msg_toname"));
				bean.setMsg_sendTime(rs.getString("msg_sendtime"));
				bean.setMsg_readTime(rs.getString("msg_readtime"));
				bean.setMsg_read(rs.getString("msg_read"));
				bean.setMsg_delCnt(rs.getInt("msg_delcnt"));
				bean.setMsg_showCheck(rs.getInt("msg_showcheck"));
				msglist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msglist;
	}

	public void insertMsg(HttpServletRequest req) {

		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;

		MultipartRequest multi = null;
		
		int filesize = 0;
		String filename = null;
		
		String userPart = "";
		String userName = "";
		
		try {
			con = pool.getConnection();		


			File file = new File(SAVEFOLDER);
			if (!file.exists())
				file.mkdirs();
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			} else {
				filename = "";
			}
			
			//String "/" 기준으로 나누기
			if(multi.getParameter("user_part_name") != null) {
				String user_part_name = multi.getParameter("user_part_name");

				if (user_part_name.contains("/")) {
					String temp[] = user_part_name.split(" / ");

					userPart = temp[0];
					userName = temp[1];
				} else {
					userPart = "부서";
					userName = "이름";
				}
			}
			
			
			String content = multi.getParameter("msg_content");
			content = UtilMgr.replace(content, "<", "&lt;");		
			
			sql = "INSERT INTO MESSAGE (MSG_TITLE, MSG_CONTENT, MSG_TOPARTTYPE, MSG_TONAME, MSG_FROMPARTTYPE, MSG_FROMNAME, MSG_SENDTIME, MSG_READTIME, MSG_READ, MSG_DELCNT, MSG_SHOWCHECK, MSG_FILE, MEM_NO)"
					+ "VALUES(?, ?, ?, ?, ?, ?, now(), ?, ?, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("msg_title"));
			pstmt.setString(2, multi.getParameter("msg_content"));
			pstmt.setString(3, userPart);
			pstmt.setString(4, userName);
			pstmt.setString(5, multi.getParameter("msg_frompparttype"));
			pstmt.setString(6, multi.getParameter("msg_fromname"));
			pstmt.setString(7, ""); // 읽은 시간
			pstmt.setString(8, "안읽음");
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setString(11, filename);
			pstmt.setInt(12, Integer.parseInt(multi.getParameter("mem_no")));

			pstmt.executeUpdate();

			PKkeySort();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public MsgBean getMsg(int msg_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		MsgBean bean = new MsgBean();
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM MESSAGE WHERE MSG_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msg_no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setMsg_no(msg_no);
				bean.setMsg_title(rs.getString("MSG_TITLE"));
				bean.setMsg_content(rs.getString("MSG_CONTENT"));
				bean.setMsg_toPartType(rs.getString("MSG_TOPARTTYPE"));
				bean.setMsg_toName(rs.getString("MSG_TONAME"));
				bean.setMsg_fromPartType(rs.getString("MSG_FROMPARTTYPE"));
				bean.setMsg_fromName(rs.getString("MSG_FROMNAME"));
				bean.setMsg_sendTime(rs.getString("MSG_SENDTIME"));
				bean.setMsg_readTime(rs.getString("MSG_READTIME"));
				bean.setMsg_read(rs.getString("MSG_READ"));
				bean.setMsg_delCnt(rs.getInt("MSG_DELCNT"));
				bean.setMsg_file(rs.getString("MSG_FILE"));
				return bean;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return bean;
	}
	
	public void setRead(int msg_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		MsgBean bean = new MsgBean();
		try {
			con = pool.getConnection();

			sql = "UPDATE MESSAGE SET MSG_READ = ?, MSG_READTIME = now() WHERE MSG_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "읽음");
			pstmt.setInt(2, msg_no);
			
			pstmt.executeUpdate();	

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	public void deleteMsg(int msg_no, String pageName) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;

		try {
			con = pool.getConnection();
			//받은 메일함
			if(pageName.equals("messageInbox")) {				
				sql = "UPDATE MESSAGE SET MSG_DELCNT = MSG_DELCNT + 1, MSG_SHOWCHECK = 2 WHERE MSG_NO = ?";
			}else if(pageName.equals("messageSent")) {// messageSent 보낸 메일함
				sql = "UPDATE MESSAGE SET MSG_DELCNT = MSG_DELCNT + 1, MSG_SHOWCHECK = 1 WHERE MSG_NO = ?";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msg_no);
			pstmt.executeUpdate();

			delCntCheck();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);

		}

	}

	public void deleteMsg(String checkedList[], String pageName) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;

		try {
			con = pool.getConnection();

			for (String check : checkedList) {

				//받은 메일함
				if(pageName.equals("messageInbox")) {				
					sql = "UPDATE MESSAGE SET MSG_DELCNT = MSG_DELCNT + 1, MSG_SHOWCHECK = 2 WHERE MSG_NO = ?";
				}else if(pageName.equals("messageSent")) {// messageSent 보낸 메일함
					sql = "UPDATE MESSAGE SET MSG_DELCNT = MSG_DELCNT + 1, MSG_SHOWCHECK = 1 WHERE MSG_NO = ?";
				}
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, Integer.parseInt(check));
				pstmt.executeUpdate();
				pstmt.clearParameters();
			}

			delCntCheck();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public ManagementBean userInfo(int mem_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ManagementBean mbean = new ManagementBean();
		
		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a \r\n"
					+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO \r\n"
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n"
					+ "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n"
					+ "WHERE MEM_NO = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mbean.setMEM_NAME(rs.getString("MEM_NAME"));
				mbean.setPART_TYPE(rs.getString("PART_TYPE"));
			}
			return mbean;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mbean;
	}
	
	public Vector<ManagementBean> userSearch() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<ManagementBean> mlist = new Vector<ManagementBean>();
		
		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a\r\n" 
					+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO\r\n" 
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n" 
					+ "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean mbean=new ManagementBean();
				mbean.setMEM_NO(rs.getInt("MEM_NO"));
				mbean.setMEM_NAME(rs.getString("MEM_NAME"));
				mbean.setMEM_ID(rs.getString("MEM_ID"));
				mbean.setMEM_PW(rs.getString("MEM_PW"));
				mbean.setMEM_DATE(rs.getString("MEM_DATE"));
				mbean.setMEM_TEL(rs.getString("MEM_TEL"));
				mbean.setMEM_MAIL(rs.getString("MEM_MAIL"));
				mbean.setMEM_PHONE(rs.getString("MEM_PHONE"));
				mbean.setMEM_ADD(rs.getString("MEM_ADD"));
				mbean.setMEM_BIRTH(rs.getString("MEM_BIRTH"));				
				mbean.setMEM_AND(rs.getString("MEM_AND"));
				
				mbean.setAC_NO(rs.getInt("AC_NO"));
				mbean.setWORK_NO(rs.getInt("WORK_NO"));
				mbean.setPART_NO(rs.getInt("PART_NO"));
				mbean.setLE_NO(rs.getInt("LE_NO"));
				mbean.setAP_NO(rs.getInt("AP_NO"));
				
				mbean.setAC_TYPE(rs.getString("AC_TYPE"));
				mbean.setWORK_TYPE(rs.getString("WORK_TYPE"));
				mbean.setPART_TYPE(rs.getString("PART_TYPE"));
				mbean.setLE_LEVEL(rs.getString("LE_LEVEL"));
				mbean.setAP_TYPE(rs.getString("AP_TYPE"));
				mlist.add(mbean);			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return mlist;
	}
	
	
public Vector<ManagementBean> userFind(String keyWord) {
			
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<ManagementBean> mlist = new Vector<ManagementBean>();
		
		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a\r\n" 
					+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO\r\n" 
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n" 
					+ "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n";
			
			if(!keyWord.contains(" ")) {			
				sql += "WHERE PART_TYPE LIKE ? OR MEM_NAME LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyWord);
				pstmt.setString(2, keyWord);

			} else {
				String word1 = "";
				String word2 = "";
				
				String temp[] = keyWord.split(" ");

				word1 = temp[0];
				word2 = temp[1];
				
				sql += "WHERE PART_TYPE LIKE ? AND MEM_NAME LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, word1);
				pstmt.setString(2, word2);			
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean mbean=new ManagementBean();
				mbean.setMEM_NO(rs.getInt("MEM_NO"));
				mbean.setMEM_NAME(rs.getString("MEM_NAME"));
				mbean.setMEM_ID(rs.getString("MEM_ID"));
				mbean.setMEM_PW(rs.getString("MEM_PW"));
				mbean.setMEM_DATE(rs.getString("MEM_DATE"));
				mbean.setMEM_TEL(rs.getString("MEM_TEL"));
				mbean.setMEM_MAIL(rs.getString("MEM_MAIL"));
				mbean.setMEM_PHONE(rs.getString("MEM_PHONE"));
				mbean.setMEM_ADD(rs.getString("MEM_ADD"));
				mbean.setMEM_BIRTH(rs.getString("MEM_BIRTH"));				
				mbean.setMEM_AND(rs.getString("MEM_AND"));
				
				mbean.setAC_NO(rs.getInt("AC_NO"));
				mbean.setWORK_NO(rs.getInt("WORK_NO"));
				mbean.setPART_NO(rs.getInt("PART_NO"));
				mbean.setLE_NO(rs.getInt("LE_NO"));
				mbean.setAP_NO(rs.getInt("AP_NO"));
				
				mbean.setAC_TYPE(rs.getString("AC_TYPE"));
				mbean.setWORK_TYPE(rs.getString("WORK_TYPE"));
				mbean.setPART_TYPE(rs.getString("PART_TYPE"));
				mbean.setLE_LEVEL(rs.getString("LE_LEVEL"));
				mbean.setAP_TYPE(rs.getString("AP_TYPE"));
				mlist.add(mbean);			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		} 

		return mlist;
	}

	//PK 키 정렬 초기화를 위한 함수
	public void PKkeySort() {

		Connection con = null;

		PreparedStatement pstmtIncrement = null;
		PreparedStatement pstmtCnt = null;
		PreparedStatement pstmtUpdate = null;

		String sql = null;

		try {
			con = pool.getConnection();

			sql = "ALTER TABLE MESSAGE AUTO_INCREMENT = 1";
			pstmtIncrement = con.prepareStatement(sql);
			pstmtIncrement.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmtCnt = con.prepareStatement(sql);
			pstmtCnt.executeUpdate();

			sql = "UPDATE MESSAGE SET MSG_NO = @COUNT:=@COUNT+1";
			pstmtUpdate = con.prepareStatement(sql);
			pstmtUpdate.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmtIncrement);
			pool.freeConnection(con, pstmtCnt);
			pool.freeConnection(con, pstmtUpdate);
		}
	}
	
	public void delCntCheck() {
		
		Connection con = null;

		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		
		String sql = null;
		
		ResultSet rs = null;
		try {
			con = pool.getConnection();

			sql = "SELECT MSG_FILE FROM MESSAGE WHERE MSG_DELCNT = 2";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists())
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			
			sql = "DELETE FROM MESSAGE WHERE MSG_DELCNT = 2";
			pstmt1 = con.prepareStatement(sql);
			pstmt1.executeUpdate();
				
			PKkeySort();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
			pool.freeConnection(con, pstmt1);
		}
	}
	
	// 파일 다운로드 메서드
		public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {

			try {
				// 요청 객체에 있는 filename 파라미터를 받아서 변수에 저장.
				String filename = req.getParameter("filename");

				// file 객체생성 , filename이 한글 일 경우 깨지지 않게 하기 위해서
				// UtilMgr 클래스의 con()메서드 호출하여 결과 값을 담는다.
				// BoardMgr 클래스 상단에 있는 savefoler 경로 와 file구분자, filename을 저장.
				File file = new File(UtilMgr.con(SAVEFOLDER + File.separator + filename));

				// file.length() 는 파일의 크기를 리턴 하며, 단위는 byte 임.
				byte b[] = new byte[(int) file.length()];

				// res.setHeader() 메서드를 이용해서 response(응답) 객체의 header에 text를 추가.
				// 첫번째 인수가 key, 두번째 인수가 value 이다.
				res.setHeader("Accept-Ranges", "bytes");

				// req.getHeader() 메서드를 이용해서 요청 객체의 클라이언트 브라우저 정보를 strClient 변수에 저장.
				String strClient = req.getHeader("User-Agent");

				// strClient 변수에 저장된 브라우저 정보를 indexOf 메서드로 검색.
				// 브라우저 정보에 MSIE 가 true 이면 ms사 의 브라우저, false 면 다른 브라우저로 인식.
				// 브라우저 의 버전과 정보를 구분해서 각 각 res(응답객체) 의 header 와 contentType을 설정한다.
				if (strClient.indexOf("MSIE6.0") != -1) {
					// indexOf() 메서드를 사용하여 일치하는 값이 없으면 -1을 반환한다.
					// 이 조건문 에서는 true 상황, 즉 일치하는 값이 있는 경우 아래 내용을 수행한다.
					res.setContentType("application/smnet;charset=UTF-8");

					res.setHeader("Content-Disposition", "filename=" + filename + ";");

				} else { // indexOf() 메서드 실행결과 일치하는 값이 없으면 아래 내용 수행.

					res.setContentType("application/smnet;charset=UTF-8");

					res.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
				}

				out.clear(); // out.clear() : out 객체의 모든 컨텐츠 지우기

				out = pageContext.pushBody(); // pageContext.pushBody() : jsp 페이지 정보 저장.

				if (file.isFile()) {
					// file.isFile() 메서드로 file 객체에 있는 savefolder 경로 와 filename이 일치 하면 true.

					// BufferedInputStream 객체를 생성하고, FileInputStream 을 이용하여 file을 읽어들여 저장한다.
					BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));

					out.clear();
					pageContext.pushBody();

					BufferedOutputStream outs = new BufferedOutputStream(res.getOutputStream());

					int read = 0;

					while ((read = fin.read(b)) != -1) {
						outs.write(b, 0, read);
					}

					outs.close();

					fin.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
}
