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
import FrontController.vo.UserVO;

public class AttendanceController {
	
	public AttendanceController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException { 
		
		if(comments[comments.length-1].equals("attendanceView.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceView(request,response);
				}
		}else if(comments[comments.length-1].equals("attendanceList.do")) {
			attendanceList(request,response);
		}
	}
	
	public void attendanceList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String searchType = request.getParameter("searchType");
		
		List<ClassVO> clist  = new ArrayList<ClassVO>();
		
		int nowPage = 1;
		
		if(request.getParameter("nowPage") != null){
			//하단에 다른 페이지 번호 클릭시 넘어가는 조건문
			nowPage 
			= Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int uno = loginUser.getUno(); 

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		PreparedStatement psmtTotal = null;
		ResultSet rsTotal = null;
		
		
		try {
			
			conn = DBConn.conn();
			
			
			
			int total = 0;
			String sqlTotal = " select count(*) as total from class c inner join user u on c.uno = u.uno where  u.uno = ? ";
				if(searchType!= null &&searchType.equals("강의")) {
					sqlTotal += "  order by  duringclass desc";
				}
				
			psmtTotal = conn.prepareStatement(sqlTotal);
			psmtTotal.setInt(1,uno);
				
			rsTotal = psmtTotal.executeQuery();
			
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
			PagingUtil paging = new PagingUtil(nowPage,total,3);
			
			String sql = " select * , t.stotal "
						+ "    from "
						+ "        class as c "
						+ "    inner join"
						+ "        (select count(*) as stotal , cno  FROM app_class where state ='E' group by cno) as t "
						+ "	on c.cno = t.cno"
						+ "    where c.state = 'E'";
				if(searchType!= null &&searchType.equals("강의")) {
					sql += "  order by  duringclass desc ";
				}
				sql += " limit ?, ?";
				psmt = conn.prepareStatement(sql);

				psmt.setInt(1,paging.getStart());
				psmt.setInt(2,paging.getPerPage());
						
				rs = psmt.executeQuery();
				 if(rs.next()) {
					ClassVO vo = new ClassVO();
					vo.setCno(rs.getInt("cno"));
					vo.setUno(rs.getInt("uno"));
					vo.setTitle(rs.getString("title"));
					vo.setState(rs.getString("state"));
					vo.setSubject(rs.getString("subject"));
					vo.setDuringclass(rs.getString("duringclass"));
					vo.setsTotal(rs.getInt("stotal"));
					
					
					clist.add(vo);
					
				}

				
				
			
		}catch(Exception e) {
			e.printStackTrace();
			}finally {
			try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		// 모델에 데이터를 저장
		request.setAttribute("searchType", searchType);
		request.setAttribute("clist", clist);
		// 뷰 페이지에 연결
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.jsp").forward(request, response);
	}
	
	public void attendanceView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int ano = Integer.parseInt(request.getParameter("ano"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
	}

}
