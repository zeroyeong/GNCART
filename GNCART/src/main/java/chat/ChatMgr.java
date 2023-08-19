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

	public Vector<ManagementBean> userInfo() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		Vector<ManagementBean> userList = new Vector<ManagementBean>();

		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a \r\n" + "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO \r\n" + "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n" + "JOIN acposition f ON a.AP_NO=f.AP_NO";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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

	public Vector<ManagementBean> userFind(String keyWord) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		Vector<ManagementBean> mlist = new Vector<ManagementBean>();

		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a\r\n" + "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO\r\n" + "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n" + "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n";

			if (!keyWord.contains(" ")) {
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

			while (rs.next()) {
				ManagementBean mbean = new ManagementBean();

				mbean.setMEM_NAME(rs.getString("MEM_NAME"));
				mbean.setPART_TYPE(rs.getString("PART_TYPE"));
				mlist.add(mbean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return mlist;
	}


	public boolean readState(String fromPartType, String fromName, String userPartType, String userName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
	
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM CHAT WHERE CHAT_TOPARTTYPE = ?\r\n"
					+ "AND CHAT_TONAME = ?\r\n"
					+ "AND CHAT_FROMPARTTYPE = ?\r\n"
					+ "AND CHAT_FROMNAME = ?\r\n"
					+ "AND CHAT_READ = ?\r\n";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromPartType);
			pstmt.setString(2, fromName);		
			pstmt.setString(3, userPartType);
			pstmt.setString(4, userName);	
			pstmt.setString(5, "안읽음");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return false;
	}

	// PK 키 정렬 초기화를 위한 함수
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

			sql = "SELECT * FROM CHAT WHERE\r\n" + "((CHAT_TOPARTTYPE = ? AND CHAT_TONAME = ?) AND\r\n"
					+ "(CHAT_FROMPARTTYPE = ? AND CHAT_FROMNAME = ?)) OR\r\n"
					+ "((CHAT_TOPARTTYPE = ? AND CHAT_TONAME = ?) AND\r\n"
					+ "(CHAT_FROMPARTTYPE = ? AND CHAT_FROMNAME = ?))\r\n" + "ORDER BY CHAT_TIME";

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

			while (rs.next()) {
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
	
	public void setRead(String toPartType, String toName, String fromPartType, String fromName) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		try {
			con = pool.getConnection();

			sql = "UPDATE CHAT SET CHAT_READ = ? WHERE CHAT_TOPARTTYPE = ?\r\n" 
					+ "AND CHAT_TONAME = ?\r\n"
					+ "AND CHAT_FROMPARTTYPE = ?\r\n"
					+ "AND CHAT_FROMNAME = ?\r\n";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "읽음");
			pstmt.setString(2, fromPartType);
			pstmt.setString(3, fromName);
			pstmt.setString(4, toPartType);
			pstmt.setString(5, toName);
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
		
	public boolean getRead(String fromPartType, String fromName) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
	
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM CHAT WHERE CHAT_TOPARTTYPE = ?\r\n"
					+ "AND CHAT_TONAME = ?\r\n"
					+ "AND CHAT_READ = ?\r\n";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromPartType);
			pstmt.setString(2, fromName);		
			pstmt.setString(3, "안읽음");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return false;
	}
}
