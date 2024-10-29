package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import FrontController.util.DBConn;

public class AttendanceController {
	
	public AttendanceController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException { 
		
		if(comments[comments.length-1].equals("attendanceView.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceView(request,response);
				}
		}else if(comments[comments.length-1].equals("attendanceList.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceList(request,response);
				}
		}
	}
	
	
	public void attendanceList(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String search_mode = request.getParameter("search_mode");
		
		int ano = Integer.parseInt(request.getParameter("ano"));
		
		int uno = (Integer)session.getAttribute("uno"); 
		String title = request.getParameter("title"); 
		String Tname = request.getParameter("name");
		String subject = request.getParameter("subject");
		String jdate = request.getParameter("jdate");
		String diffcult = request.getParameter("diffcult");
		String duringclass = request.getParameter("duringclass");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		PreparedStatement psmtTotal = null;
		ResultSet rsTotal = null;
		
		try {
			
			
			String sqlTotal = "select count(*) as total from class c inner join user u on c.uno = u.uno where  u.uno = ?";
				if(search_mode.value("°­ÀÇ")) {}
			
			
		}catch(Exception e) {
			e.printStackTrace();
			}finally {
			try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				
				e.printStackTrace();
			}}
	}
	
	public void attendanceView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int ano = Integer.parseInt(request.getParameter("ano"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
	}

}
