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
	    
	    // session에 저장된 bean 객체를 이용해서 게시물 정보를 변수에 저장
	    NoticeBean bean = nMgr.getNotice(NOT_NO);
	    
	    // 변수에 저장된 게시물 정보를 이용하여 값을 설정
	    NoticeBean upBean = new NoticeBean();
	    upBean.setNOT_NO(NOT_NO);
	    upBean.setMEM_NO(bean.getMEM_NO());
	    upBean.setNOTSUB_NO(NOTSUB_NO);
	    upBean.setNOT_TITLE(request.getParameter("NOT_TITLE"));
	    upBean.setNOT_CONTENT(request.getParameter("NOT_CONTENT"));
	    upBean.setNOT_DATE(bean.getNOT_DATE());
	    
	    // 공지사항을 수정
	    nMgr.reviseNotice(upBean);
	    
	    // 수정된 공지사항을 보여주는 페이지로 이동
	    String url = "notice/noticeView.jsp?NOT_NO=" + NOT_NO;
	    response.sendRedirect(url);
	    
	    }
}
