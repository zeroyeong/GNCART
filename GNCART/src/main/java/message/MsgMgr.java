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

public class MsgMgr {

	private DBConnectionMgr pool;
	// 파일 업로드 관련 설정 작성

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

			sql = "SELECT * FROM MESSAGE WHERE MSG_FROMNAME = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromName);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MsgBean bean = new MsgBean();
				bean.setMsg_no(rs.getInt("msg_no"));
				bean.setMsg_toname(rs.getString("msg_toname"));
				bean.setMsg_title(rs.getString("msg_title"));
				bean.setMsg_sendtime(rs.getString("msg_sendtime"));

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

			sql = "SELECT * FROM MESSAGE WHERE MSG_TONAME = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, toName);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MsgBean bean = new MsgBean();
				bean.setMsg_no(rs.getInt("msg_no"));
				bean.setMsg_fromname(rs.getString("msg_fromname"));
				bean.setMsg_title(rs.getString("msg_title"));
				bean.setMsg_sendtime(rs.getString("msg_sendtime"));

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
		try {
			con = pool.getConnection();		

			sql = "INSERT INTO MESSAGE (MSG_TITLE, MSG_CONTENT, MSG_TONAME, MSG_FROMNAME, MSG_SENDTIME, MSG_READTIME, MSG_READ)"
					+ "VALUES(?, ?, ?, ?, now(), ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("msg_title"));
			pstmt.setString(2, req.getParameter("msg_content"));
			pstmt.setString(3, req.getParameter("msg_toname"));
			pstmt.setString(4, req.getParameter("msg_fromname"));
			pstmt.setString(5, "읽은 시간");
			pstmt.setString(6, "읽음 안읽음 표시");
			// pstmt.setString(7, req.getParameter("part_type"));

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
				bean.setMsg_toname(rs.getString("MSG_TONAME"));
				bean.setMsg_fromname(rs.getString("MSG_FROMNAME"));
				bean.setMsg_sendtime(rs.getString("MSG_SENDTIME"));
				bean.setMsg_readtime(rs.getString("MSG_READTIME"));
				bean.setMsg_read(rs.getString("MSG_READ"));

				return bean;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return bean;
	}

	public void deleteMsg(int msg_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;

		String sql = null;

		try {
			con = pool.getConnection();

			sql = "DELETE FROM MESSAGE WHERE MSG_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msg_no);
			pstmt.executeUpdate();

			PKkeySort();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);

		}

	}

	public void deleteMsg(String checkedList[]) {

		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;

		try {
			con = pool.getConnection();

			for (String check : checkedList) {

				sql = "DELETE FROM MESSAGE WHERE MSG_NO = ?";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, Integer.parseInt(check));
				pstmt.executeUpdate();
				pstmt.clearParameters();
			}

			PKkeySort();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
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
}
