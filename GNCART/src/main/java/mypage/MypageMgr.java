package mypage;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	public Vector<MypageBean> memberFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		Vector<MypageBean> vlist = new Vector<MypageBean>();

		try {
			con = pool.getConnection();

			sql = "select * from member a join part b join level c ON a.PART_NO=b.PART_NO and a.LE_NO=c.LE_NO where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				MypageBean bean = new MypageBean();

				bean.setMEM_IMG(rs.getString("MEM_IMG"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				bean.setLE_LEVEL(rs.getString("LE_LEVEL"));
				bean.setMEM_NO(rs.getString("MEM_NO"));
				bean.setMEM_DATE(rs.getString("MEM_DATE"));

				vlist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
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

	// partType 찾기
	public String partTypeFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String partType = null;
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM member a JOIN part b ON a.PART_NO=b.PART_NO WHERE MEM_ID=? AND MEM_PW=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

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

	// level 찾기
	public String levelFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String level = null;
		try {
			con = pool.getConnection();

			sql = "SELECT * FROM member a JOIN level b ON a.LE_NO=b.LE_NO WHERE MEM_ID=? AND MEM_PW=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

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

	// img 찾기
	public String imgFind(String id, String pw) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		String name = null;
		try {
			con = pool.getConnection();

			sql = "select MEM_IMG from member where MEM_ID = ? and MEM_PW = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				name = rs.getString("MEM_IMG");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return name;
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



	// img 수정
	public void updateImg(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		// SAVEFOLDER, ENCTYPE, MAXSIZE 지정
		String SAVEFOLDER = session.getServletContext().getRealPath("/management/filestorage");
		String ENCTYPE = "UTF-8";
		int MAXSIZE = 10 * 1024 * 1024;

		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;

		MultipartRequest multi = null; // 이미지 업로드 위한 객체

		String img = null; // 이미지 이름

		try {
			con = pool.getConnection();

			File file = new File(SAVEFOLDER);

			if (!file.exists()) {
				file.mkdirs();
			}

			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("file") != null) {
				img = multi.getFilesystemName("file");
			}
			
			session.removeAttribute("memImg");
			session.setAttribute("memImg", img);

			sql = "update member set MEM_IMG = ? where MEM_ID = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, img);
			pstmt.setString(2, (String) session.getAttribute("idKey"));

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}