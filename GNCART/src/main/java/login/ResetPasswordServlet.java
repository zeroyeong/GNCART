package login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("logId");
		String newPw1 = request.getParameter("resetPw1");
		String newPw2 = request.getParameter("resetPw2"); 

		// 비밀번호 검증 및 변경처리
		if (newPw1.equals(newPw2)) {
			MemberMgr memberMgr = new MemberMgr();
			boolean success = memberMgr.resetPassword(id, newPw1);

			if (success) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter writer = response.getWriter();
				writer.println("<script>alert('변경완료!'); location.href='login.jsp';</script>"); 
				writer.close();    
			} else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter writer = response.getWriter();
				writer.println("<script>alert('변경실패!'); location.href='forgetPw.jsp';</script>"); 
				writer.close();
			}
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = response.getWriter();
			writer.println("<script>alert('비밀번호가 일치하지않습니다!'); location.href='forgetPw.jsp';</script>"); 
			writer.close();
		}
	}
}
