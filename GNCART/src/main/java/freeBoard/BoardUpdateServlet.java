package freeBoard;
 
 
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import notice.NoticeBean;

@WebServlet("/freeBoard/boardUpdate")
public class BoardUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		BoardMgr bMgr = new BoardMgr();	

		String freeNoParam = request.getParameter("FREE_NO");
		int FREE_NO =  Integer.parseInt(freeNoParam);
		
		BoardBean upBean = new BoardBean();
		upBean.setFREE_NO(FREE_NO);
		upBean.setFREE_TITLE(request.getParameter("FREE_TITLE"));
		upBean.setFREE_CONTENT(request.getParameter("FREE_CONTENT"));
		upBean.setFREE_DATE(request.getParameter("FREE_DATE"));

		bMgr.updateBoard(upBean);
		
	
		out.println("<script>");
		out.println("alert('게시글이 수정되었습니다.');");
		out.println("location.href = 'freeread.jsp?FREE_NO=" + FREE_NO + "';");
		out.println("</script>");
}
}