package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
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
	    
	public void attendanceViewOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

	    // AJAX 요청에서 넘어온 출결 상태와 출결 번호
	    String attendanceChange = request.getParameter("attendanceChange");
	    String ano = request.getParameter("ano");  // 출결 번호
	 // String cno = request.getParameter("cno");// 강의 번호
       // System.out.println(cno);
	    
	    String cnoStr = request.getParameter("cno");
	    int cno = 0;  // 기본값을 설정합니다.

	    if (cnoStr != null && !cnoStr.isEmpty()) {
	        try {
	            cno = Integer.parseInt(cnoStr);
	        } catch (NumberFormatException e) {
	            System.out.println("cno 값이 유효하지 않습니다: " + cnoStr);
	            response.getWriter().write("fail: invalid cno");
	            return;
	        }
	    }

	    System.out.println("Received ano: " + ano);
	    System.out.println("Received attendanceChange: " + attendanceChange);

	    Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DBConn.conn();
	        
	        // `cno` 값이 class 테이블에 있는지 확인하는 쿼리
	        String checkClassSql = "SELECT COUNT(*) FROM class WHERE cno = ?";
	        psmt = conn.prepareStatement(checkClassSql);
	        psmt.setInt(1, cno);
	        rs = psmt.executeQuery();
	        System.out.println("cno값은"+ cno);
	        boolean classExists = false;
	        if (rs.next()) {
	            classExists = rs.getInt(1) > 0;
	        }
	        System.out.println(1);
	        if (!classExists) {
	            // cno가 class 테이블에 없으면 오류 메시지를 출력하고 종료
	            response.getWriter().write("fail: class does not exist");
	            return;
	        }
	        System.out.println(2);
	        // cno가 존재하는 경우에만 attendance 업데이트 로직을 실행
	        String checkSql = "SELECT COUNT(*) FROM attendance WHERE ano = ?";
	        psmt = conn.prepareStatement(checkSql);
	        psmt.setInt(1, Integer.parseInt(ano));
	        rs = psmt.executeQuery();
	        
	        boolean exists = false;
	        if (rs.next()) {
	            exists = rs.getInt(1) > 0;
	        }
	        System.out.println(3);
	        if (exists) {
	            String updateSql = "UPDATE attendance SET attendance = ? WHERE ano = ?";
	            psmt = conn.prepareStatement(updateSql);
	            psmt.setString(1, attendanceChange);
	            psmt.setInt(2, Integer.parseInt(ano));
	        } else {
	            String insertSql = "INSERT INTO attendance (ano, attendance, cno, rdate) VALUES (?, ?, ?, CURDATE())";
	            psmt = conn.prepareStatement(insertSql);
	            psmt.setInt(1, Integer.parseInt(ano));
	            psmt.setString(2, attendanceChange);
	            psmt.setInt(3, cno);
	        }
	        System.out.println(4);
	        int rowsAffected = psmt.executeUpdate();
	        response.setCharacterEncoding("utf-8");
	        response.setContentType("text/html;");
	        if (rowsAffected > 0) {
	            response.getWriter().write("success");
	        } else {
	            response.getWriter().write("fail");
	        }
	        System.out.println(5);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("error:" + e.getMessage());
	    } finally {
	        try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	   
	}

	
	public void attendanceClass(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

	    // 로그인 상태 확인
	    if (loginUser == null) {
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("text/html;charset=utf-8;");
	        response.getWriter().append("<script>alert('로그인이 필요한 서비스입니다.');location.href='" + request.getContextPath() + "/user/login.do';</script>");
	        return;  // 로그인 페이지로 이동 후 메서드 종료
	    }

	    int uno = loginUser.getUno();
	    int cno = 0;
	    if(request.getParameter("cno") != null) {
	    	cno = Integer.parseInt(request.getParameter("cno"));
	    }
	    System.out.println("loginUserCno"+cno);

	    Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    List<ClassVO> clist = new ArrayList<ClassVO>();

	    try {
	        conn = DBConn.conn();

	        String sql = "SELECT c.cno, u.uno, c.title, c.subject, c.state, c.difficult, c.book, c.duringclass, c.end_duringclass " +
	                     "FROM class c " +
	                     "JOIN app_class ac ON ac.cno = c.cno " +
	                     "JOIN USER u ON c.uno = u.uno " +
	                     "WHERE ac.uno = ? AND c.state = 'E' AND ac.state = 'E' AND c.end_duringclass > NOW()";

	        psmt = conn.prepareStatement(sql);
	        psmt.setInt(1, uno);

	        rs = psmt.executeQuery();

	        while (rs.next()) {
	            ClassVO vo = new ClassVO();
	            vo.setCno(rs.getInt("cno"));
	            vo.setUno(rs.getInt("uno"));
	            vo.setTitle(rs.getString("title"));
	            vo.setState(rs.getString("state"));
	            vo.setSubject(rs.getString("subject"));
	            vo.setDuringclass(rs.getString("duringclass"));
	            vo.setEnd_duringclass(rs.getString("end_duringclass"));
	            vo.setDifficult(rs.getString("difficult"));
	            vo.setBook(rs.getString("book"));
	            clist.add(vo);
	        }

	        request.setAttribute("clist", clist);
	        request.getRequestDispatcher("/WEB-INF/attendance/attendanceClass.jsp").forward(request, response);

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
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        ClassVO vo = (ClassVO) session.getAttribute("vo");
        UserVO userVo = (UserVO) session.getAttribute("loginUser");

        if (vo != null && userVo != null) {
            int cno = vo.getCno();
            int uno = userVo.getUno();
            System.out.println("cno: " + cno);
            String enteredCode = request.getParameter("authCode");
            
            Enumeration<String> names = request.getParameterNames(); 
            while(names.hasMoreElements()) {
                System.out.println("파라메타 이름 : " + names.nextElement());
            }
            System.out.println("Entered Code: " + enteredCode);
            
            if (enteredCode == null || enteredCode.trim().isEmpty()) {
                response.getWriter().write("{\"status\": \"fail\", \"message\": \"인증 코드를 입력해주세요.\"}");
                return;
            }

            Connection conn = null;
            PreparedStatement psmt = null;
            ResultSet rs = null;

            try {
                conn = DBConn.conn();
                
                String checkAttendanceSql = "SELECT COUNT(*) FROM attendance WHERE uno = ? AND cno = ? AND DATE(rdate) = CURDATE()";
                psmt = conn.prepareStatement(checkAttendanceSql);
                psmt.setInt(1, uno);
                psmt.setInt(2, cno);
                rs = psmt.executeQuery();
                
                if (rs.next() && rs.getInt(1) > 0) {
                    response.getWriter().write("{\"status\": \"fail\", \"message\": \"오늘은 이미 출석체크를 하셨습니다.\"}");
                    return;
                }
                String sql = "SELECT random_number FROM class WHERE cno = ?";
                psmt = conn.prepareStatement(sql);
                psmt.setInt(1, cno);
                rs = psmt.executeQuery();
                
                if (rs.next()) {
                    String validCode = rs.getString("random_number");
                    System.out.println("Database random_number: " + validCode);
                    
                    if (enteredCode.equals(validCode)) {
                        LocalTime currentTime = LocalTime.now();
                        LocalTime cutoffTime = LocalTime.of(9, 10);// 09:10

                        String attendanceStatus = currentTime.isBefore(cutoffTime) ? "출석" : "지각";
                        
                        String insertSql = "INSERT INTO attendance(attendance, uno, cno, rdate) VALUES (?, ?, ?, ?)";
                        PreparedStatement insertPsmt = conn.prepareStatement(insertSql);
                        insertPsmt.setString(1, attendanceStatus);
                        insertPsmt.setInt(2, uno);
                        insertPsmt.setInt(3, cno);
                        insertPsmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                        insertPsmt.executeUpdate();
                        insertPsmt.close();

                        String formattedTime = currentTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
                        String jsonResponse = String.format(
                            "{\"status\": \"success\", \"message\": \"%s 처리되었습니다.\", \"attendanceStatus\": \"%s\", \"time\": \"%s\"}",
                            attendanceStatus, attendanceStatus, formattedTime
                        );
                        response.getWriter().write(jsonResponse);
                    } else {
                        response.getWriter().write("{\"status\": \"fail\", \"message\": \"인증 코드가 올바르지 않습니다.\"}");
                    }
                } else {
                    response.getWriter().write("{\"status\": \"fail\", \"message\": \"해당하는 수업을 찾을 수 없습니다.\"}");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().write("{\"status\": \"error\", \"message\": \"데이터베이스 오류가 발생했습니다.\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("{\"status\": \"error\", \"message\": \"서버 오류가 발생했습니다.\"}");
            } finally {
                try {
                    DBConn.close(rs, psmt, conn);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.getWriter().write("{\"status\": \"fail\", \"message\": \"세션 정보가 없습니다.\"}");
        }
    }
}