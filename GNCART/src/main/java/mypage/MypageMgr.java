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
	
	// MEM_NO로 name 찾기
		public String memNoNameFind(String memNo) {

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String sql = null;
			String name = null;
			try {
				con = pool.getConnection();

				sql = "select MEM_NAME from member where MEM_NO = ?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memNo);

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
		
		// MEM_NO로 입사일 찾기
		public String memNoDateFind(String memNo) {

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String sql = null;
			String name = null;
			try {
				con = pool.getConnection();

				sql = "select MEM_DATE from member where MEM_NO = ?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memNo);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					name = rs.getString("MEM_DATE");
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return name;
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
} 