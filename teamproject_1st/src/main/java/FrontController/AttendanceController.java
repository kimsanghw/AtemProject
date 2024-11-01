package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import FrontController.util.DBConn;
import FrontController.util.PagingUtil;
import FrontController.vo.App_classVO;
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
		
		if(request.getParameter("nowPage") != null && !request.getParameter("nowPage").isEmpty()){
		    nowPage = Integer.parseInt(request.getParameter("nowPage"));
		} else {
		    nowPage = 1;
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
			
			
			/*   전체페이지 갯수에 대한 쿼리*/
			int total = 0;
			String sqlTotal = "SELECT count(*) as total "
                    		+ "FROM class c "
                    		+ "INNER JOIN user u ON c.uno = u.uno "
                    		+ "WHERE u.uno = ? "
                    		+ "AND u.name = ?";
			if(searchType!= null &&searchType.equals("강의")) {
				sqlTotal += " order by  duringclass desc ";
			}
				
			psmtTotal = conn.prepareStatement(sqlTotal);
			psmtTotal.setInt(1,uno);
			psmtTotal.setString(2, teacherName);
				
			rsTotal = psmtTotal.executeQuery();
			
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
	
			PagingUtil paging = new PagingUtil(nowPage,total,3);
			
	
			/*------전체 페이지에 대한 list쿼리*/
			
			String sql = " select * ,"
					   + "(select count(*) from app_class a where a.cno = c.cno ) as cnt"
					   + "    from class as c , user u"
					   + "    where c.teacherName = u.name"
					   + "      and c.state = 'E' "
					   + "      and u.name = ?";
					   
				if(searchType!= null &&searchType.equals("강의")) {
					sql += " order by  duringclass desc ";
				}
				sql += " limit ?, ?";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, teacherName);  // 이름 조건 추가
		        psmt.setInt(2, paging.getStart());
		        psmt.setInt(3, paging.getPerPage());

				
				rs = psmt.executeQuery();
				
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
				

				 request.setAttribute("paging", paging);
				 request.setAttribute("searchType", searchType);
				 request.setAttribute("clist", clist);
				 
			 
				 

				 request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.jsp").forward(request, response);
				 
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
		/*
		request.setAttribute("searchType", searchType);
		request.setAttribute("clist", clist);
		request.setAttribute("paging", paging);
		
		// 뷰 페이지에 연결
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceList.jsp").forward(request, response);
		*/
	}
	
	public void attendanceView (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		List<ClassVO> clist = (List<ClassVO>)request.getAttribute("clist"); 
		List<App_classVO> attendanceList  = new ArrayList<>();
		int uno = loginUser.getUno();
		String teacherName = loginUser.getName();
		int classNumber = (clist != null && !clist.isEmpty()) ? clist.get(0).getCno() : 0;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String selectedDate = request.getParameter("date");
		
		
		try {
			conn = DBConn.conn();
			
			String sql  = "SELECT " 
						+ "    u.uno AS 학생번호, " 
						+ "    u.name AS 학생이름, " 
						+ "    u.id AS 학생아이디, "  
	                    + "    a.attendance AS 출결상태, " 
	                    + "    a.rdate AS 출결일자, "
	                    + "    a.ano As 출결번호, "
	                    + " ac.subject AS 과목, " 
	                    + " FROM " 
	                    + "    attendance a " 
	                    + " JOIN " 
	                    + "    app_class ac ON a.acno = ac.acno " 
	                    + " JOIN " 
	                    + "    USER u ON a.uno = u.uno " 
	                    + " JOIN " 
	                    + "    class c ON ac.cno = c.cno " 
	                    + " WHERE " 
	                    + "    c.cno = ? AND "          
	                    + "    DATE(a.rdate) = ? AND "    
	                    + "    a.state = 'E' AND " 
	                    + "    u.state = 'E' AND " 
	                    + "    ac.state = 'E'";
			
			psmt = conn.prepareStatement(sql);	
			psmt.setInt(1, classNumber);
		    psmt.setString(2, selectedDate);
		    rs = psmt.executeQuery();
		    System.out.println("-------------------------------------------------------------------------------------");
		    System.out.println(classNumber);
		    System.out.println(selectedDate);
	        
	        while (rs.next()) {
	        	App_classVO studentInfo = new App_classVO();
	            studentInfo.setUno(rs.getInt("uno"));
	            studentInfo.setName(rs.getString("name"));
	            studentInfo.setId(rs.getString("id"));
	            studentInfo.setAttendance(rs.getString("attendance"));
	            studentInfo.setRdate(rs.getString("rdate"));
	            studentInfo.setCno(rs.getInt("cno"));
	            studentInfo.setAcno(rs.getInt("acno"));
	            studentInfo.setState(rs.getString("state"));
	            studentInfo.setAno(rs.getInt("ano"));

	            attendanceList.add(studentInfo);
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
		 System.out.println("-------------------------------------------------------------------------------------");
		System.out.println("attendanceList size: " + attendanceList.size());
		request.setAttribute("attendanceList", attendanceList);
		 System.out.println("-------------------------------------------------------------------------------------");
		request.setAttribute("selectedDate", selectedDate);
		System.out.println(selectedDate);
		 System.out.println("-------------------------------------------------------------------------------------");
		request.setAttribute("classNumber",classNumber );
		System.out.println(classNumber);
	
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceView.jsp").forward(request, response);
		
	}

}
