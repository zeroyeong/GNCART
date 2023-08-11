package chat;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;

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

public class ChatMgr {

	private DBConnectionMgr pool;
	// 파일 업로드 관련 설정 작성
	private static final String SAVEFOLDER = "C:/GNCART/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5 * 1024 * 1024;
	
	public String savefolder = SAVEFOLDER;
	public String enctype = ENCTYPE;
	public int maxsize = MAXSIZE;
	
	public ChatMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insertChat(ChatBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;
		
		try {
			con = pool.getConnection();		


			sql = "INSERT INTO CHAT (CHAT_TOPARTTYPE, CHAT_TONAME, CHAT_FROMPARTTYPE, CHAT_FROMNAME, CHAT_CONTENT, CHAT_TIME, CHAT_READ)\r\n"
					+ "VALUES(?, ?, ?, ?, ?, now(), ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getChat_toPartType());
			pstmt.setString(2, bean.getChat_toName()); 
			pstmt.setString(3, bean.getChat_fromPartType());
			pstmt.setString(4, bean.getChat_fromName());
			pstmt.setString(5, bean.getChat_content());
			pstmt.setString(6, "안읽음"); 

			pstmt.executeUpdate();

			PKkeySort();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public ChatBean getMsg(int msg_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		ChatBean bean = new ChatBean();
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM MESSAGE WHERE MSG_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msg_no);
			rs = pstmt.executeQuery();

			if (rs.next()) {

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

		ChatBean bean = new ChatBean();
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



		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public Vector<ManagementBean> userInfo() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		Vector<ManagementBean> userList = new Vector<ManagementBean>();
		
		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a \r\n"
					+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO \r\n"
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n"
					+ "JOIN acposition f ON a.AP_NO=f.AP_NO";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean mbean = new ManagementBean();
				mbean.setMEM_NAME(rs.getString("MEM_NAME"));
				mbean.setPART_TYPE(rs.getString("PART_TYPE"));
				userList.add(mbean);
			}
			return userList;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userList;
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

			sql = "ALTER TABLE CHAT AUTO_INCREMENT = 1";
			pstmtIncrement = con.prepareStatement(sql);
			pstmtIncrement.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmtCnt = con.prepareStatement(sql);
			pstmtCnt.executeUpdate();

			sql = "UPDATE CHAT SET Chat_NO = @COUNT:=@COUNT+1";
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
	
	
	public Vector<ChatBean> callChat(String toPartType, String toName, String fromPartType, String fromName) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		Vector<ChatBean> chatList = new Vector<ChatBean>();
		
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM CHAT WHERE\r\n"
					+ "((CHAT_TOPARTTYPE = ? AND CHAT_TONAME = ?) AND\r\n"
					+ "(CHAT_FROMPARTTYPE = ? AND CHAT_FROMNAME = ?)) OR\r\n"
					+ "((CHAT_TOPARTTYPE = ? AND CHAT_TONAME = ?) AND\r\n"
					+ "(CHAT_FROMPARTTYPE = ? AND CHAT_FROMNAME = ?))\r\n"
					+ "ORDER BY CHAT_TIME";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, toPartType);
			pstmt.setString(2, toName);
			
			pstmt.setString(3, fromPartType);
			pstmt.setString(4, fromName);
			
			pstmt.setString(5, fromPartType);
			pstmt.setString(6, fromName);

			pstmt.setString(7, toPartType);
			pstmt.setString(8, toName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatBean cbean = new ChatBean();
				cbean.setChat_no(rs.getInt("CHAT_NO"));
				cbean.setChat_toName(rs.getString("CHAT_TONAME"));
				cbean.setChat_fromName(rs.getString("CHAT_FROMNAME"));
				cbean.setChat_content(rs.getString("CHAT_CONTENT"));
				cbean.setChat_time(rs.getString("CHAT_TIME"));
				chatList.add(cbean);
			}
			return chatList;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return chatList;
	} 
}
