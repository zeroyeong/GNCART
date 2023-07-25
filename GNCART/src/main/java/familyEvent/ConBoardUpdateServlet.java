package familyEvent;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/familyEvent/conboardUpdate")
public class ConBoardUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
			
		ConMgr conMgr = new ConMgr();
		ConBean upBean = new ConBean();
		upBean = conMgr.updateBoard(request);
				
		int con_no = upBean.getCon_no();
	
		String url = "condolencesDetail.jsp?con_no="+con_no;
		response.sendRedirect(url);
		
	}
}
