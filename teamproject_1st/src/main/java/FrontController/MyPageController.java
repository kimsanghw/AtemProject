package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		}
}