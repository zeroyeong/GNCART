package management;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/management/MemberUpdateServlet")
public class MemberUpdateServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		System.out.println("---------------MemberUpdateServlet 입장.---------------");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter(); 
		
		ManagementMgr mMgr = new ManagementMgr();
		
		ManagementBean bean = (ManagementBean) session.getAttribute("bean");
		
		String nowPage= request.getParameter("nowPage");
		
		ManagementBean upBean = new ManagementBean();
		
		upBean.setMEM_NO(Integer.parseInt(request.getParameter("MEM_NO")));
		upBean.setMEM_NAME(request.getParameter("MEM_NAME"));
		upBean.setMEM_ID(request.getParameter("MEM_ID"));
		upBean.setMEM_PW(request.getParameter("MEM_PW"));
		upBean.setMEM_DATE(request.getParameter("MEM_DATE"));
		upBean.setMEM_TEL(request.getParameter("MEM_TEL"));
		upBean.setMEM_MAIL(request.getParameter("MEM_MAIL"));
		upBean.setMEM_PHONE(request.getParameter("MEM_PHONE"));
		upBean.setMEM_ADD(request.getParameter("MEM_ADD"));
		upBean.setMEM_BIRTH(request.getParameter("MEM_BIRTH"));
		upBean.setMEM_AND(request.getParameter("MEM_AND"));
		upBean.setMEM_IMG(request.getParameter("MEM_IMG"));
		upBean.setAC_NO(Integer.parseInt(request.getParameter("AC_NO")));
		upBean.setWORK_NO(Integer.parseInt(request.getParameter("WORK_NO")));
		upBean.setPART_NO(Integer.parseInt(request.getParameter("PART_NO")));
		upBean.setLE_NO(Integer.parseInt(request.getParameter("LE_NO")));
		upBean.setAP_NO(Integer.parseInt(request.getParameter("AP_NO")));
		System.out.println("화면에서 입력된 AP_NO = " + request.getParameter("AP_NO"));
		System.out.println("화면에서 입력된 MEM_IMG = " + request.getParameter("MEM_IMG"));
		System.out.println("화면에서 입력된 MEM_and = " + request.getParameter("MEM_AND"));
		
		
		mMgr.updateMember(upBean);
		String url = "../../GNCART/management/jsp/"+"readMember.jsp?nowPage="+nowPage+"&MEM_NO="+upBean.getMEM_NO();
		
		response.sendRedirect(url);
	}


}
