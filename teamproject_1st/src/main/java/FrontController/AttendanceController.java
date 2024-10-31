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
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
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
<<<<<<< HEAD
				if(searchType.equals("ê°•ì˜")) {
					sqlTotal += "  order by  duringclass desc limit ?, ? ";
=======
				if(searchType!= null &&searchType.equals("°­ÀÇ")) {
					sqlTotal += "  order by  duringclass desc";
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
				}
				
			psmtTotal = conn.prepareStatement(sqlTotal);
			psmtTotal.setInt(1,uno);
				
			rsTotal = psmtTotal.executeQuery();
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
<<<<<<< HEAD
			String sql = " select * , t.stotal "
						+ "    from "
						+ "        class as c "
						+ "    inner join"
						+ "        (select count(*) as stotal , cno  FROM app_class where state ='E' group by cno) as t "
						+ "	on c.cno = t.cno"
						+ "    where c.state = 'E'";
				if(searchType.equals("ê°•ì˜")) {
					sql += "  order by  duringclass desc limit ?, ? ";
=======
			PagingUtil paging = new PagingUtil(nowPage,total,3);
			
			String sql = " select * ,"
					   + "(select count(*) from app_class a where a.cno=c.cno ) as cnt"
					   + "    from class as c , user u"
					   + "    where c.teacherName = u.name"
					   + "      and c.state = 'E' ";
				if(searchType!= null &&searchType.equals("°­ÀÇ")) {
					sql += "  order by  duringclass desc ";
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
				}
				sql += " limit ?, ?";
				psmt = conn.prepareStatement(sql);
<<<<<<< HEAD
				rs = psmt.executeQuery();
				
=======

				psmt.setInt(1,paging.getStart());
				psmt.setInt(2,paging.getPerPage());
						
				rs = psmt.executeQuery();
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
				 while(rs.next()) {
					ClassVO vo = new ClassVO();
					vo.setCno(rs.getInt("cno"));
					vo.setUno(rs.getInt("uno"));
					vo.setTitle(rs.getString("title"));
					vo.setState(rs.getString("state"));
					vo.setSubject(rs.getString("subject"));
					vo.setDuringclass(rs.getString("duringclass"));
					vo.setCnt(rs.getInt("cnt"));
					
					
					clist.add(vo);
					
				}

				
				
<<<<<<< HEAD
				PagingUtil paging = new PagingUtil(nowPage,total,3);
				
				if(searchType != null && !searchType.equals("null")){
					psmt.setString(1,searchType);
					psmt.setInt(2,paging.getStart());
					psmt.setInt(3,paging.getPerPage());
				}else{
					psmt.setInt(1,paging.getStart());
					psmt.setInt(2,paging.getPerPage());
				}
						
				
=======
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
			
		}catch(Exception e) {
			e.printStackTrace();
			}finally {
			try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
<<<<<<< HEAD
		// ï¿½ðµ¨¿ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½Í¸ï¿½ ï¿½ï¿½ï¿½ï¿½
		request.setAttribute(searchType, searchType);
		// ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.do").forward(request, response);
=======
		// ¸ðµ¨¿¡ µ¥ÀÌÅÍ¸¦ ÀúÀå
		request.setAttribute("searchType", searchType);
		request.setAttribute("clist", clist);
		// ºä ÆäÀÌÁö¿¡ ¿¬°á
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.jsp").forward(request, response);
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
	}
	
	public void attendanceView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int ano = Integer.parseInt(request.getParameter("ano"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
	}

}
