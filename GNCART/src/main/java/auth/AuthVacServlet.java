package auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/vacWrite")
public class AuthVacServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {

	    request.setCharacterEncoding("UTF-8"); 
	    
	    //BoardMgr 클래스 객체 생성
	    AuthMgr aMgr = new AuthMgr();
	    
	    //BoardMgr 클래스에 정의된 insertBoard() 메서드를 호출한다.
	    //매개변수를 request(요청) 객체 로 하여, insertBoard() 메서드 안에서 파라미터를 처리 할 수 있다.
	    aMgr.insertVAC(request);
	    
	    //응답 시 list.jsp 페이지로 이동한다.
	    response.sendRedirect("auth/auth.jsp");
	}
}