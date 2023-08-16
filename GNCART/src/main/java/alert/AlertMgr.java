package alert;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import common.DBConnectionMgr;

public class AlertMgr {


	private DBConnectionMgr pool;

	public AlertMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void insertAlert(AlertBean bean) {

		Connection con = null; 
		PreparedStatement pstmt = null; 
		String sql = null; 


		AlertBean abean = new AlertBean();
		abean = bean;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO ALERT(ALERT_FROM, ALERT_TO, ALERT_MESSAGE, ALERT_STATE)";
			sql += " values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, 	abean.getALERT_FROM());
			pstmt.setString(2, abean.getALERT_TO());
			pstmt.setString(3, abean.getALERT_MESSAGE());
			pstmt.setString(4, abean.getALERT_STATE());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		PKkeySort();
	}
	
	public Vector<AlertBean> checkAlert(String myName) {
		Connection con = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		String sql = null; 
		
		Vector<AlertBean> alist = new Vector<AlertBean>();

		try {
			con = pool.getConnection();
			sql = "SELECT * FROM ALERT  WHERE ALERT_STATE = ? AND ALERT_TO = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "안읽음");
			pstmt.setString(2, myName);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				AlertBean abean = new AlertBean();
				abean.setALERT_NO(rs.getInt("ALERT_NO"));
				abean.setALERT_FROM(rs.getString("ALERT_FROM"));
				abean.setALERT_MESSAGE(rs.getString("ALERT_MESSAGE"));

				alist.add(abean);
			}

			return alist;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return alist;
	}
	
	public void updateAlert(int alertNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "UPDATE ALERT SET ALERT_STATE = ? WHERE ALERT_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "읽음");
			pstmt.setInt(2, alertNo);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public void PKkeySort() {

		Connection con = null;

		PreparedStatement pstmtIncrement = null;
		PreparedStatement pstmtCnt = null;
		PreparedStatement pstmtUpdate = null;

		String sql = null;

		try {
			con = pool.getConnection();

			sql = "ALTER TABLE ALERT AUTO_INCREMENT = 1";
			pstmtIncrement = con.prepareStatement(sql);
			pstmtIncrement.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmtCnt = con.prepareStatement(sql);
			pstmtCnt.executeUpdate();

			sql = "UPDATE ALERT SET ALERT_NO = @COUNT:=@COUNT+1";
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

