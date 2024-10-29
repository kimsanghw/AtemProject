package library_controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class library_list_controller {

	public library_list_controller(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException {
		
		if(comments[comments.length-1].equals("library_list.do")) {
			library_board(request,response);
		}
	}

	private void library_board(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/library_board/library_list.jsp").forward(request, response);
	}


}
