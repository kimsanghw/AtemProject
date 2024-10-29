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
			mypage(request,response);
			}else if(request.getMethod().equals("POST")){
			mypageOK(request,response);
			}
		}
	}
		public void mypage(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			request.getRequestDispatcher("/WEB-INF/mypage/mypage.jsp").forward(request, response);
		}
		public void mypageOK(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
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
					user.setDate(rs.getString("date"));
					
					System.out.println(user);
					
					 request.setAttribute("loginUser", loginUser);
					 request.getRequestDispatcher("/mypage/mypage.do").forward(request, response);
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
}