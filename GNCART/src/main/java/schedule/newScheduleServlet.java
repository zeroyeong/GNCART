package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/schedule/newScheduleServlet")
public class newScheduleServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		ScheduleMgr sMgr = new ScheduleMgr();
		
		sMgr.newSchedule(request);
		    
		ScheduleBean bean = sMgr.newScheduleView();
		int SCHE_NO = bean.getSCHE_NO();
		
		String url = "http://localhost:8080/GNCART/schedule/scheduleDetail.jsp?SCHE_NO="+SCHE_NO;

		response.sendRedirect(url);
	}

} 
