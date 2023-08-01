package schedule;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateScheduleServlet")
public class UpdateScheduleServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		ScheduleMgr sMgr = new ScheduleMgr();
		ScheduleBean bean = (ScheduleBean) session.getAttribute("bean");
		
		ScheduleBean upBean = new ScheduleBean();
		
		upBean.setSCHE_NO(Integer.parseInt(request.getParameter("SCHE_NO")));
		upBean.setSCHE_NAME(request.getParameter("SCHE_NAME"));
		upBean.setSCHE_START_DATE(request.getParameter("SCHE_START_DATE"));
		upBean.setST_NO(Integer.parseInt(request.getParameter("ST_NO")));
		upBean.setSCHE_END_DATE(request.getParameter("SCHE_END_DATE"));
		upBean.setEND_NO(Integer.parseInt(request.getParameter("END_NO")));
		upBean.setSCHE_DETAIL(request.getParameter("SCHE_DETAIL"));
		upBean.setSCHE_FILE(request.getParameter("SCHE_FILE"));
		upBean.setTYPE_NO(Integer.parseInt(request.getParameter("TYPE_NO")));
		upBean.setPART_NO(Integer.parseInt(request.getParameter("PART_NO")));
		
		sMgr.updateSchedule(upBean);
		String url = "../../GNCART/05schedule/jsp/"+"shceduleDetail.jsp?SCHE_NO="+upBean.getSCHE_NO();
		
		response.sendRedirect(url);
	} 

}
