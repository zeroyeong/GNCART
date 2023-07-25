package mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBConnectionMgr;

public class MypageMgr {

	private DBConnectionMgr pool = null;

	public MypageMgr() {

		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Error : 커넥션 얻어오기 실패");
		}
	}

	// name 찾기
	public String nameFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String name = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_NAME from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				name = rs.getString("MEM_NAME");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return name;
	}

	// partNo 찾기
	public String partNoFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String partNo = null;
		try {
			con = pool.getConnection();

			sql = "select PART_NO from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				partNo = rs.getString("PART_NO");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return partNo;
	}

	// partType 찾기
	public String partTypeFind(String partNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String partType = null;
		try {
			con = pool.getConnection();

			sql = "select PART_TYPE from part where PART_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, partNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				partType = rs.getString("PART_TYPE");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return partType;
	}

	// leNo 찾기
	public String leNoFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String leNo = null;
		try {
			con = pool.getConnection();

			sql = "select LE_NO from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				leNo = rs.getString("LE_NO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return leNo;
	}

	// level 찾기
	public String levelFind(String leNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String level = null;
		try {
			con = pool.getConnection();

			sql = "select LE_LEVEL from level where LE_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, leNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				level = rs.getString("LE_LEVEL");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return level;
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

	// date 찾기
	public String dateFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String date = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_DATE from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				date = rs.getString("MEM_DATE");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return date;
	}

	// phone 찾기
	public String phoneFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String phone = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_PHONE from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				phone = rs.getString("MEM_PHONE");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return phone;
	}

	// mail 찾기
	public String mailFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String mail = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_MAIL from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mail = rs.getString("MEM_MAIL");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mail;
	}

	// birth 찾기
	public String birthFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String birth = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_BIRTH from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				birth = rs.getString("MEM_BIRTH");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return birth;
	}

	// add 찾기
	public String addFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String add = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_ADD from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				add = rs.getString("MEM_ADD");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return add;
	}

	// 전화번호 수정
	public void updatePhone(MypageBean bean, String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			// update 쿼리로 게시물을 수정한다.
			// id로 수정할 전화번호를 찾아서 phone 컬럼을 수정한다.
			sql = "update member set MEM_PHONE = ? where MEM_ID = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMEM_PHONE());
			pstmt.setString(2, id);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 메일 수정
	public void updateMail(MypageBean bean, String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update member set MEM_MAIL = ? where MEM_ID = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMEM_MAIL());
			pstmt.setString(2, id);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 생년월일 수정
	public void updateBirth(MypageBean bean, String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update member set MEM_BIRTH = ? where MEM_ID = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMEM_BIRTH());
			pstmt.setString(2, id);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 주소 수정
	public void updateAdd(MypageBean bean, String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update member set MEM_ADD = ? where MEM_ID = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMEM_ADD());
			pstmt.setString(2, id);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 비밀번호 수정
	public void updatePw(MypageBean bean, String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update member set MEM_PW = ? where MEM_ID = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMEM_PW());
			pstmt.setString(2, id);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 출근하기
	public void workStart(String start, String no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "INSERT workday(WORKD_START, MEM_NO) VALUES (?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, no);

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

	// 휴가 취소하고 출근하기
	public void workRestStart(String start, String workdNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update workday set AUTHLS_NO = null, WORKD_START = ?, WORKD_END = null where WORKD_NO = ?";

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

	// WORKD_NO 찾기
	public String workdNoFind(String start, String memNo) {

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

	// AUTHLS_NO 찾기
	public String authlsNoFind(String start, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;

		String authlsNo = null;
		try {
			con = pool.getConnection();

			sql = "select * from workday where WORKD_START like ? and MEM_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + start + "%");
			pstmt.setString(2, memNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				authlsNo = rs.getString("AUTHLS_NO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return authlsNo;
	}

	// id pw 날짜로 WORKD_NO 찾기
	public String workdNo2Find(String start, String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;

		String workdNo = null;
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM workday A JOIN member B ON A.MEM_NO = B.MEM_NO"
					+ "WHERE WORKD_START LIKE ? and b.mem_id = ? and b.mem_pw = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + start + "%");
			pstmt.setString(2, id);
			pstmt.setString(3, pw);

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

	// id pw로 출근하기
	public void workStart2(String start, String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "INSERT INTO workday(MEM_NO, WORKD_START) VALUES("
					+ "(select member.MEM_NO from member WHERE mem_id = ? AND mem_pw = ?)," + "(?))";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, start);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// id pw start로 퇴근하기
	public void workEnd2(String end, String id, String pw, String start) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "UPDATE workday a SET WORKD_END = ? WHERE" + "WORKD_NO = (SELECT a.WORKD_NO FROM member b WHERE"
					+ "b.mem_id = ? AND b.mem_pw = ? AND a.WORKD_START LIKE ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, end);
			pstmt.setString(2, id);
			pstmt.setString(3, pw);
			pstmt.setString(4, "%" + start + "%");

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// id pw start로 휴가 취소하고 출근하기
	public void workRestStart2(String start, String id, String pw, String start2) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update workday a set AUTHLS_NO = null, WORKD_START = null, WORKD_END = NULL"
					+ "where WORKD_NO = (SELECT a.WORKD_NO FROM member b WHERE b.mem_id = ? AND b.mem_pw = ?"
					+ "AND a.MEM_NO = b.mem_no AND WORKD_START LIKE ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, id);
			pstmt.setString(3, pw);
			pstmt.setString(4, "%" + start2 + "%");

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}

	}

	// 휴가 기록 찾기
	public String restDayFind(String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		String restDay = null;

		try {
			con = pool.getConnection();

			sql = "select AUTHLS_DAY from authlist where MEM_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				restDay = rs.getString("AUTHLS_DAY");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return restDay;
	}
	
	//휴가 기록 삽입
	public void restDay(String restDay, String memNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "INSERT INTO workday(MEM_NO, WORKD_START) VALUES("
			+ "(select member.MEM_NO from member WHERE mem_id = ? AND mem_pw = ?),"
			+ "(?))";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, restDay);
			pstmt.setString(2, memNo);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}