package event;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.DBConnectionMgr;
import notice.UtilMgr;

public class EventMgr {

	private DBConnectionMgr pool;
	//파일 업로드 관련 설정 작성
	private static final String  SAVEFOLDER = "C:/GNCART/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;

	public EventMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertEvent(HttpServletRequest req) {

	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = null;
	    MultipartRequest multi = null;

	    try {
	        con = pool.getConnection();
	        sql = "select max(EVENT_NO) from event";
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();

	        int EVENT_NO = 0;
	        if (rs.next())
	            EVENT_NO = rs.getInt(1) + 1;

	        File file = new File(SAVEFOLDER);
	        if (!file.exists())
	            file.mkdirs();

	        multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

	        String filenames = ""; 
	        String fileSizes = "";

	        Enumeration<String> fileNames = multi.getFileNames();

	        while (fileNames.hasMoreElements()) {
	            String files = fileNames.nextElement();

	            if (multi.getFile(files) != null) {
	                String filename = multi.getFilesystemName(files);
	                int fileSize = (int) multi.getFile(files).length();

	                if (!filenames.isEmpty()) {
	                    filenames += ","; 
	                    fileSizes += ",";
	                }
	                filenames += filename;
	                fileSizes += fileSize; 
	            }
	        }

	        sql = "insert event(EVENT_NO, EVENT_TITLE, EVENT_CONTENT, EVENT_DATE, EVENT_HIT, EVENT_FILENAME, EVENT_FILESIZE, MEM_NO, EVENTSUB_NO, PART_NO)";
	        sql += "values(?, ?, ?, now(), 0, ?, ?, ?, ?, ?)";
	        pstmt = con.prepareStatement(sql);

	        pstmt.setInt(1, EVENT_NO);
	        pstmt.setString(2, multi.getParameter("EVENT_TITLE"));
	        pstmt.setString(3, multi.getParameter("EVENT_CONTENT"));
	        pstmt.setString(4, filenames);
	        pstmt.setString(5, fileSizes); 
	        pstmt.setInt(6, Integer.parseInt(multi.getParameter("MEM_NO")));
	        pstmt.setInt(7, Integer.parseInt(multi.getParameter("EVENTSUB_NO")));
	        pstmt.setInt(8, Integer.parseInt(multi.getParameter("PART_NO")));

	        pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	}
	public void upHit(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();
			int EVENT_NO = Integer.parseInt(request.getParameter("EVENT_NO"));

			// 중복 조회를 체크하기 위해 쿠키를 읽어옵니다.
			Cookie[] cookies = request.getCookies();
			boolean cookchk = false;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("hit_" + EVENT_NO)) {
						cookchk = true;
						break;
					}
				}
			}

			// 중복이 아닌 경우에만 조회수 증가
			if (!cookchk) {
				sql = "UPDATE event SET EVENT_HIT=EVENT_HIT+1 WHERE EVENT_NO=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, EVENT_NO);
				pstmt.executeUpdate();

				// 조회수 증가 기록을 쿠키에 저장합니다.
				Cookie hitCookie = new Cookie("hit_" + EVENT_NO, "true");
				hitCookie.setMaxAge(24 * 60 * 60); // 쿠키 유효 기간을 설정 (예: 24시간)
				response.addCookie(hitCookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public EventBean getEvent(int EVENT_NO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		EventBean bean = new EventBean();

		try {
			con = pool.getConnection();
			sql = "SELECT n.*, m.MEM_NAME, m.MEM_ID, ns.EVENT_SUB, p.PART_TYPE FROM event n JOIN member m ON n.MEM_NO = m.MEM_NO JOIN part p ON n.PART_NO = p.PART_NO JOIN eventsub ns ON n.EVENTSUB_NO = ns.EVENTSUB_NO WHERE n.EVENT_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, EVENT_NO);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setEVENT_NO(rs.getInt("EVENT_NO"));
				bean.setEVENT_TITLE(rs.getString("EVENT_TITLE"));
				bean.setEVENT_CONTENT(rs.getString("EVENT_CONTENT"));
				bean.setEVENT_DATE(rs.getString("EVENT_DATE"));
				bean.setEVENT_HIT(rs.getInt("EVENT_HIT"));
				bean.setEVENT_FILENAME(rs.getString("EVENT_FILENAME"));
				bean.setEVENT_FILESIZE(rs.getString("EVENT_FILESIZE"));
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setMEM_NAME(rs.getString("MEM_NAME")); 
				bean.setEVENTSUB_NO(rs.getInt("EVENTSUB_NO"));
				bean.setEVENT_SUB(rs.getString("EVENT_SUB"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setPART_NO(rs.getInt("PART_NO"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return bean;
	}
	
	public Vector<EventBean> getBoardList(String keyField, String keyWord, int start, int end) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<EventBean> vlist = new Vector<EventBean>();
		
		try {
			con = pool.getConnection();
			//keyWord 값이 없는 경우 게시물 조회
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "SELECT E.*, M.MEM_NAME, ES.EVENT_SUB, P.PART_TYPE FROM event E JOIN MEMBER M ON E.MEM_NO = M.MEM_NO JOIN EVENTSUB ES ON E.EVENTSUB_NO = ES.EVENTSUB_NO JOIN PART P ON E.PART_NO = P.PART_NO ORDER BY E.EVENT_NO DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else { //keyField 와 keyWord 값이 있는 경우 게시물 조회
				sql = "SELECT E.*, M.MEM_NAME, ES.EVENT_SUB, P.PART_TYPE FROM event E JOIN MEMBER M ON E.MEM_NO = M.MEM_NO JOIN EVENTSUB ES ON E.EVENTSUB_NO = ES.EVENTSUB_NO JOIN PART P ON E.PART_NO = P.PART_NO WHERE " + keyField + " LIKE ?";
				sql += "ORDER BY E.EVENT_NO DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				EventBean bean = new EventBean();
				bean.setEVENT_NO(rs.getInt("EVENT_NO"));
				bean.setEVENT_TITLE(rs.getString("EVENT_TITLE"));
				bean.setEVENT_DATE(rs.getString("EVENT_DATE"));
				bean.setEVENT_HIT(rs.getInt("EVENT_HIT"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setEVENT_SUB(rs.getString("EVENT_SUB"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				bean.setEVENT_FILENAME(rs.getString("EVENT_FILENAME"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			
			//keyField , keyWord 값이 없는 경우 총 게시물 가져오기
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(EVENT_NO) from event";
				pstmt = con.prepareStatement(sql);
			} else { //keyField, keyWord 값이 있는 경우 총 게시물 가져오기
				sql = "select count(EVENT_NO) from event where ' + keyField + ' like ? ";
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
	public void reviseEvent(EventBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();

			sql = "update event set EVENT_TITLE=?,EVENT_CONTENT=?,MEM_NO=?,EVENTSUB_NO=?,PART_NO=? where EVENT_NO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getEVENT_TITLE());
			pstmt.setString(2, bean.getEVENT_CONTENT());
			pstmt.setInt(3, bean.getMEM_NO());
			pstmt.setInt(4, bean.getEVENTSUB_NO());
			pstmt.setInt(5, bean.getPART_NO());
			pstmt.setInt(6, bean.getEVENT_NO());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteEvent(int EVENT_NO) {

		Connection con = null;

		PreparedStatement pstmt = null;

		String sql = null;

		ResultSet rs = null;

		try {
			con = pool.getConnection();
			sql = "select EVENT_FILENAME from EVENT where EVENT_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, EVENT_NO);
			rs = pstmt.executeQuery();

	        if (rs.next() && rs.getString(1) != null) {
	            String[] filenames = rs.getString(1).split(",");
	            for (String filename : filenames) {
	                if (!filename.equals("")) {
	                    File file = new File(SAVEFOLDER + "/" + filename);
	                    if (file.exists())
	                        UtilMgr.delete(SAVEFOLDER + "/" + filename);
	                }
	            }
	        }
			sql = "delete from event where EVENT_NO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, EVENT_NO);
			pstmt.executeUpdate();

			sql = "SET @COUNT = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

			sql = "UPDATE notice SET NOT_NO = (@COUNT := @COUNT + 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
}
