package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.DBConnectionMgr;

public class MemberMgr {
	private DBConnectionMgr pool;

	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 로그인 처리
	public boolean loginMember(String id, String pw, HttpServletRequest request) {
		HttpSession session = request.getSession();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;

		try {
			con = pool.getConnection();

			sql = "SELECT a.*, b.LE_LEVEL, p.part_type FROM member a JOIN level b ON a.LE_NO = b.LE_NO JOIN part p ON a.PART_NO = p.PART_NO WHERE MEM_ID = ? AND MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery(); 
			flag = rs.next();

			if (flag) {
				int memNo = rs.getInt("MEM_NO");
				String memId = rs.getString("MEM_ID");
				String memName = rs.getString("MEM_NAME");
				String memDate = rs.getString("MEM_DATE");
				String memTel = rs.getString("MEM_TEL");
				String memMail = rs.getString("MEM_MAIL");
				String memPhone = rs.getString("MEM_PHONE");
				String memAdd = rs.getString("MEM_ADD");
				String memBirth = rs.getString("MEM_BIRTH");
				String memAnd = rs.getString("MEM_AND");
				String memImg = rs.getString("MEM_IMG");
				int acNo = rs.getInt("AC_NO");
				int workNo = rs.getInt("WORK_NO");
				int partNo = rs.getInt("PART_NO");
				int leNo = rs.getInt("LE_NO");
				String leLevel = rs.getString("LE_LEVEL");
				String parttype = rs.getString("part_type");

				session.setAttribute("memNo", memNo);
				session.setAttribute("memId", memId);
				session.setAttribute("memName", memName);
				session.setAttribute("memDate", memDate);
				session.setAttribute("memTel", memTel);
				session.setAttribute("memMail", memMail);
				session.setAttribute("memPhone", memPhone);
				session.setAttribute("memAdd", memAdd);
				session.setAttribute("memBirth", memBirth);
				session.setAttribute("memAnd", memAnd);
				session.setAttribute("memImg", memImg);
				session.setAttribute("acNo", acNo);
				session.setAttribute("workNo", workNo);
				session.setAttribute("partNo", partNo);
				session.setAttribute("leNo", leNo);
				session.setAttribute("leLevel", leLevel);
				session.setAttribute("parttype", parttype);
			}

			session.setMaxInactiveInterval(-1);

			return flag;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return false;
	}

	// 비밀번호 변경
	public boolean resetPassword(String id, String newPw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "UPDATE member SET MEM_PW = ? WHERE MEM_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, newPw);
			pstmt.setString(2, id);

			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return false;
	}
}
