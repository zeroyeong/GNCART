package index;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import common.DBConnectionMgr;
import schedule.ScheduleBean;

public class indexMgr {
	
	private DBConnectionMgr pool=null; //common 패키지의 pool 객체 선언
	
	public indexMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	/*___________전체 일정 리스트____________*/
	public Vector<ScheduleBean> getScheduleList(String year, String month){
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<ScheduleBean> vlist = new Vector<ScheduleBean>();
		
		try {
			con=pool.getConnection();
			
			sql="SELECT*FROM schedule a\r\n"
					+ "JOIN member b ON a.MEM_NO=b.MEM_NO\r\n"
					+ "JOIN scheduletype c ON a.TYPE_NO=c.TYPE_NO\r\n"
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "where SCHE_START_DATE like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+year+"-"+month+"%");
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ScheduleBean bean = new ScheduleBean();
				bean.setSCHE_NO(rs.getInt("SCHE_NO"));
				bean.setSCHE_NAME(rs.getString("SCHE_NAME"));
//				bean.setSCHE_DATE(rs.getString("SCHE_DATE"));
				bean.setSCHE_START_DATE(rs.getString("SCHE_START_DATE"));
//				bean.setSCHE_START_TIME(rs.getString("SCHE_START_TIME"));
				bean.setSCHE_END_DATE(rs.getString("SCHE_END_DATE"));
//				bean.setSCHE_END_TIME(rs.getString("SCHE_END_TIME"));
//				bean.setSCHE_DETAIL(rs.getString("SHCE_DETAIL"));
//				bean.setSCHE_FILE(rs.getString("SHCE_FILE"));
//				
//				bean.setMEM_NO(rs.getInt("MEM_NO"));
//				bean.setMEM_NAME(rs.getString("MEM_NAME"));
//				
//				bean.setTYPE_NO(rs.getInt("TYPE_NO"));
//				bean.setTYPE_TYPE(rs.getString("TYPE_TYPE"));
//				
//				bean.setPART_NO(rs.getInt("PART_NO"));
//				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				vlist.add(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return vlist;
	}
}