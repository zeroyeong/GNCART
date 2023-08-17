package event;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/eventRevise")
public class EventReviseServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		EventMgr eMgr = new EventMgr();

		// read.jsp 페이지에서 이동한 num 파라미터를 받아서 변수에 저장
		String EventNo = request.getParameter("EVENT_NO");
		int EVENT_NO = (EventNo != null && !EventNo.isEmpty()) ? Integer.parseInt(EventNo) : 0;

		// NOT_NO가 0인 경우 처리할 코드를 추가해야 합니다.
		if (EVENT_NO == 0) {
			// 오류 처리
			out.println("<script>");
			out.println("alert('오류가 발생하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
		int EVENTSUB_NO = Integer.parseInt(request.getParameter("EVENTSUB_NO"));
		int PART_NO = Integer.parseInt(request.getParameter("PART_NO"));

		// session에 저장된 bean 객체를 이용해서 게시물 정보를 변수에 저장
		EventBean bean = eMgr.getEvent(EVENT_NO);

		// 로그인된 사용자의 정보를 가져옴 (세션에서 사용자 정보를 가져오는 코드를 추가해야 합니다.)
		String id = (String)session.getAttribute("memId");

		// 작성자와 로그인된 사용자를 비교하여 권한을 확인
		if (id != null && id.equals(bean.getMEM_ID())) {
			// 변수에 저장된 게시물 정보를 이용하여 값을 설정
			EventBean upBean = new EventBean();
			upBean.setEVENT_NO(EVENT_NO);
			upBean.setMEM_NO(bean.getMEM_NO());
			upBean.setEVENTSUB_NO(EVENTSUB_NO);
			upBean.setEVENT_TITLE(request.getParameter("EVENT_TITLE"));
			upBean.setEVENT_CONTENT(request.getParameter("EVENT_CONTENT"));
			upBean.setEVENT_DATE(bean.getEVENT_DATE());
			upBean.setMEM_ID(bean.getMEM_ID());
			upBean.setPART_NO(PART_NO);

			// 공지사항을 수정
			eMgr.reviseEvent(upBean);

			out.println("<script>");
			out.println("alert('게시글이 수정되었습니다.');");
			out.println("location.href = 'event/eventView.jsp?EVENT_NO=" + EVENT_NO + "';");
			out.println("</script>");
		} else {
			// 수정 불가능한 사용자라면 권한 에러 메시지 출력
			out.println("<script>");
			out.println("alert('게시글 수정 권한이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}