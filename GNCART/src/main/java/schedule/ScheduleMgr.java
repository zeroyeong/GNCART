package schedule;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

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
	private static final String  SAVEFOLDER = "C:/GNCART/GNCART/src/main/webapp/05management/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	
	public void newSchedule(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		MultipartRequest multi = null; //파일 업로드 위한 객체
		
		String SCHE_FILE = null; //파일이름 변수	
		
		try {
			con=pool.getConnection();
			
			File file = new File(SAVEFOLDER);
			
			if(!file.exists()) {
				file.mkdirs();
			}
			
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			
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
			pstmt.setString(6, multi.getParameter("SCHE_FILE"));
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
	public void updateSchedule(ScheduleBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			
			sql = "update schedule set SCHE_NAME=?, SCHE_START_DATE=?,SCHE_END_DATE=?,\r\n"
				  + "SCHE_DETAIL=?, SCHE_FILE=?, ST_NO=?, END_NO=?, TYPE_NO=?, PART_NO=?\r\n"
				  + "where SCHE_NO=?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getSCHE_NAME());
			pstmt.setString(2, bean.getSCHE_START_DATE());
			pstmt.setString(3, bean.getSCHE_END_DATE());
			pstmt.setString(4, bean.getSCHE_DETAIL());
			pstmt.setString(5, bean.getSCHE_FILE());
			pstmt.setInt(6, bean.getST_NO());
			pstmt.setInt(7,  bean.getEND_NO());
			pstmt.setInt(8, bean.getTYPE_NO());
			pstmt.setInt(9, bean.getPART_NO());
			
			rs=pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
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
