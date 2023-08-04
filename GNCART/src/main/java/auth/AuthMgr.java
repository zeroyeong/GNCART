package auth;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import common.DBConnectionMgr;
import notice.NoticeBean;
import notice.UtilMgr;

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
		int LINE_NO = 0;

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
			
			sql = "select max(DOC_NO) from authdocument";	
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				DOC_NO = rs.getInt("max(DOC_NO)")+1;

			sql = "insert authdocument(DOC_NO,DOC_NAME,DOC_TYPE,DOC_STATES,DOC_REGDATE,DOC_APPTURN,VAC_NO,MEM_NO,LINE_NO)";
			sql += " values(?, '휴가신청합니다', 1, 0, now(), 0, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, DOC_NO);
			pstmt.setInt(2, VAC_NO);
			pstmt.setInt(3, MEM_NO);
			pstmt.setInt(4, LINE_NO);

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
		int LINE_NO = 0;

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

			sql = "select max(DOC_NO) from authdocument";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				DOC_NO = rs.getInt("max(DOC_NO)")+1;

			sql = "insert authdocument(DOC_NO,DOC_NAME,DOC_TYPE,DOC_STATES,DOC_REGDATE,DOC_APPTURN,BUS_NO,MEM_NO,LINE_NO)";
			sql += " values(?, '업무보고합니다', 2, 0, now(), 0, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, DOC_NO);
			pstmt.setInt(2, BUS_NO);
			pstmt.setInt(3, MEM_NO);
			pstmt.setInt(4, LINE_NO);

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
				bean.setDOC_TYPE(rs.getInt("DOC_TYPE"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setDOC_STATES(rs.getInt("DOC_STATES"));
				bean.setDOC_REGDATE(rs.getString("DOC_REGDATE"));
				bean.setDOC_APPDATE(rs.getString("DOC_APPDATE"));
				bean.setDOC_APPTURN(rs.getInt("DOC_APPTURN"));
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
	
	public AuthBean getAuth(int DOC_NO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		AuthBean bean = new AuthBean();

		try {
			con = pool.getConnection();
		    sql = "SELECT ad.DOC_NO, ad.DOC_NAME, ad.DOC_TYPE, ad.DOC_STATES, ad.DOC_REGDATE, ad.DOC_APPDATE, ad.DOC_APPTURN,"
		            + " m.MEM_NO, m.MEM_NAME, m.MEM_ID,"
		            + " av.VAC_NO, av.VAC_SDATE, av.VAC_EDATE, av.VAC_REASON, av.VAC_DETAIL,"
		            + " ab.BUS_NO, ab.BUS_DETAIL, ab.BUS_SPECIAL,"
		            + " al.LINE_NO, al.LINE_FIRST, al.LINE_FIRST_APPDATE, al.LINE_SECOND, al.LINE_SECOND_APPDATE,"
		            + " l.LE_LEVEL, p.part_type"
		            + " FROM AUTHDOCUMENT ad"
		            + " JOIN MEMBER m ON ad.MEM_NO = m.MEM_NO"
		            + " LEFT JOIN AUTHVACATION av ON ad.VAC_NO = av.VAC_NO"
		            + " LEFT JOIN AUTHBUSINESS ab ON ad.BUS_NO = ab.BUS_NO"
		            + " JOIN AUTHLINE al ON ad.LINE_NO = al.LINE_NO"
		            + " JOIN `LEVEL` l ON m.LE_NO = l.LE_NO"
		            + " JOIN `PART` p ON m.PART_NO = p.part_no"
		            + " WHERE ad.DOC_NO = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, DOC_NO);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setDOC_NO(rs.getInt("DOC_NO"));
				bean.setDOC_NAME(rs.getString("DOC_NAME"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setVAC_SDATE(rs.getString("VAC_SDATE"));
				bean.setVAC_EDATE(rs.getString("VAC_EDATE"));
				bean.setVAC_REASON(rs.getInt("VAC_REASON"));
				bean.setVAC_DETAIL(rs.getString("VAC_DETAIL"));
				bean.setLE_LEVEL(rs.getString("LE_LEVEL"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				bean.setBUS_DETAIL(rs.getString("BUS_DETAIL"));
				bean.setBUS_SPECIAL(rs.getString("BUS_SPECIAL"));
				bean.setLINE_NO(rs.getInt("LINE_NO"));
				bean.setLINE_FIRST(rs.getString("LINE_FIRST"));
				bean.setLINE_SECOND(rs.getString("LINE_SECOND"));
				bean.setDOC_APPTURN(rs.getInt("DOC_APPTURN"));
				bean.setVAC_NO(rs.getInt("VAC_NO"));
				bean.setMEM_ID(rs.getString("MEM_ID"));		
				bean.setBUS_NO(rs.getInt("BUS_NO"));
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return bean;
	}
	
	public void AuthFirst(int LINE_NO) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    try {
	        con = pool.getConnection();

	        sql = "update authline set LINE_FIRST_APPDATE=? where LINE_NO=?";
	        pstmt = con.prepareStatement(sql);

	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String formattedNow = now.format(formatter);

	        pstmt.setString(1, formattedNow);
	        pstmt.setInt(2, LINE_NO);
	        pstmt.executeUpdate();
	        
	        pstmt.close();
	        pstmt = null;

	        sql = "update authdocument set DOC_APPTURN=?,DOC_STATES =? where DOC_NO=?";
	        pstmt = con.prepareStatement(sql);
	        
	        pstmt.setInt(1, 1);
	        pstmt.setInt(2, 1);
	        pstmt.setInt(3, LINE_NO);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) {
	                pstmt.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        pool.freeConnection(con);
	    }
	}	
	public void AuthSecond(int LINE_NO) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    
	    try {
	        con = pool.getConnection();

	        sql = "update authline set LINE_SECOND_APPDATE=? where LINE_NO=?";

	        pstmt = con.prepareStatement(sql);

	        LocalDateTime now = LocalDateTime.now();

	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String formattedNow = now.format(formatter);

	        pstmt.setString(1, formattedNow);
	        pstmt.setInt(2, LINE_NO);
	        pstmt.executeUpdate();
	        
	        pstmt.close();
	        pstmt = null;

	        sql = "update authdocument set DOC_APPTURN=?,DOC_APPDATE=?,DOC_STATES=? where DOC_NO=?";
	        pstmt = con.prepareStatement(sql);
	        
	        pstmt.setInt(1, 2);
	        pstmt.setString(2, formattedNow);
	        pstmt.setInt(3, 3);
	        pstmt.setInt(4, LINE_NO);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) {
	                pstmt.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        pool.freeConnection(con);
	    }
	}	
	public void AuthReject(int DOC_NO) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    int states = 2;

	    try {
	        con = pool.getConnection();
	        sql = "update authdocument set DOC_STATES=? where DOC_NO=?";

	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, states);
	        pstmt.setInt(2, DOC_NO);

	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	public void vacDelete(int LINE_NO, int VAC_NO) {

		Connection con = null;

		PreparedStatement pstmt = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();
			sql = "select * from authline where LINE_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, LINE_NO);
			rs = pstmt.executeQuery();

			sql = "delete from authline where LINE_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, LINE_NO);
			pstmt.executeUpdate();
			
			sql = "select * from authvacation where VAC_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, VAC_NO);
			rs = pstmt.executeQuery();

			sql = "delete from authvacation where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, VAC_NO);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public void busDelete(int LINE_NO, int BUS_NO) {

		Connection con = null;

		PreparedStatement pstmt = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();
			sql = "select * from authline where LINE_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, LINE_NO);
			rs = pstmt.executeQuery();

			sql = "delete from authline where LINE_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, LINE_NO);
			pstmt.executeUpdate();
			
			sql = "select * from authbusiness where BUS_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, BUS_NO);
			rs = pstmt.executeQuery();

			sql = "delete from authbusiness where BUS_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, BUS_NO);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

}
