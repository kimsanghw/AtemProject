package FrontController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyPageController {
	public MyPageController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
		if(comments[comments.length-1].equals("mypage.do")) {
			if(request.getMethod().equals("GET")) {
			mypage(request,response);
			}
		}
	}
		public void mypage(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			request.getRequestDispatcher("/WEB-INF/mypage/mypage.jsp").forward(request, response);
		}
}