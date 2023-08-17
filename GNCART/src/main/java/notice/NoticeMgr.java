package notice;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.DBConnectionMgr;

public class NoticeMgr {

	private DBConnectionMgr pool;
	//파일 업로드 관련 설정 작성
	private static final String  SAVEFOLDER = "C:/GNCART/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;

	public NoticeMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Vector<NoticeBean> getBoardList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<NoticeBean> vlist = new Vector<NoticeBean>();

		try {
			con = pool.getConnection();
			sql = "SELECT n.*, m.MEM_NAME, m.MEM_ID, ns.not_sub FROM notice n JOIN member m ON n.MEM_NO = m.MEM_NO JOIN noticesub ns ON n.NOTSUB_NO = ns.NOTSUB_NO ORDER BY n.NOT_NO DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeBean bean = new NoticeBean();
				bean.setNOT_NO(rs.getInt("NOT_NO"));
				bean.setNOT_TITLE(rs.getString("NOT_TITLE"));
				bean.setNOT_CONTENT(rs.getString("NOT_CONTENT"));
				bean.setNOT_DATE(rs.getString("NOT_DATE"));
				bean.setNOT_HIT(rs.getInt("NOT_HIT"));
				bean.setNOT_FILENAME(rs.getString("NOT_FILENAME"));
				bean.setNOT_FILESIZE(rs.getInt("NOT_FILESIZE"));
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setNOTSUB_NO(rs.getInt("NOTSUB_NO"));
				bean.setNOT_SUB(rs.getString("NOT_SUB")); 
				bean.setMEM_ID(rs.getString("MEM_ID"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return vlist;
	}
	public void insertNotice(HttpServletRequest req) {

		Connection con = null; //연결객체
		PreparedStatement pstmt = null; //쿼리처리객체
		ResultSet rs = null;  //결과값 담는 객체

		String sql = null; //쿼리문 저장 변수

		MultipartRequest multi = null; //파일 업로드 위한 객체

		int filesize = 0; //파일용량 변수

		String filename = null; //파일이름 변수

		int NOT_NO = 0;


		try {
			con = pool.getConnection();
			sql = "select max(NOT_NO) from notice"; //게시물이 총 몇개 인지 조회하는 쿼리
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();


			if (rs.next())
				NOT_NO = rs.getInt("max(NOT_NO)")+1;

			File file = new File(SAVEFOLDER);

			//exists() 메서드 : 파일이 존재 하는지 여부를 알아 내는 메서드
			//파일이 존재 한다면 true, 없으면 false 값을 반환.
			if (!file.exists()) //파일이 존재 한다면
				file.mkdirs(); //mkdirs() : 파일 디렉토리 만드는 메서드 
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("NOT_FILENAME") != null) {
				filename = multi.getFilesystemName("NOT_FILENAME");
				filesize = (int) multi.getFile("NOT_FILENAME").length();
			}


			sql = "insert notice(NOT_NO,NOT_TITLE,NOT_CONTENT,NOT_DATE,NOT_HIT,NOT_FILENAME,NOT_FILESIZE,MEM_NO,NOTSUB_NO,PART_NO)";
			sql += "values(?,?,?,now(),0,?,?,?,?,?)";
			//작성날짜 regdate 컬럼은 now() 로 현재 날짜를 자동으로 입력 합니다.
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, NOT_NO);
			pstmt.setString(2, multi.getParameter("NOT_TITLE"));
			pstmt.setString(3, multi.getParameter("NOT_CONTENT"));
			pstmt.setString(4, filename);
			pstmt.setInt(5, filesize);
			pstmt.setInt(6, Integer.parseInt(multi.getParameter("MEM_NO")));
			pstmt.setInt(7, Integer.parseInt(multi.getParameter("NOTSUB_NO")));
			pstmt.setInt(8, Integer.parseInt(multi.getParameter("PART_NO")));

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public NoticeBean getNotice(int NOT_NO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		NoticeBean bean = new NoticeBean();

		try {
			con = pool.getConnection();
			sql = "SELECT n.*, m.MEM_NAME, m.MEM_ID, ns.NOT_SUB, p.PART_TYPE FROM notice n JOIN member m ON n.MEM_NO = m.MEM_NO JOIN part p ON n.PART_NO = p.PART_NO JOIN noticesub ns ON n.NOTSUB_NO = ns.NOTSUB_NO WHERE n.NOT_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, NOT_NO);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setNOT_NO(rs.getInt("NOT_NO"));
				bean.setNOT_TITLE(rs.getString("NOT_TITLE"));
				bean.setNOT_CONTENT(rs.getString("NOT_CONTENT"));
				bean.setNOT_DATE(rs.getString("NOT_DATE"));
				bean.setNOT_HIT(rs.getInt("NOT_HIT"));
				bean.setNOT_FILENAME(rs.getString("NOT_FILENAME"));
				bean.setNOT_FILESIZE(rs.getInt("NOT_FILESIZE"));
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setMEM_NAME(rs.getString("MEM_NAME")); 
				bean.setNOTSUB_NO(rs.getInt("NOTSUB_NO"));
				bean.setNOT_SUB(rs.getString("NOT_SUB"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setPART_NO(rs.getInt("PART_NO"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return bean;
	}

	public void upHit(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();
			int NOT_NO = Integer.parseInt(request.getParameter("NOT_NO"));

			// 중복 조회를 체크하기 위해 쿠키를 읽어옵니다.
			Cookie[] cookies = request.getCookies();
			boolean cookchk = false;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("hit_" + NOT_NO)) {
						cookchk = true;
						break;
					}
				}
			}

			// 중복이 아닌 경우에만 조회수 증가
			if (!cookchk) {
				sql = "UPDATE notice SET NOT_HIT=NOT_HIT+1 WHERE NOT_NO=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, NOT_NO);
				pstmt.executeUpdate();

				// 조회수 증가 기록을 쿠키에 저장합니다.
				Cookie hitCookie = new Cookie("hit_" + NOT_NO, "true");
				hitCookie.setMaxAge(24 * 60 * 60); // 쿠키 유효 기간을 설정 (예: 24시간)
				response.addCookie(hitCookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {

		try {
			//요청 객체에 있는 filename 파라미터를 받아서 변수에 저장.
			String NOT_FILENAME = req.getParameter("NOT_FILENAME");

			//file 객체생성 , filename이 한글 일 경우 깨지지 않게 하기 위해서
			//UtilMgr 클래스의 con()메서드 호출하여 결과 값을 담는다.
			//BoardMgr 클래스 상단에 있는 savefoler 경로 와 file구분자, filename을 저장.
			File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ NOT_FILENAME));

			//file.length() 는 파일의 크기를 리턴 하며, 단위는 byte 임.
			byte b[] = new byte[(int) file.length()];

			//res.setHeader() 메서드를 이용해서 response(응답) 객체의 header에 text를 추가.
			//첫번째 인수가 key, 두번째 인수가 value 이다.
			res.setHeader("Accept-Ranges", "bytes");

			//req.getHeader() 메서드를 이용해서 요청 객체의 클라이언트 브라우저 정보를 strClient 변수에 저장.
			String strClient = req.getHeader("User-Agent");

			//strClient 변수에 저장된 브라우저 정보를 indexOf 메서드로 검색.
			//브라우저 정보에 MSIE 가 true 이면 ms사 의 브라우저, false 면 다른 브라우저로 인식.
			//브라우저 의 버전과 정보를 구분해서 각 각 res(응답객체) 의 header 와 contentType을 설정한다.
			if (strClient.indexOf("MSIE6.0") != -1) { 
				//indexOf() 메서드를 사용하여 일치하는 값이 없으면 -1을 반환한다. 
				//이 조건문 에서는 true 상황, 즉 일치하는 값이 있는 경우 아래 내용을 수행한다.
				res.setContentType("application/smnet;charset=UTF-8");

				res.setHeader("Content-Disposition", "filename=" + NOT_FILENAME + ";");

			} else { //indexOf() 메서드 실행결과 일치하는 값이 없으면 아래 내용 수행.

				res.setContentType("application/smnet;charset=UTF-8");

				res.setHeader("Content-Disposition", "attachment;filename="+ NOT_FILENAME + ";");
			}

			out.clear(); //out.clear() : out 객체의 모든 컨텐츠 지우기

			out = pageContext.pushBody(); //pageContext.pushBody() : jsp 페이지 정보 저장.

			if (file.isFile()) { 
				//file.isFile() 메서드로 file 객체에 있는 savefolder 경로 와 filename이 일치 하면 true.   

				//BufferedInputStream 객체를 생성하고, FileInputStream 을 이용하여 file을 읽어들여 저장한다.
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));

				//BufferedOutputStream 객체를 생성하여 응답시 출력을 한다.
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
	public void reviseNotice(NoticeBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update notice set NOT_TITLE=?,NOT_CONTENT=?,MEM_NO=?,NOTSUB_NO=?,PART_NO=? where NOT_NO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getNOT_TITLE());
			pstmt.setString(2, bean.getNOT_CONTENT());
			pstmt.setInt(3, bean.getMEM_NO());
			pstmt.setInt(4, bean.getNOTSUB_NO());
			pstmt.setInt(5, bean.getPART_NO());
			pstmt.setInt(6, bean.getNOT_NO());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteNoitce(int NOT_NO) {

		Connection con = null;

		PreparedStatement pstmt = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();
			sql = "select NOT_FILENAME from NOTICE where NOT_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, NOT_NO);
			rs = pstmt.executeQuery();

			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists())
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			//num 을 이용하여 tblBoard 테이블의 컬럼을 찾아서 delete 쿼리문으로 해당 컬럼 삭제. 
			sql = "delete from notice where NOT_NO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, NOT_NO);
			pstmt.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

			sql = "UPDATE notice SET NOT_NO = (@COUNT := @COUNT + 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public int noticeCheck(String[] NOT_NO) {
		try (Connection con = pool.getConnection();
				PreparedStatement pstmtSelect = con.prepareStatement("select NOT_FILENAME from notice where NOT_NO=?");
				PreparedStatement pstmtDelete = con.prepareStatement("delete from notice where NOT_NO=?")) {

			con.setAutoCommit(false); // 트랜잭션 시작

			for (String notNo : NOT_NO) {
				pstmtSelect.setString(1, notNo);
				try (ResultSet rs = pstmtSelect.executeQuery()) {
					if (rs.next()) {
						String notFileName = rs.getString(1);
						if (notFileName != null && !notFileName.isEmpty()) {
							File file = new File(SAVEFOLDER + "/" + notFileName);
							if (file.exists()) {
								UtilMgr.delete(SAVEFOLDER + "/" + notFileName);
							}
						}
					}
				}

				pstmtDelete.setString(1, notNo);
				pstmtDelete.addBatch();
			}

			int[] cnt = pstmtDelete.executeBatch();
			int res = 0;
			for (int count : cnt) {
				if (count == 1) {
					res++;
				}
			}

			// SET 문 실행
			String setSql = "SET @COUNT = 0";
			try (PreparedStatement pstmtSet = con.prepareStatement(setSql)) {
				pstmtSet.executeUpdate();
			}

			// UPDATE 문 실행
			String updateSql = "UPDATE notice SET NOT_NO = (@COUNT := @COUNT + 1)";
			try (PreparedStatement pstmtUpdate = con.prepareStatement(updateSql)) {
				pstmtUpdate.executeUpdate();
			}

			con.commit(); // 트랜잭션 커밋
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

}