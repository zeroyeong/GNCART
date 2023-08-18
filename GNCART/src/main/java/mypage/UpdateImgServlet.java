package mypage;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateImgServlet")
public class UpdateImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");

		MypageMgr pMgr = new MypageMgr();
		
		pMgr.updateImg(request);
		
		String img = request.getParameter("img");
		
		File file = new File("C:\\Users\\Administrator\\git\\GNCART\\GNCART\\GNCART\\src\\main\\webapp\\management\\filestorage\\"+img);
	    
		if(file.exists() ){ //파일 유무 확인
			if(file.delete()){ //파일 삭제
				response.sendRedirect("mypage/mypageMain.jsp");
			}else{ //삭제 실패
				response.sendRedirect("mypage/mypageMain.jsp");
			}
		}else{ //파일 없으면
			response.sendRedirect("mypage/mypageMain.jsp");
		}
	}
}
