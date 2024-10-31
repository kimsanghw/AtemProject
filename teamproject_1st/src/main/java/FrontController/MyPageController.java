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
		if(comments[comments.length-1].equals("mypage3search.do")) {
			if(request.getMethod().equals("GET")) {
				mypage3search(request,response);
			}
		}
	}
		public void mypage(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			HttpSession session = request.getSession();
			
			UserVO loginUser = (UserVO)session.getAttribute("loginUser");
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			try {
				conn = DBConn.conn();
				
				String sql = "SELECT * FROM user WHERE uno = ?";
				
				psmt = conn.prepareStatement(sql);
				
				psmt.setInt(1, loginUser.getUno());
				
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					System.out.println("DB email: " + rs.getString("email"));
				    System.out.println("DB phone: " + rs.getString("phone"));
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
					 request.getRequestDispatcher("/WEB-INF/mypage/mypage.jsp").forward(request, response);
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
			request.getRequestDispatcher("/WEB-INF/mypage/mypage2.jsp").forward(request, response);
		}
		
		
		
		public void mypage3(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			int page = 1; // 기본 페이지는 1
		    if (request.getParameter("page") != null) {
		        page = Integer.parseInt(request.getParameter("page"));
		    }

		    int recordsPerPage = 10; // 페이지당 표시할 유저 수
		    HttpSession session = request.getSession();

		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;

		    try {
		        conn = DBConn.conn();

		        // 권한이 A가 아닌 유저 조회 쿼리
		        String sql = "SELECT * FROM user WHERE authorization != 'A' LIMIT ? OFFSET ?";
		        psmt = conn.prepareStatement(sql);
		        
		        psmt.setInt(1, recordsPerPage);
		        psmt.setInt(2, (page - 1) * recordsPerPage);

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
		        
		        // 총 유저 수 계산
		        String countSql = "SELECT COUNT(*) FROM user WHERE authorization != 'A'";
		        psmt = conn.prepareStatement(countSql);
		        rs = psmt.executeQuery();
		        int totalUsers = 0;
		        if (rs.next()) {
		            totalUsers = rs.getInt(1);
		        }

		        int totalPages = (int) Math.ceil(totalUsers * 1.0 / recordsPerPage);

		        request.setAttribute("userList", userList);
		        request.setAttribute("totalPages", totalPages);
		        request.setAttribute("currentPage", page);

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
		public void mypage3search(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			String searchOption = request.getParameter("search_option"); // Selected search option
		    String searchTerm = request.getParameter("mypage_search"); // Search term
		    int page = 1; // Default to page 1
		    if (request.getParameter("page") != null) {
		        page = Integer.parseInt(request.getParameter("page"));
		    }

		    int recordsPerPage = 10; // Number of records to display per page
		    Connection conn = null;
		    PreparedStatement psmt = null;
		    ResultSet rs = null;

		    try {
		        conn = DBConn.conn();

		        // Prepare SQL query based on search option
		        String sql = "SELECT * FROM user WHERE " + searchOption + " LIKE ? AND authorization != 'A' LIMIT ? OFFSET ?";
		        psmt = conn.prepareStatement(sql);
		        psmt.setString(1, "%" + searchTerm + "%"); // Search term with wildcards for partial matching
		        psmt.setInt(2, recordsPerPage);
		        psmt.setInt(3, (page - 1) * recordsPerPage);

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

		        // Count total users based on the search criteria
		        String countSql = "SELECT COUNT(*) FROM user WHERE " + searchOption + " LIKE ? AND authorization != 'A'";
		        psmt = conn.prepareStatement(countSql);
		        psmt.setString(1, "%" + searchTerm + "%");
		        rs = psmt.executeQuery();
		        int totalUsers = 0;
		        if (rs.next()) {
		            totalUsers = rs.getInt(1);
		        }

		        int totalPages = (int) Math.ceil(totalUsers * 1.0 / recordsPerPage);

		        // Set attributes for the JSP
		        request.setAttribute("userList", userList);
		        request.setAttribute("totalPages", totalPages);
		        request.setAttribute("currentPage", page);

		        // Forward to the same JSP page to display results
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
}