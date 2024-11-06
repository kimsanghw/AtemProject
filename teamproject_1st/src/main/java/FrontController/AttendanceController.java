package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

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
			}else if(request.getMethod().equals("POST")) {
				
				attendanceViewOk(request,response);
			}
		}else if(comments[comments.length-1].equals("attendanceList.do")) {
			
			if(request.getMethod().equals("GET")) {
			attendanceList(request,response);
			}
		}else if(comments[comments.length-1].equals("attendanceClass.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceClass(request,response);
				}
		}else if(comments[comments.length-1].equals("attendanceCheck.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceCheck(request,response);
				}
		}else if(comments[comments.length-1].equals("attendanceInfoView.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceInfoView(request,response);
				}
		}
	}
	
	public void attendanceInfoView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceInfoView.jsp").forward(request, response);
	}
	
	public void attendanceCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		request.getRequestDispatcher("/WEB-INF/attendance/attendanceCheck.jsp").forward(request, response);
	}
	
	public void attendanceViewOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO)session.getAttribute("loginUser");

	    // AJAX 요청에서 넘어온 출결 상태와 출결 번호
	    String attendanceChange = request.getParameter("attendanceChange");
	    String ano = request.getParameter("ano");
	    String cno = request.getParameter("cno"); // cno 값을 요청에서 받도록 설정
	    System.out.println("---------------------------------------------------------------------");
	    System.out.println(ano);
        System.out.println(attendanceChange);
	    Connection conn = null;
	    PreparedStatement psmt = null;

	    try {
	        conn = DBConn.conn();
	        String sql = "UPDATE attendance SET attendance = ? WHERE ano = ?";
	        psmt = conn.prepareStatement(sql);
	        psmt.setString(1, attendanceChange); // 출결 상태 업데이트
	        psmt.setInt(2, Integer.parseInt(ano)); // 출결 번호로 특정 행 선택
	        System.out.println("---------------------------------------------------------------------");
	        System.out.println(ano);
	        System.out.println(attendanceChange);
	        int rowsAffected = psmt.executeUpdate();

	        response.setCharacterEncoding("utf-8");
	        response.setContentType("text/html;");
	        if (rowsAffected > 0) {
	            response.getWriter().write("success");
	        } else {
	            response.getWriter().write("fail");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("error:" + e.getMessage());
	    } finally {
	        try {
	            DBConn.close(psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    // cno 속성을 JSP로 전달
	    if (cno != null) {
	        request.setAttribute("cno", Integer.parseInt(cno));
	    } else {
	        // cno가 null인 경우에 대한 기본 처리 (예: 기본값 설정 등)
	        request.setAttribute("cno", 0);  // 기본값 설정 (필요에 따라 다르게 설정 가능)
	    }
	    
	    System.out.println("Received ano: " + ano);
	    System.out.println("Received attendanceChange: " + attendanceChange);

		
	}
	
	public void attendanceClass(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		List<ClassVO> clist  = new ArrayList<ClassVO>();
		int uno = loginUser.getUno();
		String cno = request.getParameter("cno");
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConn.conn();
			
			
			String sql  = " SELECT "
					    + "    c.cno, "
					    + "    u.uno, "
						+ "    c.title ,"
						+ "    c.subject ,"
						+ "    c.state ,"
						+ "    c.difficult ,"
						+ "    c.book ,"
						+ "    c.duringclass,"
						+ "    c.end_duringclass"
						+ " FROM "
						+ "     class c"
						+ " JOIN "
						+ "   app_class ac ON ac.cno = c.cno"
						+ " JOIN "
						+ "    USER u ON c.uno = u.uno"
						+ " WHERE "
						+ "    ac.uno = ?        "
						+ "    AND c.state = 'E'  "
						+ "    AND ac.state = 'E'"
						+ "    AND c.end_duringclass > NOW()";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, uno);
			
			rs = psmt.executeQuery();
			
			 while(rs.next()) {
				 
					ClassVO vo = new ClassVO();
					vo.setCno(rs.getInt("cno"));
					vo.setUno(rs.getInt("uno"));
					vo.setTitle(rs.getString("title"));
					vo.setState(rs.getString("state"));
					vo.setSubject(rs.getString("subject"));
					vo.setDuringclass(rs.getString("duringclass"));
					vo.setEnd_duringclass(rs.getString("End_duringclass"));
					vo.setDifficult(rs.getString("difficult"));
					vo.setBook(rs.getString("book"));
					
					
					clist.add(vo);
					
				}
			 
			   request.setAttribute("clist", clist);
			   System.out.println(clist);
			   
			   request.getRequestDispatcher("/WEB-INF/attendance/attendanceClass.jsp").forward(request, response);
			
			
		}catch(Exception e) {
			e.printStackTrace();
			}finally {
				
				try {
					DBConn.close(rs, psmt, conn);
				} catch (Exception e) {
					e.printStackTrace();
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
		String name = loginUser.getName();

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
			psmtTotal.setString(2, name);
				
			rsTotal = psmtTotal.executeQuery();
			
				if(rsTotal.next()){
					total = rsTotal.getInt("total");
				}
				
	
			PagingUtil paging = new PagingUtil(nowPage,total,3);
			
	
			/*------전체 페이지에 대한 list쿼리*/
			
			String sql = " select * ,"
					   + "(select count(*) from app_class a where a.cno = c.cno ) as cnt"
					   + "    from class as c , user u"
					   + "    where c.name = u.name"
					   + "      and c.state = 'E' "
					   + "      and u.name = ?";
					   
				if(searchType!= null &&searchType.equals("강의")) {
					sql += " order by  duringclass desc ";
				}
				sql += " limit ?, ?";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, name);  // 이름 조건 추가
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
		
	}
	
	public void attendanceView (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO)session.getAttribute("loginUser");    
	    List<App_classVO> attendanceList  = new ArrayList<>();
	    if (attendanceList == null) {
	        attendanceList = new ArrayList<>(); // 빈 리스트로 초기화
	    }
	    String selectedDate = request.getParameter("date"); // 선택한 날짜 가져오기
	    String todayDate = request.getParameter("now()");
	    int cno = Integer.parseInt(request.getParameter("cno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		
		
		try {
			conn = DBConn.conn();
			
			String sql = " SELECT u.uno AS 학생번호, u.name AS 학생이름, a.attendance AS 출결상태, "
	                   + " a.rdate AS 출결일자, a.ano AS 출결번호 "
	                   + " FROM attendance a "
	                   + " JOIN USER u ON a.uno = u.uno "
	                   + " JOIN class c ON a.cno = c.cno "
	                   + " WHERE c.cno = ? "
	                   + " AND DATE(a.rdate) = ?"  
	                   + " AND a.state = 'E' AND u.state = 'E' AND c.state = 'E'";

			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,cno);
			if (selectedDate != null) {
	            psmt.setString(2, selectedDate);
	            System.out.println(selectedDate);
	        }else {
	            // 현재 날짜를 기본 값으로 설정
	            todayDate = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
	            psmt.setString(2, todayDate); // 기본 날짜로 오늘 날짜 설정
	        }
		    rs = psmt.executeQuery();
		    System.out.println(selectedDate);
	        
	        while (rs.next()) {
	        	App_classVO studentInfo = new App_classVO();
	            studentInfo.setUno(rs.getInt("학생번호"));
	            studentInfo.setName(rs.getString("학생이름"));
	            studentInfo.setAttendance(rs.getString("출결상태"));
	            studentInfo.setRdate(rs.getString("출결일자"));
	            studentInfo.setAno(rs.getInt("출결번호"));

	            attendanceList.add(studentInfo);
	        }
	        request.setAttribute("attendanceList", attendanceList);
			request.setAttribute("cno", cno );
			request.setAttribute("selectedDate", selectedDate);
			System.out.println(selectedDate);
			request.setAttribute("todayDate", todayDate);
			
			
			if (attendanceList.isEmpty()) {
			    System.out.println("조회된 출석 데이터가 없습니다.");
			} else {
			    System.out.println("출석 데이터 조회 성공: " + attendanceList.size() + "개의 데이터가 있습니다.");
			}
			
			
			request.getRequestDispatcher("/WEB-INF/attendance/attendanceView.jsp").forward(request, response);
			
		}catch(Exception e) {
			e.printStackTrace();
			}finally {
				
				try {
					DBConn.close(rs, psmt, conn);
				} catch (Exception e) {
					
					e.printStackTrace();
				}
		}
		 
		
	}

}
