package auth;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.NoticeBean;

@WebServlet("/authWrite")
public class AuthWriteServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		    throws ServletException, IOException {

			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
		    
		    PrintWriter out = response.getWriter();

		    String action = request.getParameter("action");
		    
		    AuthMgr aMgr = new AuthMgr();
		    
		    
		    if ("vacWrite".equals(action)) {
		    	
				out.println("<script>");
				out.println("alert('결재신청이 완료되었습니다');");
				out.println("window.close();");
				out.println("</script>");
				
		    	aMgr.insertVAC(request);
		    	
		    } else if ("busWrite".equals(action)) {
		    	
				out.println("<script>");
				out.println("alert('결재신청이 완료되었습니다');");
				out.println("window.close();");
				out.println("</script>");
				
		    	aMgr.insertBUS(request);
		    } 
		}
}