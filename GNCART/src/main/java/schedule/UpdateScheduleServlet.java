package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/UpdateScheduleServlet")
public class UpdateScheduleServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("서블릿 진입");

		request.setCharacterEncoding("UTF-8");

		ScheduleMgr sMgr = new ScheduleMgr();
		
		sMgr.updateSchedule(request, response);
//
//		sMgr.updateSchedule(request, response);
//		int SCHE_NO = Integer.parseInt(request.getParameter("number"));
//		String url = "../../GNCART/schedule/jsp/"+"shceduleDetail.jsp?SCHE_NO="+SCHE_NO;
//		
//		response.sendRedirect(url);
	} 

}