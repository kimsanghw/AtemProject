package FrontController;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import FrontController.util.DBConn;
import FrontController.vo.UserVO;

public class UserController {
	public UserController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
		
		if(comments[comments.length-1].equals("login.do")) {
			if(request.getMethod().equals("GET")) {
			login(request,response);
			}else if( request.getMethod().equals("POST")) {
				loginOk(request,response);

			}
		}else if(comments[comments.length-1].equals("join.do")) {
		    if(request.getMethod().equals("GET")) {
		    	join(request, response);
		    	System.out.println("데이터 전송중");
		       }
		    } else if(request.getMethod().equals("POST")) {
		        joinOk(request, response);
		    }
		}
	
	
	public void login(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
	}
	
	public void loginOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		String password = request.getParameter("pw");
		
		
		Connection conn= null;
		PreparedStatement psmt = null;
		ResultSet rs =  null;
		
		try {
			conn = DBConn.conn();
			
			String sql = " SELECT * FROM user WHERE id=? AND password=? ";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, password);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				
				UserVO loginUser = new UserVO();
				loginUser.setUno(rs.getInt("uno"));
				loginUser.setName(rs.getString("name"));
				loginUser.setAuthorization(rs.getString("authorization"));
				loginUser.setId(id);
				
				
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", loginUser);
				

				response.sendRedirect(request.getContextPath()+ "/index.jsp");
				
			}else {
				 request.getRequestDispatcher("/user/login.jsp").forward(request, response);
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
	}	
	
	
	public void join(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(request, response);
	}
	
	public void joinOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			
			conn = DBConn.conn();
			
			String sql = "insert into user (id, password, name, email, phone) VALUES (?, ?, ?, ?, ?)";
					   
			System.out.println("joinOk() :: SQL : " + sql);
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1,id);
		    psmt.setString(2,password);
		    psmt.setString(3,name);
		    psmt.setString(4,email);
		    psmt.setString(5,phone);
    
		    int result = psmt.executeUpdate();

		    if (result < 1 ) {

		    }else {

		    	

		    response.sendRedirect(request.getContextPath() + "/index.jsp");}
		}catch(Exception e){
			e.printStackTrace();

		}finally {
			try {
				DBConn.close( psmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void checkEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");	

		String email = request.getParameter("email");
		
		Connection conn = null; 
		PreparedStatement psmt = null; 
		ResultSet rs = null;	
		
		try{
			
			conn = DBConn.conn();
			
			String sql = "SELECT COUNT(*) AS cnt FROM user WHERE email=?";
			
			psmt = conn.prepareStatement(sql); 
			psmt.setString(1,email); 
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				int result = rs.getInt("cnt");
				if(result > 0){
					System.out.print("isid"); 
				} else {
					System.out.print("isNotId");
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.print("error"); 
		}finally{
			try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//세션 초기화
		HttpSession session = request.getSession();
		UserVO userId = (UserVO) session.getAttribute("loginUser");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"index.jsp");//메인페이지로이동
		//response.sendRedirect(request.getContextPath());//메인페이지로이동
	}
	public void checkId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    String id = request.getParameter("id");
	    
	    Connection conn = null; 
	    PreparedStatement psmt = null; 
	    ResultSet rs = null;    
	    
	    try {
	        conn = DBConn.conn();
	        
	        String sql = "SELECT COUNT(*) AS cnt FROM user WHERE id=?";
	        
	        psmt = conn.prepareStatement(sql); 
	        psmt.setString(1, id); 
	        
	        rs = psmt.executeQuery();
	        
	        if(rs.next()) {
	            int result = rs.getInt("cnt");
	            if(result > 0) {
	                out.print("isid"); 
	            } else {
	                out.print("isNotId");
	            }
	        } else {
	        	out.print(rs); 
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        out.print("error"); 
	    } finally {
	        try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

}	


