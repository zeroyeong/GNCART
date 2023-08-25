package auth;
 
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.NoticeBean;

@WebServlet("/authServlet")
public class AuthServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");

		int lineNo = Integer.parseInt(request.getParameter("LINE_NO"));
		int docNo = Integer.parseInt(request.getParameter("DOC_NO"));
		int vacNo = Integer.parseInt(request.getParameter("VAC_NO"));
		int busNo = Integer.parseInt(request.getParameter("BUS_NO"));

		AuthMgr aMgr = new AuthMgr();


		if ("vacdelete".equals(action)) {

			out.println("<script>");
			out.println("alert('삭제가 완료되었습니다');");
			out.println("window.close();");
			out.println("window.opener.location.reload();"); 
			out.println("</script>");

			aMgr.vacDelete(lineNo,vacNo);

		} else if ("busdelete".equals(action)) {

			out.println("<script>");
			out.println("alert('삭제가 완료되었습니다');");
			out.println("window.close();");
			out.println("window.opener.location.reload();"); 
			out.println("</script>");

			aMgr.busDelete(lineNo,busNo);

		} else if ("first".equals(action)) {

			out.println("<script>");
			out.println("alert('승인처리가 완료되었습니다');");
			out.println("window.close();");
			out.println("window.opener.location.reload();"); 
			out.println("</script>");

			aMgr.AuthFirst(lineNo);

		} else if ("second".equals(action)) {

			out.println("<script>");
			out.println("alert('승인처리가 완료되었습니다');");
			out.println("window.close();");
			out.println("window.opener.location.reload();"); 
			out.println("</script>");
			
			aMgr.AuthSecond(lineNo);
			
		} else if ("reject".equals(action)) {

			out.println("<script>");
			out.println("alert('반려처리가 완료되었습니다');");
			out.println("window.close();");
			out.println("window.opener.location.reload();"); 
			out.println("</script>");

			aMgr.AuthReject(docNo);
		} else if ("second1".equals(action)) {
			aMgr.AuthSecond(lineNo);
			
			String vacNo2 = request.getParameter("VAC_NO");
			response.sendRedirect("mypage/workday/workRest.jsp?VAC_NO="+vacNo2); 
		}
	}
}