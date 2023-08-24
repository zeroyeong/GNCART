package freeBoard;

  
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.DBConnectionMgr;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	//파일 업로드 관련 설정 작성
	private static final String  SAVEFOLDER = "C:/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;

	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
   
	// 게시판 리스트
	public Vector<BoardBean> getBoardList() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<BoardBean> vlist = new Vector<BoardBean>();

		try {
			con = pool.getConnection();
			//keyWord 값이 없는 경우 게시물 조회
				sql = "select * from freeBoard F JOIN member M ON F.MEM_NO = M.MEM_NO ORDER BY FREE_NO DESC";
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setFREE_NO(rs.getInt("FREE_NO"));
				bean.setFREE_TITLE(rs.getString("FREE_TITLE"));
				bean.setFREE_HIT(rs.getInt("FREE_HIT"));
				bean.setFREE_DATE(rs.getString("FREE_DATE"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				
				vlist.add(bean);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return vlist;
	}
	

	// 게시물 입력 메서드
	// 게시물 입력 메서드는 리턴타입 이 void 이므로 반환값은 없다.
	public void insertBoard(HttpServletRequest req) {
		
		Connection con = null; //연결객체
		PreparedStatement pstmt = null; //쿼리처리객체
		ResultSet rs = null;  //결과값 담는 객체
		
		String sql = null; //쿼리문 저장 변수
		
		MultipartRequest multi = null; //파일 업로드 위한 객체
		
		int filesize = 0; //파일용량 변수
		
		String filename = null; //파일이름 변수
		
		try {
			con = pool.getConnection();
			sql = "select max(FREE_NO) from freeBoard"; //게시물이 총 몇개 인지 조회하는 쿼리
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
							
			File file = new File(SAVEFOLDER);
			
			//exists() 메서드 : 파일이 존재 하는지 여부를 알아 내는 메서드
			//파일이 존재 한다면 true, 없으면 false 값을 반환.
			if (!file.exists()) //파일이 존재 한다면
				file.mkdirs(); //mkdirs() : 파일 디렉토리 만드는 메서드 

				multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("FREE_FILENAME") != null) {
				filename = multi.getFilesystemName("FREE_FILENAME");
				filesize = (int) multi.getFile("FREE_FILENAME").length();
			}else {
				filename="";
			}
	
			String FREE_CONTENT = multi.getParameter("FREE_CONTENT");
	
			
		//	if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				//게시글 입력시 contentType 속성이 TEXT 라면 
				//UtilMgr 클래스 replace 메서드를 호출 하여 <(부등호) 를 &lt; 로 바꾼다.
			FREE_CONTENT = UtilMgr.replace(FREE_CONTENT, "<", "&lt;");
		//	}
			sql = "insert INTO freeBoard(FREE_NO,FREE_CONTENT,FREE_TITLE,FREE_DATE,FREE_HIT,FREE_FILENAME,FREE_FILESIZE,MEM_NO,PART_NO)";
			sql += "values(?, ?, ?, now(), 0, ?, ?, ?, ?)";
			//작성날짜 regdate 컬럼은 now() 로 현재 날짜를 자동으로 입력 합니다.
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, multi.getParameter("FREE_NO"));

			pstmt.setString(2, multi.getParameter("FREE_CONTENT"));
			pstmt.setString(3, multi.getParameter("FREE_TITLE"));
			pstmt.setString(4, filename);
			pstmt.setInt(5, filesize);
			pstmt.setInt(6, Integer.parseInt(multi.getParameter("MEM_NO")));
			pstmt.setInt(7, Integer.parseInt(multi.getParameter("PART_NO")));
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 게시물 리턴 메서드, 게시물의 num 값을 기준으로 해당 게시물을 조회한다.
	public BoardBean getBoard(int FREE_NO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		BoardBean bean = new BoardBean();
		
		try {
			con = pool.getConnection();
			//num 값을 기준으로 tblBoard 테이블 에서 게시물을 조회한다.
			
			sql = "SELECT * FROM freeBoard C JOIN member M ON C.MEM_NO = M.MEM_NO JOIN part p ON p.PART_NO = M.PART_NO WHERE FREE_NO = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, FREE_NO);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				bean.setFREE_NO(rs.getInt("FREE_NO"));
				bean.setFREE_TITLE(rs.getString("FREE_TITLE"));
				bean.setFREE_CONTENT(rs.getString("FREE_CONTENT"));
				bean.setFREE_DATE(rs.getString("FREE_DATE"));
				bean.setFREE_HIT(rs.getInt("FREE_HIT"));
				bean.setFREE_FILENAME(rs.getString("FREE_FILENAME"));
				bean.setFREE_FILESIZE(rs.getInt("FREE_FILESIZE"));
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setPART_NO(rs.getInt("PART_NO"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setMEM_NAME(rs.getString("MEM_NAME")); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// 조회수 증가 메서드
	public void upHit(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();
			int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));

			// 중복 조회를 체크하기 위해 쿠키를 읽어옵니다.
			Cookie[] cookies = request.getCookies();
			boolean cookchk = false;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("hit_" + FREE_NO)) {
						cookchk = true;
						break;
					}
				}
			}
			
			// 중복이 아닌 경우에만 조회수 증가
			if (!cookchk) {
				sql = "UPDATE freeBoard SET FREE_HIT=FREE_HIT+1 WHERE FREE_NO=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, FREE_NO);
				pstmt.executeUpdate();

				// 조회수 증가 기록을 쿠키에 저장합니다.
				Cookie hitCookie = new Cookie("hit_" + FREE_NO, "true");
				hitCookie.setMaxAge(24 * 60 * 60); // 쿠키 유효 기간을 설정 (예: 24시간)
				response.addCookie(hitCookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	// 게시물 삭제 메서드
	public void deleteBoard(int FREE_NO) {
		
			Connection con = null;
			
			PreparedStatement pstmt = null;
			
			String sql = null;
			
			ResultSet rs = null;
			
			try {
				con = pool.getConnection();
				sql = "select filename from freeBoard where FREE_NO = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, FREE_NO);
				rs = pstmt.executeQuery();
				
				if (rs.next() && rs.getString(1) != null) {
					if (!rs.getString(1).equals("")) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if (file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}
				//num 을 이용하여 tblBoard 테이블의 컬럼을 찾아서 delete 쿼리문으로 해당 컬럼 삭제. 
				sql = "delete from freeBoard where FREE_NO=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, FREE_NO);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
	
	//파일 다운로드 메서드
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
			
		try {
				//요청 객체에 있는 filename 파라미터를 받아서 변수에 저장.
				String filename = req.getParameter("filename");
				
				//file 객체생성 , filename이 한글 일 경우 깨지지 않게 하기 위해서
				//UtilMgr 클래스의 con()메서드 호출하여 결과 값을 담는다.
				//BoardMgr 클래스 상단에 있는 savefoler 경로 와 file구분자, filename을 저장.
				File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ filename));
				
				//file.length() 는 파일의 크기를 리턴 하며, 단위는 byte 임.
				byte b[] = new byte[(int) file.length()];
				
				//res.setHeader() 메서드를 이용해서 response(응답) 객체의 header에 text를 추가.
				//첫번째 인수가 key, 두번째 인수가 value 이다.
				res.setHeader("Accept-Ranges", "bytes");
				
				//req.getHeader() 메서드를 이용해서 요청 객체의 클라이언트 브라우저 정보를 strClient 변수에 저장.
				String strClient = req.getHeader("User-Agent");
					
				//strClient 변수에 저장된 브라우저 정보를 indexOf 메서드로 검색.
				//브라우저 정보에 MSIE 가 true 이면 ms사 의 브라우저, false 면 다른 브라우저로 인식.
				//브라우저 의 버전과 정보를 구분해서 각 각 res(응답객체) 의 header 와 contentType을 설정한다.
				if (strClient.indexOf("MSIE6.0") != -1) { 
					//indexOf() 메서드를 사용하여 일치하는 값이 없으면 -1을 반환한다. 
					//이 조건문 에서는 true 상황, 즉 일치하는 값이 있는 경우 아래 내용을 수행한다.
					res.setContentType("application/smnet;charset=UTF-8");
						
					res.setHeader("Content-Disposition", "filename=" + filename + ";");
						
				} else { //indexOf() 메서드 실행결과 일치하는 값이 없으면 아래 내용 수행.
						
					res.setContentType("application/smnet;charset=UTF-8");
						
					res.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
				}
					
				out.clear(); //out.clear() : out 객체의 모든 컨텐츠 지우기
					
				out = pageContext.pushBody(); //pageContext.pushBody() : jsp 페이지 정보 저장.
					
				if (file.isFile()) { 
					//file.isFile() 메서드로 file 객체에 있는 savefolder 경로 와 filename이 일치 하면 true.   
					
					//BufferedInputStream 객체를 생성하고, FileInputStream 을 이용하여 file을 읽어들여 저장한다.
					BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
					
					//BufferedOutputStream 객체를 생성하여 응답시 출력을 한다.
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
	
	// 게시물 수정
	public void updateBoard(BoardBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			
			//update 쿼리로 게시물을 수정한다.
			//num 으로 수정할 게시물을 찾아서 name, subject, content 컬럼을 수정 한다.
			sql = "update freeBoard set name=?,subject=?,content=? where FREE_NO=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFREE_TITLE());
			pstmt.setString(2, bean.getFREE_CONTENT());
			pstmt.setInt(3, bean.getFREE_NO());
			pstmt.setInt(4, bean.getMEM_NO());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deletefreeBoard(int FREE_NO) {

		Connection con = null;

		PreparedStatement pstmt = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();
			sql = "select FREE_FILENAME from freeBoard where FREE_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, FREE_NO);
			rs = pstmt.executeQuery();

			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists())
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			//num 을 이용하여 tblBoard 테이블의 컬럼을 찾아서 delete 쿼리문으로 해당 컬럼 삭제. 
			sql = "delete from freeBoard where FREE_NO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, FREE_NO);
			pstmt.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

			sql = "UPDATE freeBoard SET FREE_NO = (@COUNT := @COUNT + 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	
}
