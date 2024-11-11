package FrontController;

import java.io.IOException;
import java.util.Arrays;
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
import FrontController.vo.ClassVO;
import FrontController.vo.UserVO;

public class MyPageController {
	public MyPageController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
		if(comments[comments.length-1].equals("mypage.do")) {
			if(request.getMethod().equals("GET")) {
				// 내 정보 조회
			mypage(request,response);
			}else if(request.getMethod().equals("POST")){
				// 내 정보 수정
			mypageOK(request,response);
			}
		}
		if(comments[comments.length-1].equals("mypage2.do")) {
			if(request.getMethod().equals("GET")) {
				mypage2(request,response);
		}
	}
		if(comments[comments.length-1].equals("mypage3.do")) {
			if(request.getMethod().equals("GET")) {
			mypage3(request,response);
			}else if(request.getMethod().equals("POST")){
				mypage3OK(request,response);
			}
		}
	}
	public void mypage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	    int uno = loginUser.getUno();

	    Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    ClassVO enrolledClass = null; // 수강 중인 단일 강의를 저장할 객체

	    try {
	        conn = DBConn.conn();

	        // 수강 중인 강의 가져오기
	        String sqlClass = "SELECT c.cno, u.uno, c.title, c.subject, c.state, c.difficult, c.book, "
	                        + "c.duringclass, c.end_duringclass, c.newFileName, c.name "
	                        + "FROM class c "
	                        + "JOIN app_class ac ON ac.cno = c.cno "
	                        + "JOIN USER u ON c.uno = u.uno "
	                        + "WHERE ac.uno = ? AND c.state = 'E' AND ac.state = 'E' AND c.end_duringclass > NOW()";

	        psmt = conn.prepareStatement(sqlClass);
	        psmt.setInt(1, uno);
	        rs = psmt.executeQuery();

	        if (rs.next()) {
	            enrolledClass = new ClassVO();
	            enrolledClass.setCno(rs.getInt("cno"));
	            enrolledClass.setUno(rs.getInt("uno"));
	            enrolledClass.setTitle(rs.getString("title"));
	            enrolledClass.setState(rs.getString("state"));
	            enrolledClass.setSubject(rs.getString("subject"));
	            enrolledClass.setDuringclass(rs.getString("duringclass"));
	            enrolledClass.setEnd_duringclass(rs.getString("end_duringclass"));
	            enrolledClass.setDifficult(rs.getString("difficult"));
	            enrolledClass.setBook(rs.getString("book"));
	            enrolledClass.setNewFileName(rs.getString("newFileName"));
	            enrolledClass.setName(rs.getString("name"));
	        }

	        // 사용자 정보 가져오기
	        String sqlUser = "SELECT * FROM user WHERE uno = ?";
	        psmt = conn.prepareStatement(sqlUser);
	        psmt.setInt(1, uno);
	        rs = psmt.executeQuery();

	        if (rs.next()) {
	            UserVO user = new UserVO();
	            user.setUno(rs.getInt("uno"));
	            user.setId(rs.getString("id"));
	            user.setPassword(rs.getString("password"));
	            user.setName(rs.getString("name"));
	            user.setPhone(rs.getString("phone"));
	            user.setEmail(rs.getString("email"));
	            user.setRdate(rs.getString("rdate"));
	            user.setState(rs.getString("state"));
	            user.setAuthorization(rs.getString("authorization"));

	            session.setAttribute("user", user);
	        }

	        // JSP로 데이터 전달
	        request.setAttribute("enrolledClass", enrolledClass);
	        request.getRequestDispatcher("/WEB-INF/mypage/mypage.jsp").forward(request, response);

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

		public void mypageOK(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		    HttpSession session = request.getSession();
		    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		    String action = request.getParameter("action");
		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;

		    try {
		        conn = DBConn.conn();

		        if ("modifyEmail".equals(action)) { // Email modification
		            String email = request.getParameter("email_modify");
		            String sql = "UPDATE user SET email = ? WHERE uno = ?";
		            psmt = conn.prepareStatement(sql);
		            psmt.setString(1, email);
		            psmt.setInt(2, loginUser.getUno());
		            int rowsAffected = psmt.executeUpdate();

		            if (rowsAffected > 0) {
		                // 수정 성공 후 마이페이지로 리다이렉트
		                response.sendRedirect(request.getContextPath() + "/mypage/mypage.do");
		                return; // 이 메소드를 종료합니다.
		            } else {
		                response.getWriter().write("이메일 수정 실패");
		            }
		        } else if ("modifyPhone".equals(action)) { // Phone number modification
		            String phone = request.getParameter("number_modify");
		            String sql = "UPDATE user SET phone = ? WHERE uno = ?";
		            psmt = conn.prepareStatement(sql);
		            psmt.setString(1, phone);
		            psmt.setInt(2, loginUser.getUno());
		            int rowsAffected = psmt.executeUpdate();

		            if (rowsAffected > 0) {
		                // 수정 성공 후 마이페이지로 리다이렉트
		                response.sendRedirect(request.getContextPath() + "/mypage/mypage.do");
		                return; // 이 메소드를 종료합니다.
		            } else {
		                response.getWriter().write("전화번호 수정 실패");
		            }
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.getWriter().write("서버 오류: " + e.getMessage());
		    } finally {
		        try {
		            DBConn.close(psmt, conn);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
			
			// 파라메타로 넘어온 수정 정보를 받아서 유효성 확인

			
			try {
				conn = DBConn.conn();
				
				// DB 업데이트 구문 작성
				
				String sql = "SELECT * FROM user WHERE uno = ?";
				
				psmt = conn.prepareStatement(sql);
				
				psmt.setInt(1, loginUser.getUno());
				
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					UserVO user = new UserVO();
					user.setUno(rs.getInt("uno"));
					user.setId(rs.getString("id"));
					user.setPassword(rs.getString("password"));
					user.setName(rs.getString("name"));
					user.setPhone(rs.getString("phone"));
					user.setEmail(rs.getString("email"));
					user.setRdate(rs.getString("rdate"));
					user.setState(rs.getString("state"));
					user.setAuthorization(rs.getString("authorization"));
					
					session.setAttribute("user", user);
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				try {
					DBConn.close(rs, psmt, conn);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		public void mypage2(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			
			HttpSession session = request.getSession();
		    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		    int uno = loginUser.getUno();

		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;
		    PreparedStatement psmtend = null;
		    ResultSet rsend = null;
		    ClassVO enrolledClass = null; // 수강 중인 단일 강의를 저장할 객체
		    ClassVO endClass = null;
		    
		   
		    try {
		        conn = DBConn.conn();
		        
		        String sql ="SELECT c.* FROM class c JOIN app_class ac ON c.cno = ac.cno WHERE ac.uno = ? AND c.end_duringclass < NOW() ORDER BY c.end_duringclass DESC; ";
				psmt = conn.prepareStatement(sql);
		        psmt.setInt(1, uno);
		        
		        rs = psmt.executeQuery();
		        
		        // 수강 중인 강의 가져오기
		        String sqlClass = "SELECT c.cno, u.uno, c.title, c.subject, c.state, c.difficult, c.book, "
		                        + "c.duringclass, c.end_duringclass, c.newFileName, c.name "
		                        + "FROM class c "
		                        + "JOIN app_class ac ON ac.cno = c.cno "
		                        + "JOIN USER u ON c.uno = u.uno "
		                        + "WHERE ac.uno = ? AND c.state = 'E' AND ac.state = 'E' AND c.end_duringclass > NOW()";

		        psmt = conn.prepareStatement(sqlClass);
		        psmt.setInt(1, uno);
		        rs = psmt.executeQuery();

		        if (rs.next()) {
		            enrolledClass = new ClassVO();
		            enrolledClass.setCno(rs.getInt("cno"));
		            enrolledClass.setUno(rs.getInt("uno"));
		            enrolledClass.setTitle(rs.getString("title"));
		            enrolledClass.setState(rs.getString("state"));
		            enrolledClass.setSubject(rs.getString("subject"));
		            enrolledClass.setDuringclass(rs.getString("duringclass"));
		            enrolledClass.setEnd_duringclass(rs.getString("end_duringclass"));
		            enrolledClass.setDifficult(rs.getString("difficult"));
		            enrolledClass.setBook(rs.getString("book"));
		            enrolledClass.setNewFileName(rs.getString("newFileName"));
		            enrolledClass.setName(rs.getString("name"));
		        }
		        String sqlEnd = "SELECT c.cno, u.uno, c.title, c.subject, c.state, c.difficult, c.book, "
                        + "c.duringclass, c.end_duringclass, c.newFileName, c.name "
                        + "FROM class c "
                        + "JOIN app_class ac ON ac.cno = c.cno "
                        + "JOIN USER u ON c.uno = u.uno "
                        + "WHERE ac.uno = ? AND c.state = 'E' AND ac.state = 'E' AND c.end_duringclass < NOW()";
		        
		        psmtend = conn.prepareStatement(sqlEnd);
		        psmtend.setInt(1, uno);
		        rsend = psmtend.executeQuery();

		        if (rsend.next()) {
		            endClass = new ClassVO();
		            endClass.setCno(rsend.getInt("cno"));
		            endClass.setUno(rsend.getInt("uno"));
		            endClass.setTitle(rsend.getString("title"));
		            endClass.setState(rsend.getString("state"));
		            endClass.setSubject(rsend.getString("subject"));
		            endClass.setDuringclass(rsend.getString("duringclass"));
		            endClass.setEnd_duringclass(rsend.getString("end_duringclass"));
		            endClass.setDifficult(rsend.getString("difficult"));
		            endClass.setBook(rsend.getString("book"));
		            endClass.setNewFileName(rsend.getString("newFileName"));
		            endClass.setName(rsend.getString("name"));
		        }

	        // JSP로 데이터 전달
		    request.setAttribute("endClass", endClass);
	        request.setAttribute("enrolledClass", enrolledClass);
	        request.getRequestDispatcher("/WEB-INF/mypage/mypage2.jsp").forward(request, response);
		}catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
		}
		
		
		
		public void mypage3(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    int page = 1; // 기본 페이지 1로 설정
		    if (request.getParameter("page") != null) {
		        try {
		            page = Integer.parseInt(request.getParameter("page"));
		        } catch (NumberFormatException e) {
		            page = 1; // 페이지 값이 잘못된 경우 기본 페이지로 설정
		        }
		    }

		    int recordsPerPage = 10; // 한 페이지에 표시할 레코드 수
		    HttpSession session = request.getSession();

		    // 검색 파라미터 가져오기
		    String searchOption = request.getParameter("search_option"); // 검색 옵션 (id, name, email, phone 등)
		    String searchTerm = request.getParameter("mypage_search"); // 검색어

		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;

		    try {
		        conn = DBConn.conn();

		        // 검색 옵션 유효성 검사 (id, name, email, phone만 허용)
		        List<String> allowedColumns = Arrays.asList("id", "name", "email", "phone");
		        if (!allowedColumns.contains(searchOption)) {
		            searchOption = "id"; // 유효하지 않은 검색 옵션일 경우 기본값(id) 설정
		        }

		        // 기본 쿼리 작성 (검색이 없으면 단순 페이징 처리만 수행)
		        String sql = "SELECT * FROM user WHERE authorization != 'A'"; 

		        // 검색 조건이 있으면 해당 조건을 추가
		        if (searchOption != null && searchTerm != null && !searchTerm.trim().isEmpty()) {
		            sql += " AND " + searchOption + " LIKE CONCAT('%', ?, '%')";
		        }

		        sql += " LIMIT ? OFFSET ?"; // 페이징 처리 추가

		        psmt = conn.prepareStatement(sql);

		        // 검색어가 있으면 해당 검색어를 파라미터로 설정
		        if (searchOption != null && searchTerm != null && !searchTerm.trim().isEmpty()) {
		            psmt.setString(1, searchTerm); // 검색어
		            psmt.setInt(2, recordsPerPage); // 한 페이지에 표시할 레코드 수
		            psmt.setInt(3, (page - 1) * recordsPerPage); // OFFSET 값 (현재 페이지에 맞는 레코드 시작 위치)
		        } else {
		            psmt.setInt(1, recordsPerPage); // 한 페이지에 표시할 레코드 수
		            psmt.setInt(2, (page - 1) * recordsPerPage); // OFFSET 값
		        }

		        rs = psmt.executeQuery();

		        List<UserVO> userList = new ArrayList<>();
		        while (rs.next()) {
		            UserVO user = new UserVO();
		            user.setUno(rs.getInt("uno"));
		            user.setId(rs.getString("id"));
		            user.setPassword(rs.getString("password"));
		            user.setName(rs.getString("name"));
		            user.setPhone(rs.getString("phone"));
		            user.setEmail(rs.getString("email"));
		            user.setRdate(rs.getString("rdate"));
		            user.setState(rs.getString("state"));
		            user.setAuthorization(rs.getString("authorization"));

		            userList.add(user);
		        }

		        // 검색 조건에 맞는 전체 사용자 수 구하기 (검색어가 있을 경우만 적용)
		        String countSql = "SELECT COUNT(*) FROM user WHERE authorization != 'A'"; 
		        if (searchOption != null && searchTerm != null && !searchTerm.trim().isEmpty()) {
		            countSql += " AND " + searchOption + " LIKE ?";
		        }

		        psmt = conn.prepareStatement(countSql);
		        if (searchOption != null && searchTerm != null && !searchTerm.trim().isEmpty()) {
		            psmt.setString(1, "%" + searchTerm + "%"); // 검색어
		        }

		        rs = psmt.executeQuery();
		        int totalUsers = 0;
		        if (rs.next()) {
		            totalUsers = rs.getInt(1);
		        }

		        int totalPages = (int) Math.ceil(totalUsers * 1.0 / recordsPerPage); // 전체 페이지 수 계산
		        int startPage = Math.max(1, page - 4); // 시작 페이지 (현재 페이지 기준 앞쪽 4페이지까지 표시)
		        int endPage = Math.min(totalPages, page + 5); // 끝 페이지 (현재 페이지 기준 뒤쪽 5페이지까지 표시)

		        // JSP에 필요한 데이터 설정
		        request.setAttribute("userList", userList); // 사용자 리스트
		        request.setAttribute("totalPages", totalPages); // 전체 페이지 수
		        request.setAttribute("currentPage", page); // 현재 페이지
		        request.setAttribute("startPage", startPage); // 시작 페이지
		        request.setAttribute("endPage", endPage); // 끝 페이지
		        request.setAttribute("search_option", searchOption); // 검색 옵션
		        request.setAttribute("mypage_search", searchTerm); // 검색어

		        // 결과를 mypage3.jsp로 전달
		        request.getRequestDispatcher("/WEB-INF/mypage/mypage3.jsp").forward(request, response);
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




		public void mypage3OK(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			HttpSession session = request.getSession();
		    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		    String authority = request.getParameter("authority"); // 선택된 권한 값
		    String id = request.getParameter("id"); // 선택된 권한 값
		    Connection conn = null;
		    PreparedStatement psmt = null;

		    try {
		        conn = DBConn.conn();
		        String sql = "UPDATE user SET authorization = ? WHERE id = ?";
		        psmt = conn.prepareStatement(sql);
		        psmt.setString(1, authority); // 한 글자 권한 저장
		        psmt.setString(2, id);
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
		}
}