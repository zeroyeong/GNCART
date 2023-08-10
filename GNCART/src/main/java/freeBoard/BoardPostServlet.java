package freeBoard;
   
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/freeBoard/boardPost")
public class BoardPostServlet extends HttpServlet {

	//servlet 을 이용하여 이용할 클래스 의 객체를 생성하고, 메서드를 호출 한다.
	//기존의 jsp 페이지 에서 자바 빈즈 로 usebean 이용하여 이용할 클래스 선언하고, 
	//스크립트릿 태그로 했던 작업을 servlet 클래스로 처리 한다.

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
	
		System.out.println("boardpostservlet 진입.");
		
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");
		
		int partNo = (int)session.getAttribute("partNo");
		
		String MEM_NO = request.getParameter("MEM_NO");
		String MEM_NAME = request.getParameter("MEM_NAME");
		System.out.println(MEM_NAME);
		String FREE_TITLE = request.getParameter("FREE_TITLE");
		System.out.println(FREE_TITLE);
		String FREE_CONTENT = request.getParameter("FREE_CONTENT");
		System.out.println(FREE_CONTENT);
		String FREE_FILENAME = request.getParameter("FREE_FILENAME");
		System.out.println(FREE_FILENAME);
		String PART_NO = request.getParameter("PART_NO");
		
		System.out.println("객체생성 전");
		//BoardMgr 클래스 객체 생성
		BoardMgr bMgr = new BoardMgr();
		System.out.println("객체생성 후");
		
		//BoardMgr 클래스에 정의된 insertBoard() 메서드를 호출한다.
		//매개변수를 request(요청) 객체 로 하여, insertBoard() 메서드 안에서 파라미터 를 처리 할 수 있다.
		System.out.println("insertBoard 메서드 호출 전");
		bMgr.insertBoard(request);
		System.out.println("insertBoard 메서드 호출 후");
		
		//응답 시 list.jsp 페이지로 이동한다.
		System.out.println("response 전");
		response.sendRedirect("free.jsp");
		System.out.println("response 후");
	}
}

