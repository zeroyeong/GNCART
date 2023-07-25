package notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/noticeWrite")
public class NoticeWriteServlet extends HttpServlet {

	//servlet 을 이용하여 이용할 클래스 의 객체를 생성하고, 메서드를 호출 한다.
	//기존의 jsp 페이지 에서 자바 빈즈 로 usebean 이용하여 이용할 클래스 선언하고, 
	//스크립트릿 태그로 했던 작업을 servlet 클래스로 처리 한다.

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
	
		request.setCharacterEncoding("UTF-8"); 
		
		//BoardMgr 클래스 객체 생성
		NoticeMgr nMgr = new NoticeMgr();
		
		//BoardMgr 클래스에 정의된 insertBoard() 메서드를 호출한다.
		//매개변수를 request(요청) 객체 로 하여, insertBoard() 메서드 안에서 파라미터 를 처리 할 수 있다.
		nMgr.insertNotice(request);
		
		//응답 시 list.jsp 페이지로 이동한다.
		response.sendRedirect("notice/notice.jsp");
	}
}

