package auth;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import common.DBConnectionMgr;

public class AuthMgr {

	private DBConnectionMgr pool;

	public AuthMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void insertVAC(HttpServletRequest req) {
		Connection con = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		String sql = null; 

		int VAC_NO = 0;
		int VAC_REASON = Integer.parseInt(req.getParameter("VAC_REASON"));
		int MEM_NO = Integer.parseInt(req.getParameter("MEM_NO"));
		int DOC_NO = 0;

		try {
			con = pool.getConnection();
			sql = "select max(VAC_NO) from authvacation";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				VAC_NO = rs.getInt("max(VAC_NO)")+1;

			sql = "insert authvacation(VAC_NO,VAC_SDATE,VAC_EDATE,VAC_REASON,VAC_DETAIL)";
			sql += " values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, VAC_NO);
			pstmt.setString(2, req.getParameter("VAC_SDATE"));
			pstmt.setString(3, req.getParameter("VAC_EDATE"));
			pstmt.setInt(4, VAC_REASON);
			pstmt.setString(5, req.getParameter("VAC_DETAIL"));

			pstmt.executeUpdate();

			sql = "select max(DOC_NO) from authdocument";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				DOC_NO = rs.getInt("max(DOC_NO)")+1;

			sql = "insert authdocument(DOC_NO,DOC_NAME,DOC_TYPE,DOC_STATES,DOC_REGDATE,DOC_APPTURN,VAC_NO,MEM_NO)";
			sql += " values(?, '휴가신청합니다', 1, 0, now(), 0, ?, ?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, DOC_NO);
			pstmt.setInt(2, VAC_NO);
			pstmt.setInt(3, MEM_NO);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public void insertBUS(HttpServletRequest req) {
		Connection con = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		String sql = null; 

		int BUS_NO = 0;
		int MEM_NO = Integer.parseInt(req.getParameter("MEM_NO"));
		int DOC_NO = 0;

		try {
			con = pool.getConnection();
			sql = "select max(BUS_NO) from authbusiness";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				BUS_NO = rs.getInt("max(BUS_NO)")+1;

			sql = "insert authbusiness(BUS_NO,BUS_DETAIL,BUS_SPECIAL)";
			sql += " values(?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, BUS_NO);
			pstmt.setString(2, req.getParameter("BUS_DETAIL"));
			pstmt.setString(3, req.getParameter("BUS_SPECIAL"));

			pstmt.executeUpdate();

			sql = "select max(DOC_NO) from authdocument";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				DOC_NO = rs.getInt("max(DOC_NO)")+1;

			sql = "insert authdocument(DOC_NO,DOC_NAME,DOC_TYPE,DOC_STATES,DOC_REGDATE,DOC_APPTURN,BUS_NO,MEM_NO)";
			sql += " values(?, '업무보고합니다', 2, 0, now(), 0, ?, ?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, DOC_NO);
			pstmt.setInt(2, BUS_NO);
			pstmt.setInt(3, MEM_NO);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public Vector<AuthBean> getAuthList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AuthBean> vlist = new Vector<AuthBean>();

		try {
			con = pool.getConnection();
			sql = "SELECT * FROM authdocument INNER JOIN member ON member.MEM_NO = authdocument.MEM_NO ORDER BY DOC_NO DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AuthBean bean = new AuthBean();
				bean.setDOC_NO(rs.getInt("DOC_NO"));
				bean.setDOC_NAME(rs.getString("DOC_NAME"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setDOC_STATES(rs.getInt("DOC_STATES"));
				bean.setDOC_REGDATE(rs.getString("DOC_REGDATE"));
				bean.setDOC_APPDATE(rs.getString("DOC_APPDATE"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return vlist;
	}

	// 팀장 목록
	public ArrayList<String> getTeamLeaders() {
		ArrayList<String> teamLeaders = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a JOIN level b ON a.LE_NO=b.LE_NO WHERE LE_LEVEL = '팀장'";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String teamLeader = rs.getString("MEM_NAME");
				teamLeaders.add(teamLeader);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return teamLeaders;
	}

	//부장 목록
	public ArrayList<String> getManagers() {
		ArrayList<String> managers = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "SELECT*FROM member a JOIN level b ON a.LE_NO=b.LE_NO WHERE LE_LEVEL = '부장'";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String manager = rs.getString("MEM_NAME");
				managers.add(manager);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return managers;
	}

	public void insertLine(HttpServletRequest req) {
		Connection con = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		String sql = null; 

		int LINE_NO = 0;
		
		try {
			con = pool.getConnection();
			sql = "select max(LINE_NO) from authline";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				LINE_NO = rs.getInt("max(LINE_NO)")+1;

			sql = "insert authline(LINE_NO,LINE_FIRST,LINE_SECOND)";
			sql += " values(?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, LINE_NO);
			pstmt.setString(2, req.getParameter("LINE_FIRST"));
			pstmt.setString(3, req.getParameter("LINE_SECOND"));

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
}
