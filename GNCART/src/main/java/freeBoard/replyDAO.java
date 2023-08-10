package freeBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.DBConnectionMgr;

public class replyDAO {
	
	
	private DBConnectionMgr pool;
	private Connection conn;
	private ResultSet rs;
	
	
	public replyDAO() {
		try {
			String dbURL="jdbc:mysql://127.0.0.1:3306/gncart?useUnicode=true&characterEncoding=UTF-8";	
			String dbID="root";
			String dbPassword="0000";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public ArrayList<reply> getList(int FREE_NO, int pageNumber){
		String SQL="SELECT * FROM reply WHERE MEM_NO<? AND replyAvailable=1 AND FREE_NO=? ORDER BY MEM_NO DESC LIMIT 10";
		System.out.println("reply 여기는");
		ArrayList<reply> list=new ArrayList<reply>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext()-(pageNumber-1)*10);
			pstmt.setInt(2, FREE_NO);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				reply reply=new reply();
				System.out.println("reply 저기도");
				reply.setFREE_NO(rs.getInt("FREE_NO"));
				reply.setReplyContent(rs.getString("ReplyContent"));
				reply.setMEM_NO(rs.getInt("MEM_NO"));
				reply.setreplyDate(rs.getString("replyDate"));
				reply.setReplyAvailable(1); // rs.getInt(5) => out of index 오류
				list.add(reply);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getNext() {
		System.out.println("reply 필드");
		String SQL="select reply FROM reply ORDER BY reply DESC";
		try {
		
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1)); // select문에서 첫번째 값
				return rs.getInt(1)+1;  // 현재 인덱스(현재 게시글 개수) +1 반환
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	

	public int write(String MEM_NAME, int FREE_NO , String replyContent, int MEM_NO) {
		String SQL="INSERT INTO reply (replyContent, replyDate, MEM_NO, FREE_NO) VALUES(?, now(), ?, ?)";
	
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,replyContent);
			pstmt.setInt(2, getNext());
			
			pstmt.setInt(3, FREE_NO);
			pstmt.setInt(4, MEM_NO);
			pstmt.setString(5, MEM_NAME);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	
	
	public reply getBoard(int FREE_NO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		reply bean = new reply();
		
		try {
			con = pool.getConnection();
			//num 값을 기준으로 tblBoard 테이블 에서 게시물을 조회한다.
			
			sql = "SELECT * FROM freeBoard C JOIN member M ON C.MEM_NO = M.MEM_NO JOIN part p ON p.PART_NO = M.PART_NO WHERE FREE_NO = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, FREE_NO);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				bean.setFREE_NO(rs.getInt("FREE_NO"));
				
				bean.setReplyContent(rs.getString("replyContent"));
				bean.setreplyDate(rs.getString("replyDate"));
				
				
				bean.setMEM_NO(rs.getInt("MEM_NO"));
				
			
				bean.setMEM_NAME(rs.getString("MEM_NAME")); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	
}