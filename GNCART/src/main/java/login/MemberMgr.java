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

            sql = "SELECT MEM_NO, MEM_ID, MEM_NAME, MEM_DATE, MEM_MAIL, MEM_PHONE, MEM_ADD, MEM_BIRTH, MEM_ADN, AC_NO, WORK_NO, PART_NO, LE_NO FROM member WHERE MEM_ID = ? AND MEM_PW = ?";
 
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);

            rs = pstmt.executeQuery();
            flag = rs.next();

            if (flag) {
            	String memNo = rs.getString("MEM_NO");
                String memId = rs.getString("MEM_ID");
                String memName = rs.getString("MEM_NAME");
                String memDate = rs.getString("MEM_DATE");
                String memMail = rs.getString("MEM_MAIL");
                String memPhone = rs.getString("MEM_PHONE");
                String memAdd = rs.getString("MEM_ADD");
                String memBirth = rs.getString("MEM_BIRTH");
                String memAdn = rs.getString("MEM_ADN");
                String acNo = rs.getString("AC_NO");
                String workNo = rs.getString("WORK_NO");
                String partNo = rs.getString("PART_NO");
                String leNo = rs.getString("LE_NO");
                
                session.setAttribute("memNo", memNo);
                session.setAttribute("memId", memId);
                session.setAttribute("memName", memName);
                session.setAttribute("memDate", memDate);
                session.setAttribute("memMail", memMail);
                session.setAttribute("memPhone", memPhone);
                session.setAttribute("memAdd", memAdd);
                session.setAttribute("memBirth", memBirth);
                session.setAttribute("memAdn", memAdn);
                session.setAttribute("acNo", acNo);
                session.setAttribute("workNo", workNo);
                session.setAttribute("partNo", partNo);
                session.setAttribute("leNo", leNo);
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
