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
			
			if(request.getMethod().equals("GET")) {
			attendanceList(request,response);
			}
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

			nowPage 
			= Integer.parseInt(request.getParameter("nowPage"));

		}
		
		
		
		int uno = loginUser.getUno();
		String teacherName = loginUser.getName();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		PreparedStatement psmtTotal = null;
		ResultSet rsTotal = null;
		
		
		try {
			
			conn = DBConn.conn();

			int total = 0;

			String sqlTotal = " select count(*) as total from class c inner join user u on c.uno = u.uno where  u.uno = ? ";

				if(searchType.equals("강의")) {
					sqlTotal += "  order by  duringclass desc limit ?, ? ";

				if(searchType!= null &&searchType.equals("����")) {
					sqlTotal += "  order by  duringclass desc";

				}

			String sqlTotal = "SELECT count(*) as total "
                    		+ "FROM class c "
                    		+ "INNER JOIN user u ON c.uno = u.uno "
                    		+ "WHERE u.uno = ? "
                    		+ "AND u.name = ?";
			if(searchType!= null &&searchType.equals("����")) {
				sqlTotal += " order by  duringclass desc ";
			}
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
				
			psmtTotal = conn.prepareStatement(sqlTotal);
			psmtTotal.setInt(1,uno);
			psmtTotal.setString(2, teacherName);
				
			rsTotal = psmtTotal.executeQuery();
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
<<<<<<< HEAD
<<<<<<< HEAD
			String sql = " select * , t.stotal "
						+ "    from "
						+ "        class as c "
						+ "    inner join"
						+ "        (select count(*) as stotal , cno  FROM app_class where state ='E' group by cno) as t "
						+ "	on c.cno = t.cno"
						+ "    where c.state = 'E'";
				if(searchType.equals("강의")) {
					sql += "  order by  duringclass desc limit ?, ? ";
=======
=======
	
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
			PagingUtil paging = new PagingUtil(nowPage,total,3);
			
	
			/*------��ü �������� ���� list����*/
			
			String sql = " select * ,"
					   + "(select count(*) from app_class a where a.cno = c.cno ) as cnt"
					   + "    from class as c , user u"
					   + "    where c.teacherName = u.name"
					   + "      and c.state = 'E' "
					   + "      and u.name = ?";
					   
				if(searchType!= null &&searchType.equals("����")) {
<<<<<<< HEAD
					sql += "  order by  duringclass desc ";
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
=======
					sql += " order by  duringclass desc ";
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
				}
				sql += " limit ?, ?";
				psmt = conn.prepareStatement(sql);
<<<<<<< HEAD
<<<<<<< HEAD
				rs = psmt.executeQuery();
				
=======
=======
				psmt.setString(1, teacherName);  // �̸� ���� �߰�
		        psmt.setInt(2, paging.getStart());
		        psmt.setInt(3, paging.getPerPage());
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git

				
				rs = psmt.executeQuery();
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
=======
				
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
			
=======
				 request.setAttribute("paging", paging);
				 request.setAttribute("searchType", searchType);
				 request.setAttribute("clist", clist);
				 
			 
				 

				 request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.jsp").forward(request, response);
				 
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
		// �𵨿� �����͸� ����
		request.setAttribute(searchType, searchType);
		// �� �������� ����
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.do").forward(request, response);
=======
		// �𵨿� �����͸� ����
		/*
		request.setAttribute("searchType", searchType);
		request.setAttribute("clist", clist);
		request.setAttribute("paging", paging);
		
		// �� �������� ����
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.jsp").forward(request, response);
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
=======
		*/
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
	}
	
	public void attendanceView (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceView.jsp").forward(request, response);
		
	}

}
