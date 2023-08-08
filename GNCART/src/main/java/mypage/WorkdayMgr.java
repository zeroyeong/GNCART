package mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBConnectionMgr;

public class WorkdayMgr {

	private DBConnectionMgr pool = null;

	public WorkdayMgr() {

		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Error : 커넥션 얻어오기 실패");
		}
	}

	// memNo 찾기
	public String memNoFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String memNo = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_NO from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				memNo = rs.getString("MEM_NO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return memNo;
	}

	// 출근하기
	public void workStart(String start, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "INSERT workday(WORKD_START, MEM_NO) VALUES (?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, memNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 퇴근하기
	public void workEnd(String end, String workdNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update workday set WORKD_END = ? where WORKD_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, end);
			pstmt.setString(2, workdNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 출근 기록 찾기
	public String workdStartFind(String workdNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;

		String start = null;
		try {
			con = pool.getConnection();

			sql = "select WORKD_START from workday where WORKD_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, workdNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				start = rs.getString("WORKD_START");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return start;
	}

	// 퇴근 기록 찾기
	public String workdEndFind(String workdNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;

		String end = null;
		try {
			con = pool.getConnection();

			sql = "select WORKD_END from workday where WORKD_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, workdNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				end = rs.getString("WORKD_END");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return end;
	}

	// 출근 기록으로 WORKD_NO 찾기
	public String workdNoStartFind(String start, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;

		String workdNo = null;
		try {
			con = pool.getConnection();

			sql = "select * from workday where WORKD_START like ? and MEM_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + start + "%");
			pstmt.setString(2, memNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				workdNo = rs.getString("WORKD_NO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return workdNo;
	}

	// 퇴근 기록으로 WORKD_NO 찾기
	public String workdNoEndFind(String end, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String endNo = null;

		try {
			con = pool.getConnection();

			sql = "select WORKD_NO from workday where MEM_NO = ? and WORKD_END like ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memNo);
			pstmt.setString(2, "%" + end + "%");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				endNo = rs.getString("WORKD_NO");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return endNo;
	}

	// VAC_NO 찾기
	public String vacNoFind(String sdate, String edate, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String vacNo = null;

		try {
			con = pool.getConnection();

			sql = "SELECT * FROM authvacation a JOIN authdocument b ON a.VAC_NO=b.VAC_NO WHERE VAC_SDATE=? and VAC_EDATE =? and MEM_NO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			pstmt.setString(3, memNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				vacNo = rs.getString("VAC_NO");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vacNo;
	}

	// VAC_SDATE 찾기
	public String vacSdateFind(String vacNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String vacSdate = null;

		try {
			con = pool.getConnection();

			sql = "select VAC_SDATE from authvacation where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vacNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				vacSdate = rs.getString("VAC_SDATE");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vacSdate;
	}

	// VAC_EDATE 찾기
	public String vacEdateFind(String vacNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String vacEdate = null;

		try {
			con = pool.getConnection();

			sql = "select VAC_EDATE from authvacation where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vacNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				vacEdate = rs.getString("VAC_EDATE");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vacEdate;
	}

	// VAC_REASON 찾기
	public String vacReasonFind(String vacNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String vacReason = null;

		try {
			con = pool.getConnection();

			sql = "select VAC_REASON from authvacation where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vacNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				vacReason = rs.getString("VAC_REASON");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vacReason;
	}

	// workday에 WORKD_START와 VAC_NO 넣기(WORK_NO도 자동으로 생성, 휴가 기록 삽입)
	public void workdayVac(String start, String vacNo, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "INSERT workday(WORKD_START, VAC_NO, MEM_NO) VALUES (?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, vacNo);
			pstmt.setString(3, memNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// workday VAC_NO 찾기
	public String workdVacNoFind(String start, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String workdVacNo = null;

		try {
			con = pool.getConnection();

			sql = "select VAC_NO from workday where MEM_NO = ? and WORKD_START like ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memNo);
			pstmt.setString(2, "%" + start + "%");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				workdVacNo = rs.getString("VAC_NO");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return workdVacNo;
	}

	// workday에서 휴가 삭제하기
	public void workRestDelete(String workdNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "delete from workday where WORKD_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, workdNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// authdocument에서 휴가 삭제하기
	public void authdoucumentDelete(String vacNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "delete from authdocument where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vacNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// authvacation에서 휴가 삭제하기
	public void authvacationDelete(String vacNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "delete from authvacation where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vacNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// authvacation 휴가 취소하기
	public void authvacationCancel(String minusDay, String vacNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update authvacation set VAC_EDATE = ? where VAC_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, minusDay);
			pstmt.setString(2, vacNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// workday 휴가 취소하고 출근하기
	public void workRestCancel(String start, String workdNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update workday set VAC_NO = null, WORKD_START = ?, WORKD_END = null where WORKD_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, workdNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}