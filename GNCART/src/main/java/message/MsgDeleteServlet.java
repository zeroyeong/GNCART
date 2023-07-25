package message;

import java.io.IOException;
import static java.lang.System.out;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/message/msgDelete")
public class MsgDeleteServlet extends HttpServlet {

	//servlet 을 이용하여 이용할 클래스 의 객체를 생성하고, 메서드를 호출 한다.
	//기존의 jsp 페이지 에서 자바 빈즈 로 usebean 이용하여 이용할 클래스 선언하고, 
	//스크립트릿 태그로 했던 작업을 servlet 클래스로 처리 한다.

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
				
		MsgMgr msgMgr = new MsgMgr();
		MsgBean bean = new MsgBean();
		
		bean = (MsgBean)request.getAttribute("bean");
			
		System.out.println("no = " + bean.getMem_no());
		//msgMgr.deleteMsg(bean);
			
		String url = "messageInbox.jsp";
		response.sendRedirect(url);
	}
}

