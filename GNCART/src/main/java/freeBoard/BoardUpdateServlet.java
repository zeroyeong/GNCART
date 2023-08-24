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

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter(); 

		BoardMgr bMgr = new BoardMgr();
		
		//BoardBean 클래스 객체인 bean에 session에 저장된 게시물 bean 데이터를 대입한다.
		String freeNoParam = request.getParameter("FREE_NO");
		int FREE_NO = Integer.parseInt(request.getParameter("FREE_NO"));
		int PART_NO = Integer.parseInt(request.getParameter("PART_NO"));

		// session에 저장된 bean 객체를 이용해서 게시물 정보를 변수에 저장
		BoardBean bean = bMgr.getBoard(FREE_NO);

		// 로그인된 사용자의 정보를 가져옴 (세션에서 사용자 정보를 가져오는 코드를 추가해야 합니다.)
		String id = (String)session.getAttribute("memId");

		// 작성자와 로그인된 사용자를 비교하여 권한을 확인

			// 변수에 저장된 게시물 정보를 이용하여 값을 설정
			BoardBean upBean = new BoardBean();
			upBean.setFREE_NO(FREE_NO);
			upBean.setMEM_NO(bean.getMEM_NO());
			upBean.setFREE_TITLE(request.getParameter("FREE_TITLE"));
			upBean.setFREE_CONTENT(request.getParameter("FREE_CONTENT"));
			upBean.setFREE_DATE(bean.getFREE_DATE());
			upBean.setMEM_ID(bean.getMEM_ID());
			upBean.setPART_NO(PART_NO);

	
		bMgr.updateBoard(upBean);
	}
}