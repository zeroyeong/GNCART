package alert;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
	}	
}

