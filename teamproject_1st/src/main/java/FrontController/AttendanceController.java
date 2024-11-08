package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
				} else if(request.getMethod().equals("POST")) {
					attendanceCheckOk(request,response);
				}
		}else if(comments[comments.length-1].equals("attendanceInfoView.do")) {
			if(request.getMethod().equals("GET")) {
				attendanceInfoView(request,response);
				}
		}else if(comments[comments.length-1].equals("updateRandom_number.do")) {
			if(request.getMethod().equals("POST")) {
				updateRandom_number(request,response);
				}
		}
	}
	
	
	public void updateRandom_number(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    response.setContentType("text/html; charset=UTF-8");
	    response.setCharacterEncoding("utf-8");

	    String cno = request.getParameter("cno");
	    String randomNumberParam = request.getParameter("random_number");

	    if (cno == null || cno.isEmpty() || randomNumberParam == null || randomNumberParam.isEmpty()) {
	        response.getWriter().write("fail");
	        return;
	    }

	    int random_number;
	    try {
	        random_number = Integer.parseInt(randomNumberParam); // 전달된 인증번호 파싱
	    } catch (NumberFormatException e) {
	        response.getWriter().write("fail");
	        return;
	    }
	    System.out.println("cno : "+ cno);
	    System.out.println("random_number : "+ randomNumberParam);
	    // 데이터베이스에 저장
	    try (Connection conn = DBConn.conn();
	         PreparedStatement psmt = conn.prepareStatement("UPDATE class SET random_number = ? WHERE cno = ?")) {
	        
	        psmt.setInt(1, random_number); // 생성된 인증코드 설정
	        psmt.setInt(2, Integer.parseInt(cno)); // cno에 맞는 강의 선택

	        int rowsAffected = psmt.executeUpdate();
	        if (rowsAffected > 0) {
	            response.getWriter().write("success");
	        } else {
	            response.getWriter().write("fail");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("error:" + e.getMessage());
	    }
	    
	}
	public void attendanceInfoView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	    String userId = loginUser != null ? loginUser.getId() : null;

	    List<Map<String, Object>> attendanceData = new ArrayList<>();

	    if (userId != null) {
	        Connection conn = null;
	        PreparedStatement psmt = null;
	        ResultSet rs = null;

	        try {
	            conn = DBConn.conn();
	            String sql = "SELECT a.rdate, a.attendance AS status FROM attendance a " +
	                         "JOIN app_class ac ON a.cno = ac.cno " +
	                         "JOIN user u ON a.uno = u.uno " +
	                         "WHERE u.id = ?";
	            psmt = conn.prepareStatement(sql);
	            psmt.setString(1, userId);
	            rs = psmt.executeQuery();

	            // 날짜별로 상태를 합치는 Map
	            Map<String, String> attendanceMap = new HashMap<>();

	            while (rs.next()) {
	                String date = rs.getString("rdate");
	                String status = rs.getString("status");

	                // 이미 해당 날짜에 출석 상태가 있는 경우
	                if (attendanceMap.containsKey(date)) {
	                    // 예를 들어, '출석' > '지각' > '결석' 순으로 우선순위로 선택
	                    String existingStatus = attendanceMap.get(date);
	                    if (existingStatus.equals("결석") && !status.equals("결석")) {
	                        attendanceMap.put(date, status);
	                    } else if (existingStatus.equals("지각") && !status.equals("결석") && !status.equals("지각")) {
	                        attendanceMap.put(date, status);
	                    } else if (existingStatus.equals("출석") && !status.equals("출석")) {
	                        // 이미 '출석'인 경우 다른 상태로 바뀌지 않음
	                    }
	                } else {
	                    attendanceMap.put(date, status);
	                }
	            }

	            // Map에서 데이터를 리스트로 변환
	            for (Map.Entry<String, String> entry : attendanceMap.entrySet()) {
	                Map<String, Object> data = new HashMap<>();
	                data.put("date", entry.getKey());
	                data.put("status", entry.getValue());
	                attendanceData.add(data);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                DBConn.close(rs, psmt, conn);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    request.setAttribute("attendanceData", attendanceData);
	    request.getRequestDispatcher("/WEB-INF/attendance/attendanceInfoView.jsp").forward(request, response);
	}

	
	public void attendanceCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser != null) {
		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;

		    try {
		        conn = DBConn.conn();
		        String sql = "SELECT c.* FROM class c " +
		                     "JOIN app_class ac ON c.cno = ac.cno " +
		                     "JOIN user u ON ac.uno = u.uno " +
		                     "WHERE u.id = ?";
		        
		        psmt = conn.prepareStatement(sql);
		        psmt.setString(1, loginUser.getId());
		        rs = psmt.executeQuery();

		        if (rs.next()) {
		            ClassVO vo = new ClassVO();
		            vo.setCno(rs.getInt("cno"));
		            vo.setRandom_number(rs.getInt("random_number"));
		            vo.setTitle(rs.getString("title"));
		            // 필요한 다른 필드들도 설정
		            
		            // session에 vo 객체 저장
		            session.setAttribute("vo", vo);
		        }

		        // attendanceCheck.jsp로 포워드
		        request.getRequestDispatcher("/WEB-INF/attendance/attendanceCheck.jsp").forward(request, response);
		    } catch (Exception e) {
		            e.printStackTrace();
		            
		        } finally {
		            try {
						DBConn.close(rs, psmt, conn);
					} catch (Exception e) {
						e.printStackTrace();
					}
		        
		        }
		    
		
		    }
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
	
	public void attendanceView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	    List<App_classVO> attendanceList = new ArrayList<>();
	    String selectedDate = request.getParameter("date");
	    String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
	    int cno = Integer.parseInt(request.getParameter("cno"));

	    Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DBConn.conn();

	        // 모든 학생 목록과 출결 정보 조회 쿼리
	        String sql = "SELECT u.uno AS 학생번호, u.name AS 학생이름, "
	                   + "COALESCE(a.attendance, '미등록') AS 출결상태, a.rdate AS 출결일자, "
	                   + "COALESCE(a.ano, -1) AS 출결번호 "
	                   + "FROM app_class ac "
	                   + "JOIN user u ON ac.uno = u.uno "
	                   + "JOIN class c ON ac.cno = c.cno "
	                   + "LEFT JOIN attendance a ON ac.uno = a.uno AND ac.cno = a.cno AND DATE(a.rdate) = ? "
	                   + "WHERE ac.cno = ? AND ac.state = 'E' AND u.state = 'E'";

	        psmt = conn.prepareStatement(sql);
	        psmt.setString(1, selectedDate != null ? selectedDate : todayDate);
	        psmt.setInt(2, cno);

	        rs = psmt.executeQuery();

	        while (rs.next()) {
	            App_classVO studentInfo = new App_classVO();
	            studentInfo.setUno(rs.getInt("학생번호"));
	            studentInfo.setName(rs.getString("학생이름"));
	            studentInfo.setAttendance(rs.getString("출결상태"));
	            studentInfo.setRdate(rs.getString("출결일자"));
	            studentInfo.setAno(rs.getInt("출결번호") == 0 ? -1 : rs.getInt("출결번호"));

	            attendanceList.add(studentInfo);
	        }

	        request.setAttribute("attendanceList", attendanceList);
	        request.setAttribute("cno", cno);
	        request.setAttribute("selectedDate", selectedDate != null ? selectedDate : todayDate);

	        request.getRequestDispatcher("/WEB-INF/attendance/attendanceView.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}
	public void attendanceCheckOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); // 응답 객체에 UTF-8 설정 추가

		HttpSession session = request.getSession();
		ClassVO vo = (ClassVO) session.getAttribute("vo");

		if (vo != null) {
		    // 세션에서 ClassVO 객체를 가져와 cno를 추출
		    int cno = vo.getCno();
		    
		    // 요청 파라미터로 받은 인증 코드
		    String enteredCode = request.getParameter("authCode");
		    
		    // 만약 authCode가 비어있으면 처리할 수 없으므로 종료
		    if (enteredCode == null || enteredCode.trim().isEmpty()) {
		        response.getWriter().write("{\"status\": \"fail\", \"message\": \"인증 코드를 입력해주세요.\"}");
		        return;
		    }

		    // DB 연결 준비
		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;

		    try {
		        conn = DBConn.conn();
		        String sql = "SELECT random_number FROM class WHERE cno = ?";
		        
		        // cno를 이용해 DB에서 random_number 값을 조회
		        psmt = conn.prepareStatement(sql);
		        psmt.setInt(1, cno);
		        rs = psmt.executeQuery();
		        
		        if (rs.next()) {
		            // DB에서 조회한 random_number와 비교
		            String validCode = rs.getString("random_number");
		            System.out.println("Database random_number: " + validCode);
		            if (enteredCode.equals(validCode)) {
		                // 인증 코드가 맞으면 출석 기록 저장 로직
		                response.getWriter().write("{\"status\": \"success\", \"message\": \"출석 체크 완료!\"}");
		            } else {
		                response.getWriter().write("{\"status\": \"fail\", \"message\": \"인증 코드가 올바르지 않습니다.\"}");
		            }
		        } else {
		            // 해당 cno에 해당하는 클래스가 없을 경우
		            response.getWriter().write("{\"status\": \"fail\", \"message\": \"해당하는 수업을 찾을 수 없습니다.\"}");
		        }
		    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
	    }
	    
	    response.sendRedirect(request.getContextPath() + "/attendance/attendanceCheck.do");
	    //request.getRequestDispatcher("/WEB-INF/attendance/attendanceCheck.jsp").forward(request, response);
	}
	}
}

