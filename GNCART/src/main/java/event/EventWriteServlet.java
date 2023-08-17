package event;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/eventWrite")
public class EventWriteServlet extends HttpServlet {

	//servlet 을 이용하여 이용할 클래스 의 객체를 생성하고, 메서드를 호출 한다.
	//기존의 jsp 페이지 에서 자바 빈즈 로 usebean 이용하여 이용할 클래스 선언하고, 
	//스크립트릿 태그로 했던 작업을 servlet 클래스로 처리 한다.

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		//BoardMgr 클래스 객체 생성
		EventMgr eMgr = new EventMgr();

		// 세션의 acNo와 partNo 값을 가져옵니다.
		int acNo = (int)session.getAttribute("acNo");
		int partNo = (int)session.getAttribute("partNo");

		// acNo와 partNo가 특정 조건을 만족하는 경우에만 insertNotice() 메서드를 호출합니다.
		if (acNo == 2 || partNo == 1) {
			// BoardMgr 클래스에 정의된 insertBoard() 메서드를 호출한다.
			// 매개변수를 request(요청) 객체로 하여, insertBoard() 메서드 안에서 파라미터를 처리할 수 있다.
			eMgr.insertEvent(request);

			out.println("<script>");
			out.println("alert('게시글이 등록되었습니다.');");
			out.println("location.href = 'event/event.jsp';");
			out.println("</script>");
		} else {
			// acNo와 partNo가 특정 조건을 만족하지 않는 경우에 대한 처리를 할 수 있습니다.
			// 예를 들어, 권한이 없다는 메시지를 출력하거나 다른 페이지로 이동할 수 있습니다.
			// 여기서는 메시지를 출력하고 뒤로 이동하는 예시를 보여줍니다.
			out.println("<script>");
			out.println("alert('게시글 작성 권한이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}