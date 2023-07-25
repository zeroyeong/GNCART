package familyEvent;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.DBConnectionMgr;

public class ConMgr {

	private DBConnectionMgr pool;
	// 파일 업로드 관련 설정 작성
	private static final String SAVEFOLDER = "C:/gnctest/gnc0717a/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5 * 1024 * 1024;

	public String savefolder = SAVEFOLDER;
	public String enctype = ENCTYPE;
	public int maxsize = MAXSIZE;

	public ConMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
	public Vector<ConBean> getBoardList() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;

		Vector<ConBean> blist = new Vector<ConBean>();

		try {
			con = pool.getConnection();

			sql = "SELECT * FROM CONDOLENCES";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ConBean bean = new ConBean();
				bean.setCon_no(rs.getInt("con_no"));
				bean.setCon_title(rs.getString("con_title"));
				bean.setCon_regdate(rs.getString("con_regdate"));
				bean.setCon_hit(rs.getInt("con_hit"));
				bean.setMem_name(rs.getString("mem_name"));

				blist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return blist;
	}

	// 총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();

			// keyField , keyWord 값이 없는 경우 총 게시물 가져오기
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(num) from tblBoard";
				pstmt = con.prepareStatement(sql);
			} else { // keyField, keyWord 값이 있는 경우 총 게시물 가져오기
				sql = "select count(num) from  tblBoard where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 게시물 입력
	public ConBean insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = null;

		MultipartRequest multi = null;

		int filesize = 0;

		String filename = null;

		ConBean bean = new ConBean();
		try {
			con = pool.getConnection();

			File file = new File(SAVEFOLDER);
			if (!file.exists())
				file.mkdirs();
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			} else {
				filename = "";
			}
			String content = multi.getParameter("content");
			content = UtilMgr.replace(content, "<", "&lt;");

			int con_no = getNext();

			sql = "INSERT INTO CONDOLENCES (CON_NO, CON_TITLE, CON_CONTENT, CON_TYPE, CON_REGDATE, CON_DESDATE, CON_LOCATION, CON_MAP, CON_FILE, CON_HIT, MEM_NO, MEM_NAME, PART_TYPE)";
			sql += "values(?, ?, ?, ?, now(), ?, ?, ?, ?, ?, ? ,? ,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, con_no);
			pstmt.setString(2, multi.getParameter("title"));
			pstmt.setString(3, multi.getParameter("content"));
			pstmt.setString(4, multi.getParameter("type"));
			pstmt.setString(5, multi.getParameter("desdate"));
			pstmt.setString(6, multi.getParameter("location"));
			pstmt.setString(7, multi.getParameter("map"));
			pstmt.setString(8, filename);
			pstmt.setInt(9, 88);
			pstmt.setInt(10, 99);
			pstmt.setString(11, "지금 로그인된 사람");
			pstmt.setString(12, "인사팀");
			// 맵추가

			pstmt.executeUpdate();

			bean.setCon_no(con_no);

			return bean;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return null;
	}

	// TODO 등록순서를 위한 함수
	public int getNext() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "SELECT CON_NO FROM CONDOLENCES ORDER BY CON_NO DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1;
	}

	public ConBean getBoard(int con_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConBean bean = new ConBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM CONDOLENCES WHERE CON_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, con_no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setCon_title(rs.getString("con_title"));
				bean.setCon_content(rs.getString("con_content"));
				bean.setCon_regdate(rs.getString("con_regdate"));
				bean.setCon_type(rs.getString("con_type"));
				bean.setCon_location(rs.getString("con_location"));
				bean.setCon_desdate(rs.getString("con_desdate"));
				bean.setCon_map(rs.getString("con_map"));
				bean.setCon_file(rs.getString("con_file"));
				bean.setCon_hit(rs.getInt("con_hit"));
				bean.setMem_name(rs.getString("mem_name"));
			}
//			int num = bean.getCon_no();
//			String title = bean.getCon_title();
//			String regdate = bean.getCon_regdate();
//			String wtriter = bean.getMem_name();
//			int hit = bean.getCon_hit();

			return bean;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}

	// 게시물 수정
	public ConBean updateBoard(HttpServletRequest req) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		MultipartRequest multi = null;

		int filesize = 0;

		String filename = null;

		ConBean upBean = new ConBean();

		try {
			con = pool.getConnection();

			File file = new File(SAVEFOLDER);
			if (!file.exists())
				file.mkdirs();

			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			} else {
				filename = "";
				if (multi.getParameter("af") != null) {
					filename = multi.getParameter("af");
				}
			}

			// 이전파일 삭제
			String deleteFile = multi.getParameter("delFile");
			fileDelete(deleteFile);

			String content = multi.getParameter("content");
			content = UtilMgr.replace(content, "<", "&lt;");

			upBean.setCon_no(Integer.parseInt(multi.getParameter("con_no")));
			upBean.setCon_title(multi.getParameter("title"));
			upBean.setCon_content(multi.getParameter("content"));
			upBean.setCon_type(multi.getParameter("type"));
			// upBean.setCon_regdate(multi.getParameter("regdate"));
			upBean.setCon_location(multi.getParameter("location"));
			upBean.setCon_desdate(multi.getParameter("desdate"));
			upBean.setCon_map(multi.getParameter("map"));
			upBean.setCon_file(filename);
			// upBean.setCon_hit(Integer.parseInt(multi.getParameter("hit")));
			// upBean.setCon_writer(multi.getParameter("writer"));

			sql = "UPDATE CONDOLENCES SET CON_TITLE=?, CON_CONTENT=?, CON_TYPE=?, CON_LOCATION=?, CON_DESDATE=?, CON_MAP=?, CON_FILE=? WHERE CON_NO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upBean.getCon_title());
			pstmt.setString(2, upBean.getCon_content());
			pstmt.setString(3, upBean.getCon_type());
			pstmt.setString(4, upBean.getCon_location());
			pstmt.setString(5, upBean.getCon_desdate());
			pstmt.setString(6, upBean.getCon_map());
			pstmt.setString(7, upBean.getCon_file());
			pstmt.setInt(8, upBean.getCon_no());

			pstmt.executeUpdate();

			return upBean;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return upBean;
	}

	public void updateBoard5555(ConBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "UPDATE CONDOLENCES SET CON_TITLE=?, CON_CONTENT=?, CON_TYPE=?, CON_LOCATION=?, CON_DESDATE=?, CON_FILE=? WHERE CON_NO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCon_title());
			pstmt.setString(2, bean.getCon_content());
			pstmt.setString(3, bean.getCon_type());
			pstmt.setString(4, bean.getCon_location());
			pstmt.setString(5, bean.getCon_desdate());
			pstmt.setString(6, bean.getCon_file());
			pstmt.setInt(7, bean.getCon_no());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 조회수 증가
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard set count=count+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 게시물 삭제 메서드
	public void deleteBoard(int con_no) {

		Connection con = null;

		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();
			sql = "SELECT CON_FILE FROM CONDOLENCES WHERE CON_NO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, con_no);
			rs = pstmt.executeQuery();

			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists())
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			// num 을 이용하여 tblBoard 테이블의 컬럼을 찾아서 delete 쿼리문으로 해당 컬럼 삭제.
			sql = "DELETE FROM CONDOLENCES WHERE CON_NO=?";

			pstmt1 = con.prepareStatement(sql);
			pstmt1.setInt(1, con_no);
			pstmt1.executeUpdate();

			PKkeySort();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
			pool.freeConnection(con, pstmt1, rs);
		}
	}

	// 게시물 여러개 삭제 메서드
	public void deleteBoard(String checkedList[]) {

		Connection con = null;

		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();

			// con.setAutoCommit(false);
			sql = "SELECT CON_FILE FROM CONDOLENCES WHERE CON_NO=?";
			pstmt = con.prepareStatement(sql);

			for (String check : checkedList) {

				pstmt.setInt(1, Integer.parseInt(check));
				rs = pstmt.executeQuery();

				if (rs.next() && rs.getString(1) != null) {
					if (!rs.getString(1).equals("")) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if (file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}

				sql = "DELETE FROM CONDOLENCES WHERE CON_NO=?";

				pstmt1 = con.prepareStatement(sql);
				pstmt1.setInt(1, Integer.parseInt(check));
				pstmt1.executeUpdate();

				pstmt.clearParameters();
				pstmt1.clearParameters();
			}

			PKkeySort();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
			pool.freeConnection(con, pstmt1, rs);
		}
	}

	public void fileDelete(String deletefile) {

		if (deletefile != "" && deletefile != null) {
			File file = new File(SAVEFOLDER + "/" + deletefile);
			if (file.exists())
				UtilMgr.delete(SAVEFOLDER + "/" + deletefile);

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

			sql = "ALTER TABLE CONDOLENCES AUTO_INCREMENT = 1";
			pstmtIncrement = con.prepareStatement(sql);
			pstmtIncrement.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmtCnt = con.prepareStatement(sql);
			pstmtCnt.executeUpdate();

			sql = "UPDATE CONDOLENCES SET CON_NO = @COUNT:=@COUNT+1";
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
	

	// 파일 다운로드 메서드
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {

		try {
			// 요청 객체에 있는 filename 파라미터를 받아서 변수에 저장.
			String filename = req.getParameter("filename");

			// file 객체생성 , filename이 한글 일 경우 깨지지 않게 하기 위해서
			// UtilMgr 클래스의 con()메서드 호출하여 결과 값을 담는다.
			// BoardMgr 클래스 상단에 있는 savefoler 경로 와 file구분자, filename을 저장.
			File file = new File(UtilMgr.con(SAVEFOLDER + File.separator + filename));

			// file.length() 는 파일의 크기를 리턴 하며, 단위는 byte 임.
			byte b[] = new byte[(int) file.length()];

			// res.setHeader() 메서드를 이용해서 response(응답) 객체의 header에 text를 추가.
			// 첫번째 인수가 key, 두번째 인수가 value 이다.
			res.setHeader("Accept-Ranges", "bytes");

			// req.getHeader() 메서드를 이용해서 요청 객체의 클라이언트 브라우저 정보를 strClient 변수에 저장.
			String strClient = req.getHeader("User-Agent");

			// strClient 변수에 저장된 브라우저 정보를 indexOf 메서드로 검색.
			// 브라우저 정보에 MSIE 가 true 이면 ms사 의 브라우저, false 면 다른 브라우저로 인식.
			// 브라우저 의 버전과 정보를 구분해서 각 각 res(응답객체) 의 header 와 contentType을 설정한다.
			if (strClient.indexOf("MSIE6.0") != -1) {
				// indexOf() 메서드를 사용하여 일치하는 값이 없으면 -1을 반환한다.
				// 이 조건문 에서는 true 상황, 즉 일치하는 값이 있는 경우 아래 내용을 수행한다.
				res.setContentType("application/smnet;charset=UTF-8");

				res.setHeader("Content-Disposition", "filename=" + filename + ";");

			} else { // indexOf() 메서드 실행결과 일치하는 값이 없으면 아래 내용 수행.

				res.setContentType("application/smnet;charset=UTF-8");

				res.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
			}

			out.clear(); // out.clear() : out 객체의 모든 컨텐츠 지우기

			out = pageContext.pushBody(); // pageContext.pushBody() : jsp 페이지 정보 저장.

			if (file.isFile()) {
				// file.isFile() 메서드로 file 객체에 있는 savefolder 경로 와 filename이 일치 하면 true.

				// BufferedInputStream 객체를 생성하고, FileInputStream 을 이용하여 file을 읽어들여 저장한다.
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));

				out.clear();
				pageContext.pushBody();

				BufferedOutputStream outs = new BufferedOutputStream(res.getOutputStream());

				int read = 0;

				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}

				outs.close();

				fin.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
