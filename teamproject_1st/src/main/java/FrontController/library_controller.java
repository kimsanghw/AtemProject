package FrontController;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import FrontController.util.*;
import FrontController.vo.UserVO;




public class library_controller {

	public library_controller(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException {
		
		if(comments[comments.length-1].equals("library_list.do")) {
			if(request.getMethod().equals("GET")){
				library_list(request,response);	
			}
		}else if(comments[comments.length-1].equals("library_write.do")) {
			if(request.getMethod().equals("GET")){
				library_write(request,response);	
			}else if(request.getMethod().equals("POST")){
				library_writeok(request,response);	
			}
		}else if(comments[comments.length-1].equals("library_view.do")) {
			if(request.getMethod().equals("GET")){
				library_view(request,response);	
			}
		}else if(comments[comments.length-1].equals("library_modify.do")) {
			if(request.getMethod().equals("GET")){
				library_modify(request,response);	
			}else if(request.getMethod().equals("POST")) {
				//수정페이지에서 데이터 수정 후 서브밋 했을 때
				library_modifyOk(request,response);
			}
		}
	}

	private void library_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/library_board/library_list.jsp").forward(request, response);
		
		request.setCharacterEncoding("UTF-8");
	}
	private void library_write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/library_board/library_write.jsp").forward(request, response);
		
	}
	private void library_view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/library_board/library_view.jsp").forward(request, response);
		
	}
	private void library_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/library_board/library_modify.jsp").forward(request, response);
		
	}
	private void library_modifyOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	private void library_writeok(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		UserVO loginVO = (UserVO)session.getAttribute("loginUser");
				
		Connection conn = null;// DB 연결
		PreparedStatement psmt = null;// SQL 등록 실행
		
		try {
			conn = DBConn.conn();
			
			String sql = "insert into library( title,content,uno) values(?,?,?)";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, title); 
			psmt.setString(2, content); 
			psmt.setInt(3, loginVO.getUno()); 
			
			int result = psmt.executeUpdate();  // SQL 실행 (데이터 삽입)
			
			if(result > 0) {
				response.sendRedirect("library_list.do");
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBConn.close(psmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}



}
