package management;

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

public class ManagementMgr {
	private DBConnectionMgr pool=null;
	
	public ManagementMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	/*___________전체사원 리스트____________*/
	
	public Vector<ManagementBean> getMemberList(String keyField, String keyWord, int start, int end){
		
		//keyField : 페이지 하단 form인 searchFrm의 select 태그
		//keyWord : 페이지 하단 form인 searchFrm의 input 태그
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ManagementBean> vlist = new Vector<ManagementBean>();
		
		try {
			con=pool.getConnection();
			
			//keyWord값이 없는 경우 게시물 조회
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql="SELECT*FROM member a\r\n"
						+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
						+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO\r\n"
						+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
						+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n"
						+ "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n";
				sql+="ORDER BY MEM_NO asc limit ?, ? ";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
			} else { //keyWord값이 있는 경우
				sql="SELECT*FROM member a\r\n"
						+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
						+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO\r\n"
						+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
						+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n"
						+ "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n"
						+ "where "+keyField+" like ? ";
				sql+="ORDER BY MEM_NO asc limit ?, ? ";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean bean=new ManagementBean();
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setMEM_PW(rs.getString("MEM_PW"));
				bean.setMEM_DATE(rs.getString("MEM_DATE"));
				bean.setMEM_TEL(rs.getString("MEM_TEL"));
				bean.setMEM_MAIL(rs.getString("MEM_MAIL"));
				bean.setMEM_PHONE(rs.getString("MEM_PHONE"));
				bean.setMEM_ADD(rs.getString("MEM_ADD"));
				bean.setMEM_BIRTH(rs.getString("MEM_BIRTH"));				
				bean.setMEM_AND(rs.getString("MEM_AND"));
				
				bean.setAC_NO(rs.getInt("AC_NO"));
				bean.setWORK_NO(rs.getInt("WORK_NO"));
				bean.setPART_NO(rs.getInt("PART_NO"));
				bean.setLE_NO(rs.getInt("LE_NO"));
				bean.setAP_NO(rs.getInt("AP_NO"));
				
				bean.setAC_TYPE(rs.getString("AC_TYPE"));
				bean.setWORK_TYPE(rs.getString("WORK_TYPE"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				bean.setLE_LEVEL(rs.getString("LE_LEVEL"));
				bean.setAP_TYPE(rs.getString("AP_TYPE"));
				vlist.add(bean);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return vlist;           
	}
	
	/*____________총 게시물 수_____________*/
	
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
				sql = "select count(*) from member";
				pstmt = con.prepareStatement(sql);
			} else { //keyField, keyWord 값이 있는 경우 총 게시물 가져오기
				sql = "select count(*) from  member where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
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
	
	
	//파일 업로드 관련 설정 작성
	private static final String  SAVEFOLDER = "C:Users/Administrator/git/GNCART/GNCART/src/main/webapp/filestorage";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	
	/*_____________사용자 등록_____________*/
	
public void newMember(HttpServletRequest req) {
		Connection con = null; //연결객체
		PreparedStatement pstmt = null; //쿼리처리객체
		ResultSet rs = null;  //결과값 담는 객체
		
		String sql = null; //쿼리문 저장 변수	
		
		MultipartRequest multi = null; //파일 업로드 위한 객체
		
		String MEM_IMG = null; //파일이름 변수
		
		try {
			con=pool.getConnection();
			
			File file = new File(SAVEFOLDER);
			
			if(!file.exists()) {
				file.mkdirs(); //mkdirs(): 파일 디렉토리 만드는 메서드
			}
			
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("MEM_IMG")!=null) {
				MEM_IMG = multi.getFilesystemName("MEM_IMG");
			}			
			
			sql = "insert into member(MEM_NAME, MEM_ID, MEM_PW, MEM_DATE, MEM_TEL, MEM_MAIL,"
					+ " MEM_PHONE, MEM_ADD, MEM_BIRTH, MEM_AND, MEM_IMG,"
					+ "AC_NO, WORK_NO, PART_NO, LE_NO, AP_NO)";
			sql += "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, multi.getParameter("MEM_NAME"));
			pstmt.setString(2, multi.getParameter("MEM_ID"));
			pstmt.setString(3, multi.getParameter("MEM_PW"));
			pstmt.setString(4, multi.getParameter("MEM_DATE"));
			pstmt.setString(5, multi.getParameter("MEM_TEL"));
			pstmt.setString(6, multi.getParameter("MEM_MAIL"));
			pstmt.setString(7, multi.getParameter("MEM_PHONE"));
			pstmt.setString(8, multi.getParameter("MEM_ADD"));
			pstmt.setString(9, multi.getParameter("MEM_BIRTH"));
			pstmt.setString(10, multi.getParameter("MEM_AND"));
			pstmt.setString(11, MEM_IMG);
			pstmt.setInt(12, Integer.parseInt(multi.getParameter("AC_NO")));
			pstmt.setInt(13, Integer.parseInt(multi.getParameter("WORK_NO")));
			pstmt.setInt(14, Integer.parseInt(multi.getParameter("PART_NO")));
			pstmt.setInt(15, Integer.parseInt(multi.getParameter("LE_NO")));
			pstmt.setInt(16, Integer.parseInt(multi.getParameter("AP_NO")));
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	/*_____________사용자 조회_____________*/

	public ManagementBean getMember(int MEM_NO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		String sql = null; 
		
		ManagementBean bean=new ManagementBean();
		
		try {
			con=pool.getConnection();
			sql="SELECT*FROM member a\r\n"
					+ "JOIN accounttype b ON a.AC_NO=b.AC_NO\r\n"
					+ "JOIN worktype c ON a.WORK_NO=c.WORK_NO\r\n"
					+ "JOIN part d ON a.PART_NO=d.PART_NO\r\n"
					+ "JOIN level e ON a.LE_NO=e.LE_NO\r\n"
					+ "JOIN acposition f ON a.AP_NO=f.AP_NO\r\n"
					+ "where MEM_NO=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, MEM_NO);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				bean.setMEM_NAME(rs.getString("MEM_NAME"));
				bean.setMEM_ID(rs.getString("MEM_ID"));
				bean.setMEM_PW(rs.getString("MEM_PW"));
				bean.setMEM_DATE(rs.getString("MEM_DATE"));
				bean.setMEM_TEL(rs.getString("MEM_TEL"));
				bean.setMEM_MAIL(rs.getString("MEM_MAIL"));
				bean.setMEM_PHONE(rs.getString("MEM_PHONE"));
				bean.setMEM_ADD(rs.getString("MEM_ADD"));
				bean.setMEM_BIRTH(rs.getString("MEM_BIRTH"));
				bean.setMEM_AND(rs.getString("MEM_AND"));
				bean.setMEM_IMG(rs.getString("MEM_IMG"));
				
				bean.setAC_NO(rs.getInt("AC_NO"));
				bean.setWORK_NO(rs.getInt("WORK_NO"));
				bean.setPART_NO(rs.getInt("PART_NO"));
				bean.setLE_NO(rs.getInt("LE_NO"));
				bean.setAP_NO(rs.getInt("AP_NO"));
				
				bean.setAC_TYPE(rs.getString("AC_TYPE"));
				bean.setWORK_TYPE(rs.getString("WORK_TYPE"));
				bean.setPART_TYPE(rs.getString("PART_TYPE"));
				bean.setLE_LEVEL(rs.getString("LE_LEVEL"));
				bean.setAP_TYPE(rs.getString("AP_TYPE"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	/*_____________사용자 수정_____________*/
	
	public void updateMember(ManagementBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con=pool.getConnection();
			
			sql="update member set MEM_NAME=?, MEM_ID=?, MEM_PW=?, MEM_DATE=?, MEM_TEL=?,MEM_MAIL=?, MEM_PHONE=?, MEM_ADD=?,"
					+ " MEM_BIRTH=?, MEM_AND=?, MEM_IMG=?,AC_NO=?, WORK_NO=?, PART_NO=?, LE_NO=?, AP_NO=? where MEM_NO=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bean.getMEM_NAME());
			System.out.println("name= "+bean.getMEM_NAME());
			pstmt.setString(2, bean.getMEM_ID());
			System.out.println("id = "+bean.getMEM_ID());
			pstmt.setString(3, bean.getMEM_PW());
			System.out.println("pw= "+bean.getMEM_PW());
			pstmt.setString(4, bean.getMEM_DATE());
			System.out.println("date= "+bean.getMEM_DATE());
			pstmt.setString(5, bean.getMEM_TEL());
			System.out.println("tel= "+bean.getMEM_TEL());
			pstmt.setString(6, bean.getMEM_MAIL());
			System.out.println("mail= "+bean.getMEM_MAIL());
			pstmt.setString(7, bean.getMEM_PHONE());
			System.out.println("phone= "+bean.getMEM_PHONE());
			pstmt.setString(8, bean.getMEM_ADD());
			System.out.println("add= "+bean.getMEM_ADD());
			pstmt.setString(9, bean.getMEM_BIRTH());
			System.out.println("birth= "+bean.getMEM_BIRTH());
			pstmt.setString(10, bean.getMEM_AND());
			System.out.println("and= "+bean.getMEM_AND());
			pstmt.setString(11, bean.getMEM_IMG());
			System.out.println("img = "+bean.getMEM_IMG());
			pstmt.setInt(12, bean.getAC_NO());
			System.out.println("ac = "+bean.getAC_NO());
			pstmt.setInt(13, bean.getWORK_NO());
			System.out.println("work= "+bean.getWORK_NO());
			pstmt.setInt(14, bean.getPART_NO());
			System.out.println("part = "+bean.getPART_NO());
			pstmt.setInt(15, bean.getLE_NO());
			System.out.println("le = "+bean.getLE_NO());
			pstmt.setInt(16, bean.getAP_NO());
			System.out.println("ap = "+bean.getMEM_IMG());
			pstmt.setInt(17, bean.getMEM_NO());
			System.out.println("MEM_NO= "+bean.getMEM_NO());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
	
	
	/*_____________MEM_IMG 사진 다운로드_____________*/
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
		try {
			String MEM_IMG = req.getParameter("MEM_IMG");
			
			File file = new File(UtilMgr.con(SAVEFOLDER+File.separator+MEM_IMG));
			
			byte b[] = new byte[(int)file.length()];
			
			res.setHeader("Accept-Ranges", "bytes");
			
			String strClient = req.getHeader("User-Agent");
			
			if(strClient.indexOf("MSIE6.0")!=-1) {
				res.setContentType("application/smnet; charset=UTF-8");
				res.setHeader("Content-Disposition", "filename="+MEM_IMG+";");
			}else {
				res.setContentType("application/smnet;charset=UTF-8");
				res.setHeader("Content-Disposition", "attachment;filename="+MEM_IMG+";");
			}
			
			out.clear();
			out=pageContext.pushBody();
			
			if(file.isFile()) {
				BufferedInputStream fin=new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(res.getOutputStream());
				
				int read = 0;
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
	
	public Vector<ManagementBean> getActypeList(){
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ManagementBean> aclist = new Vector<ManagementBean>();
		
		try {
			con=pool.getConnection();
			
			sql="SELECT*FROM accounttype";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean ACbean=new ManagementBean();
				ACbean.setAC_NO(rs.getInt("AC_NO"));
				ACbean.setAC_TYPE(rs.getString("AC_TYPE"));		
				
				aclist.add(ACbean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return aclist;           
	}
	
	public Vector<ManagementBean> getAcpositionList(){
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ManagementBean> aplist = new Vector<ManagementBean>();
		
		try {
			con=pool.getConnection();
			
			sql="SELECT*FROM acposition";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean APbean=new ManagementBean();
				APbean.setAP_NO(rs.getInt("AP_NO"));
				APbean.setAP_TYPE(rs.getString("AP_TYPE"));
				
				aplist.add(APbean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return aplist;           
	}
	public Vector<ManagementBean> getLevelList(){
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ManagementBean> lelist = new Vector<ManagementBean>();
		
		try {
			con=pool.getConnection();
			
			sql="SELECT*FROM level";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean LEbean=new ManagementBean();
				LEbean.setLE_NO(rs.getInt("LE_NO"));
				LEbean.setLE_LEVEL(rs.getString("LE_LEVEL"));			
				
				lelist.add(LEbean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return lelist;           
	}
	
	public Vector<ManagementBean> getPartList(){
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql=null;
		
		Vector<ManagementBean> partlist = new Vector<ManagementBean>();
		
		try {
			con=pool.getConnection();
			
			sql="SELECT * FROM part";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ManagementBean PARTbean=new ManagementBean();
				PARTbean.setPART_NO(rs.getInt("PART_NO"));
				PARTbean.setPART_TYPE(rs.getString("PART_TYPE"));
			
				partlist.add(PARTbean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return partlist;           
	}
}
