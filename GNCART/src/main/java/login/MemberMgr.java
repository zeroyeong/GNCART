package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBConnectionMgr;

//MemberMgr 클래스는 jsp 페이지에서 자바빈즈 를 사용하여 정의된 메서드를 호출하는 DAO 와 비슷한 역할을 합니다.
//각 기능에 맞는 메서드를 정의 하여, 메서드 호출시 DB연결, 쿼리문 처리, 결과값 return 하는 클래스 입니다.
public class MemberMgr {
	private DBConnectionMgr pool;

	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

		// 로그인 처리
		public boolean loginMember(String id, String pw) {
			
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				boolean flag = false;

				try {
					con = pool.getConnection();
					
					sql = "select MEM_ID from member where MEM_ID = ? and MEM_PW = ?";
					//id 컬럼을 찾는 select 쿼리를 작성한다. where 절 에 매개변수로 받은 id, pw를 입력함.
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pw);
					
					rs = pstmt.executeQuery();
					flag = rs.next();
					
					return flag;
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return false;
			}
		
		//멤버테이블 이름 찾아서 우측상단 이름 넣기
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
				
			
				if(rs.next()) {
					name = rs.getString("MEM_NAME");
				}
				return name;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return "";
		}

		
		 // 비밀번호 변경
	    public boolean resetPassword(String id, String newPw) {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        String sql = null;
	      
	        try {
	        	con = pool.getConnection();

	            sql = "UPDATE member SET MEM_PW = ? WHERE MEM_ID = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, newPw);
	            pstmt.setString(2, id);

	            int rowsAffected = pstmt.executeUpdate();
	            return rowsAffected > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            pool.freeConnection(con, pstmt);
	        }
	        return false;
	    }
	}