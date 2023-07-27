package notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/noticeRevise")
public class NoticeReviseServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		NoticeMgr nMgr = new NoticeMgr();

		// read.jsp 페이지에서 이동한 num 파라미터를 받아서 변수에 저장
		String notNoParam = request.getParameter("NOT_NO");
		int NOT_NO = (notNoParam != null && !notNoParam.isEmpty()) ? Integer.parseInt(notNoParam) : 0;

		// NOT_NO가 0인 경우 처리할 코드를 추가해야 합니다.
		if (NOT_NO == 0) {
			// 오류 처리
			out.println("<script>");
			out.println("alert('오류가 발생하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
		int NOTSUB_NO = Integer.parseInt(request.getParameter("NOTSUB_NO"));
		int PART_NO = Integer.parseInt(request.getParameter("PART_NO"));

		// session에 저장된 bean 객체를 이용해서 게시물 정보를 변수에 저장
		NoticeBean bean = nMgr.getNotice(NOT_NO);

		// 로그인된 사용자의 정보를 가져옴 (세션에서 사용자 정보를 가져오는 코드를 추가해야 합니다.)
		String id = (String)session.getAttribute("memId");

		// 작성자와 로그인된 사용자를 비교하여 권한을 확인
		if (id != null && id.equals(bean.getMEM_ID())) {
			// 변수에 저장된 게시물 정보를 이용하여 값을 설정
			NoticeBean upBean = new NoticeBean();
			upBean.setNOT_NO(NOT_NO);
			upBean.setMEM_NO(bean.getMEM_NO());
			upBean.setNOTSUB_NO(NOTSUB_NO);
			upBean.setNOT_TITLE(request.getParameter("NOT_TITLE"));
			upBean.setNOT_CONTENT(request.getParameter("NOT_CONTENT"));
			upBean.setNOT_DATE(bean.getNOT_DATE());
			upBean.setMEM_ID(bean.getMEM_ID());
			upBean.setPART_NO(PART_NO);

			// 공지사항을 수정
			nMgr.reviseNotice(upBean);

			out.println("<script>");
			out.println("alert('게시글이 수정되었습니다.');");
			out.println("location.href = 'notice/noticeView.jsp?NOT_NO=" + NOT_NO + "';");
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