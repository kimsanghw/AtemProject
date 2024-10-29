package FrontController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ClassController {
	public ClassController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
	
		if(comments[comments.length-1].equals("view.do")) {
			if(request.getMethod().equals("GET")){
				view(request,response);
			} else if(request.getMethod().equals("POST")) {
				
			}
		} else if(comments[comments.length-1].equals("class_list.do")) {
			if(request.getMethod().equals("GET")){
				list(request,response);
			}
		}
	}
	
	public void view (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/user/class_view.jsp").forward(request, response);
	}
	public void list (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/user/class_list.jsp").forward(request, response);
	}
}


