package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import FrontController.util.DBConn;
import FrontController.util.PagingUtil;
import FrontController.vo.ClassVO;

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
		List<ClassVO> clist  = new ArrayList<ClassVO>();
		
		int nowPage = 1;
		
		if(request.getParameter("nowPage") != null){
			//하단에 다른 페이지 번호 클릭시 넘어가는 조건문
			nowPage 
			= Integer.parseInt(request.getParameter("nowPage"));
		}

		
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
			
			conn = DBConn.conn();
			
			
			
			int total = 0;
			String sqlTotal = " select count(*) as total from class c inner join user u on c.uno = u.uno where  u.uno = ? ";
				if(search_mode.equals("강의")) {
					sqlTotal += "  order by  duringclass desc limit ?, ? ";
				}
				
			psmtTotal = conn.prepareStatement(sqlTotal);
				if(search_mode != null && !search_mode.equals("null")){
					psmtTotal.setString(1,search_mode);
				}
				
			rsTotal = psmtTotal.executeQuery();
			
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
			PagingUtil paging = new PagingUtil(nowPage,total,3);
			
			String sql = " select cno, title, subject from class c inner join app_class ap on user.uno = c.uno where (select count(*)  FROM app_class where state ='E' and cno=1)";
				if(search_mode.equals("강의")) {
					sql += "  order by  duringclass desc limit ?, ? ";
				}
				psmt = conn.prepareStatement(sql);
				
				if(rs.next()) {
					ClassVO vo = new ClassVO();
					vo.setCno(rs.getInt("cno"));
					vo.setTitle(rs.getString("title"));
					vo.setRdate(rs.getString("rdate"));
					vo.setState(rs.getString("state"));
					vo.setSubject(rs.getString("subject"));
					vo.setDiffcult(rs.getString("diffcult"));
					vo.setDuringclass(rs.getString("duringclass"));
					vo.setJdate(rs.getString("jdate"));
					vo.setBook(rs.getString("book"));
					vo.setTeacherName(rs.getString("teacherName"));
					
					clist.add(vo);
				}
				request.setAttribute("clist", clist);
				
				if(search_mode != null && !search_mode.equals("null")){//검색어가 있는 경우
					psmt.setString(1,search_mode);
					psmt.setInt(2,paging.getStart());
					psmt.setInt(3,paging.getPerPage());
				}else{
					psmt.setInt(1,paging.getStart());
					psmt.setInt(2,paging.getPerPage());
				}
						
				rs = psmt.executeQuery();
			
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
