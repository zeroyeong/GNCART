package schedule;

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

public class ScheduleMgr {
	
	private DBConnectionMgr pool=null; //common 패키지의 pool 객체 선언
	
	public ScheduleMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	/*___________일정 리스트____________*/  
	public Vector<ScheduleBean> getScheduleList(int calYear, int calMonth){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		 
		String sql = null; 
		
		Vector<ScheduleBean> vlist = new Vector<ScheduleBean>();
		
		try {
			con=pool.getConnection();
			
			sql="SELECT*FROM schedule WHERE SCHE_START_DATE LIKE ? OR SCHE_END_DATE LIKE ?";
			pstmt = con.prepareStatement(sql);
			
			if(calMonth<10) {
				pstmt.setString(1, "%"+calYear+"-"+"0"+calMonth+"%");
				pstmt.setString(2, "%"+calYear+"-"+"0"+calMonth+"%");
			}else {
				pstmt.setString(1, "%"+calYear+"-"+calMonth+"%");
				pstmt.setString(2, "%"+calYear+"-"+calMonth+"%");
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {		
				ScheduleBean bean = new ScheduleBean();
				
				bean.setSCHE_NO(rs.getInt("SCHE_NO"));
				bean.setSCHE_NAME(rs.getString("SCHE_NAME"));
				bean.setSCHE_START_DATE(rs.getString("SCHE_START_DATE"));
				bean.setSCHE_END_DATE(rs.getString("SCHE_END_DATE"));
				
				vlist.add(bean);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return vlist;
	}

	/*_____________일정 상세 조회 scheduleDetail.jsp_____________*/

	public ScheduleBean getSchedule(int SCHE_NO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		String sql = null; 
		
		ScheduleBean bean=new ScheduleBean();
		
		try {
			con=pool.getConnection();
			sql="SELECT*FROM schedule a\r\n"
					+ "JOIN MEMBER b ON a.MEM_NO=b.MEM_NO\r\n"
					+ "JOIN scheduletype c ON a.TYPE_NO=c.TYPE_NO\r\n"
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN sttime e ON a.ST_NO=e.ST_NO\r\n"
					+ "JOIN endtime f ON a.END_NO=f.END_NO\r\n"
					+ "where SCHE_NO=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, SCHE_NO);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setSCHE_NO(rs.getInt("SCHE_NO"));
				bean.setSCHE_NAME(rs.getString("SCHE_NAME"));
				bean.setSCHE_DATE(rs.getString("SCHE_DATE"));
				bean.setSCHE_DETAIL(rs.getString("SCHE_DETAIL"));
				bean.setSCHE_FILE(rs.getString("SCHE_FILE"));
				bean.setSCHE_START_DATE(rs.getString("SCHE_START_DATE"));
				bean.setSCHE_END_DATE(rs.getString("SCHE_END_DATE"));
				
				bean.setTYPE_NO(rs.getInt("TYPE_NO"));
				bean.setTYPE_TYPE(rs.getString("TYPE_TYPE"));
				
				bean.setPART_NO(rs.getInt("PART_NO"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				
				bean.setST_NO(rs.getInt("ST_NO"));
				bean.setST_TIME(rs.getString("ST_TIME"));
				
				bean.setEND_NO(rs.getInt("END_NO"));
				bean.setEND_TIME(rs.getString("END_TIME"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	/*_____________일정 등록 scheduleAdd.jsp_____________*/
	
	//파일 업로드 관련 설정 작성
	private static final String  SAVEFOLDER = "C:Users/Administrator/git/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 10*1024*1024; //용량 초과의 경우 사이트연결불가 화면이 뜸~!
	
	public void newSchedule(HttpServletRequest req) {
		Connection con = null; //연결객체
		PreparedStatement pstmt = null; //쿼리처리객체
		ResultSet rs = null;  //결과값 담는 객체
		
		String sql = null; //쿼리문 저장 변수	
		
		MultipartRequest multi = null; //파일 업로드 위한 객체
		
		String SCHE_FILE = null; //파일이름 변수	
		
		try {
			con=pool.getConnection();
			
			File file = new File(SAVEFOLDER);
			
			if(!file.exists()) {
				file.mkdirs();
			}
			
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("SCHE_FILE")!=null) {
				SCHE_FILE = multi.getFilesystemName("SCHE_FILE");
			}
			
			sql = "INSERT INTO schedule(SCHE_NAME, SCHE_DATE, SCHE_START_DATE, SCHE_END_DATE, SCHE_DETAIL,\r\n"
					+ "SCHE_FILE, ST_NO, END_NO, MEM_NO, TYPE_NO, PART_NO)\r\n"
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, multi.getParameter("SCHE_NAME"));
			pstmt.setString(2, multi.getParameter("SCHE_DATE"));
			pstmt.setString(3, multi.getParameter("SCHE_START_DATE"));
			pstmt.setString(4, multi.getParameter("SCHE_END_DATE"));
			pstmt.setString(5, multi.getParameter("SCHE_DETAIL"));
			pstmt.setString(6, SCHE_FILE);
			pstmt.setInt(7, Integer.parseInt(multi.getParameter("ST_NO")));
			pstmt.setInt(8, Integer.parseInt(multi.getParameter("END_NO")));
			pstmt.setInt(9, Integer.parseInt(multi.getParameter("MEM_NO")));
			pstmt.setInt(10, Integer.parseInt(multi.getParameter("TYPE_NO")));
			pstmt.setInt(11,Integer.parseInt( multi.getParameter("PART_NO")));
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//일정등록한 행 조회
	public ScheduleBean newScheduleView() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		ScheduleBean bean = new ScheduleBean();
		
		try {
			con=pool.getConnection();
			sql = "select*from schedule order by SCHE_NO desc limit 1";
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setSCHE_NO(rs.getInt("SCHE_NO"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	/*___________일정 수정 updateSchedule.jsp____________*/
	public void updateSchedule(HttpServletRequest req, HttpServletResponse res) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = null;
		
		MultipartRequest multi = null; //파일 업로드 위한 객체
		String SCHE_FILE = null; //파일이름 변수	
		
		try {
			con = pool.getConnection();
			
			File file = new File(SAVEFOLDER);
			
			if(!file.exists()) {
				file.mkdirs();
			}
			
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			
			if(multi.getParameter("SCHE_FILE1") != null && !multi.getParameter("SCHE_FILE1").equals("")) {
				SCHE_FILE = multi.getParameter("SCHE_FILE1");
			}else {
				if(multi.getParameter("SCHE_FILE1") == null) {
					SCHE_FILE = multi.getFilesystemName("SCHE_FILE3");
				} else if(multi.getParameter("SCHE_FILE1") == ""){
					SCHE_FILE = multi.getFilesystemName("SCHE_FILE2");
				}
			}
			
			
			sql = "update schedule set SCHE_NAME=?, SCHE_START_DATE=?,SCHE_END_DATE=?, SCHE_DETAIL=?, SCHE_FILE=?, ST_NO=?, END_NO=?, TYPE_NO=?, PART_NO=? where SCHE_NO=?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, multi.getParameter("SCHE_NAME"));
			pstmt.setString(2, multi.getParameter("SCHE_START_DATE"));
			pstmt.setString(3, multi.getParameter("SCHE_END_DATE"));
			pstmt.setString(4, multi.getParameter("SCHE_DETAIL"));
			pstmt.setString(5, SCHE_FILE);
			pstmt.setInt(6, Integer.parseInt(multi.getParameter("ST_NO")));
			pstmt.setInt(7, Integer.parseInt(multi.getParameter("END_NO")));
			pstmt.setInt(8, Integer.parseInt(multi.getParameter("TYPE_NO")));
			pstmt.setInt(9,Integer.parseInt( multi.getParameter("PART_NO")));
			pstmt.setInt(10,Integer.parseInt( multi.getParameter("SCHE_NO")));
			
			pstmt.executeUpdate();
			
			res.sendRedirect("http://localhost:8080/GNCART/schedule/jsp/scheduleDetail.jsp?SCHE_NO="+multi.getParameter("SCHE_NO"));

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	/*___________게시물 삭제___________*/
	public void delSchedule(int SCHE_NO) {
		Connection con = null;
		
		PreparedStatement pstmt = null;
		
		String sql = null;
		
		ResultSet rs = null;
		
		try {
			con=pool.getConnection();
			sql="select SCHE_FILE from schedule where SCHE_NO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, SCHE_NO);
			rs = pstmt.executeQuery();
			
			if(rs.next() && rs.getString(1) != null) {
				if(! rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if(file.exists())
						UtilMgr.delete(SAVEFOLDER+"/"+rs.getString(1));
				}
			}
			
			sql = "delete from schedule where SCHE_NO=?";
			
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, SCHE_NO);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	

	
	/*___________파일 다운로드___________*/
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
		try {//요청객체에 있는 filename 파라미터를 바아서 변수에 저장
			String filename=req.getParameter("SCHE_FILE");
			
			//file 객체 생성, filename이 한글일 경우 깨지지않게 하기위해
			//UtilMgr클래스의 con()메서드 호출하여 결과값을 담는다.
			//BoarMgr 클래스 상단에 있는 savefolder 경로와 file구분자, filename을 저장.
			File file=new File(UtilMgr.con(SAVEFOLDER+File.separator+filename));
			
			//file.length()는 파일의 크기를 리턴하며, 단위는 byte임
			byte b[]=new byte[(int)file.length()];
			
			//res.setHeader() 메서드를 이용해서 response(응답) 객체의 header에 text를 추가.
			//첫번재 인수가 key, 두번째 인수가 value이다.
			res.setHeader("Accept-Ranges", "bytes");
			
			//req.getHeader() 메서드를 이용해서 요청객체의 클라이언트 브라우저 정보를 strClient변수에 저장
			String strClient = req.getHeader("User-Agent");
			
			//strClient 변수에 저장된 브라우저 정보를 indexOf 메서드로 검색
			//브라우저 정보에 MSIE가 true이면 ms사의 브라우자, false면 다른 브라우저로 인식
			//브라우저의 버전과 정보를 구분해서 각각 res(응답객체)의 header와 contentType을 설정한다.
			
			if(strClient.indexOf("MSIE6.0")!=-1) {
				//indexOf() 메서드를 사용하여 일치하는 값이 없으면 -1을 반환한다.
				//이 조건문에서는 true상황, 즉 일치하는 값이 있는 경우 아래 내용을 수행한다.
				
				res.setContentType("application/smnet;charset=UTF-8");
				res.setHeader("Content-Disposition", "filename="+filename+";");
			}else {//indedxOf()메서드 실행결과 일치하는 값이 없으면 아래 내용 수행
				res.setContentType("application/smnet;charset=UTF-8");
				res.setHeader("Content-Disposition", "attachment;filename="+filename+";");
			}
			
			out.clear(); //out.clear() : out객체의 모든 컨텐츠 지우기
			out=pageContext.pushBody(); //pageContext.pushBody(): jsp페이지 정보 저장
			
			if(file.isFile()) {
				//file.isFile() 메서드로 file객체에 있는 sacefolder경로와 filename이 일치하면 true
				//BufferredInputStream 객체를 생성하고, FileInputStream을 이용하여 file을 읽어들여 저장한다.
				BufferedInputStream fin=new BufferedInputStream(new FileInputStream(file));
				//BufferredOutputStream 객체를 생성하여 응답시 출력을 한다.
				BufferedOutputStream outs = new BufferedOutputStream(res.getOutputStream());
				
				int read=0;
				
				while((read=fin.read(b))!=-1) {
					outs.write(b,0,read);
				}
				
				outs.close();
				
				fin.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*___________테이블별 리스트____________*/
	//scheduleType
	public Vector<ScheduleBean> getTypeList(){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ScheduleBean> typeList = new Vector<ScheduleBean>();
		
		try {
			con=pool.getConnection();
			
			sql="select*from scheduletype";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ScheduleBean typeBean = new ScheduleBean();
				typeBean.setTYPE_NO(rs.getInt("TYPE_NO"));
				typeBean.setTYPE_TYPE(rs.getString("TYPE_TYPE"));
				
				typeList.add(typeBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return typeList;
	}
	
	//part
	public Vector<ScheduleBean> getPartList(){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ScheduleBean> partList = new Vector<ScheduleBean>();
		
		try {
			con=pool.getConnection();
			
			sql = "select*from part";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ScheduleBean partBean = new ScheduleBean();
				partBean.setPART_NO(rs.getInt("PART_NO"));
				partBean.setPART_TYPE(rs.getString("PART_TYPE"));
				
				partList.add(partBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return partList;
	}
	
	//sttime
	public Vector<ScheduleBean> getSttimeList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<ScheduleBean> sttimeList = new Vector<ScheduleBean>();
		
		try {
			con = pool.getConnection();
			sql = "select*from sttime";
			pstmt = con.prepareStatement(sql);
			rs =pstmt.executeQuery();
			
			while(rs.next()) {
				ScheduleBean stBean = new ScheduleBean();
				stBean.setST_NO(rs.getInt("ST_NO"));
				stBean.setST_TIME(rs.getString("ST_TIME"));
				
				sttimeList.add(stBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sttimeList;
	}
	
	//endtime
	public Vector<ScheduleBean> getEndTimeList(){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		Vector<ScheduleBean> endtimeList = new Vector<ScheduleBean>();
		
		try {
			con = pool.getConnection();
			sql = "select*from endtime";
			pstmt = con.prepareStatement(sql);
			rs =pstmt.executeQuery();
			
			while(rs.next()) {
				ScheduleBean endBean = new ScheduleBean();
				endBean.setEND_NO(rs.getInt("END_NO"));
				endBean.setEND_TIME(rs.getString("END_TIME"));
				
				endtimeList.add(endBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);;
		}
		return endtimeList;
	}
}
