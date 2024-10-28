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

public class UserController {
	public UserController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
		
		if(comments[comments.length-1].equals("login.do")) {
			if(request.getMethod().equals("GET")) {
			login(request,response);
			}else if( request.getMethod().equals("POST")) {
				loginOk(request,response);
				System.out.println("�옒 �꽆�뼱�삤�뒗以묒엯�땲�떎");
			}
		}else if(comments[comments.length-1].equals("join.do")) {
			if(request.getMethod().equals("GET")) {
				join(request,response);
				}else if( request.getMethod().equals("POST")) {
					joinOk(request,response);
				}
		}	
	}
	
	public void login(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
	}
	
	public void loginOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("�뜲�씠�꽣 �꽆�뼱�삤�뒗 以�");
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
				loginUser.setUname(rs.getString("name"));
				loginUser.setUauthorization(rs.getString("authorization"));
				loginUser.setUid(id);
				
				
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", loginUser);
				
				System.out.println("濡쒓렇�씤 �꽦怨�");
				response.sendRedirect(request.getContextPath()+ "/index.jsp");
				
			}else {
				 System.out.println("濡쒓렇�씤 �떎�뙣");
				 request.setAttribute("loginError", "�븘�씠�뵒 �삉�뒗 鍮꾨�踰덊샇媛� �삱諛붾Ⅴ吏� �븡�뒿�땲�떎.");
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
//		String rdate = request.getParameter("rdate");
		
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
		    System.out.println("媛��엯 寃곌낵 : " + result);
		    if (result < 1 ) {
		    	// 媛��엯 �븞�맖
		    	// join �럹�씠吏�濡� 蹂대깂
		    	System.out.println("媛��엯 �떎�뙣");
		    }else {
		    	// -> 濡쒓렇�씤 �럹�씠吏�濡� 蹂대깂
		    	System.out.println("媛��엯 �꽦怨�");
		    }
			
		    response.sendRedirect(request.getContextPath() + "/index.jsp");
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("sql �샊�� DB �삤瑜�");
		}finally {
			try {
				DBConn.close( psmt, conn);
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
					System.out.print("isemail"); 
				}else{
					System.out.print("isNotemail");
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.print("error"); 
		}finally{
			try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void checkId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");	

		String id = request.getParameter("id");
		
		Connection conn = null; 
		PreparedStatement psmt = null; 
		ResultSet rs = null;	
		
		try{
			
			conn = DBConn.conn();
			
			String sql = "SELECT COUNT(*) AS cnt FROM user WHERE id=?";
			
			psmt = conn.prepareStatement(sql); 
			psmt.setString(1,id); 
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				int result = rs.getInt("cnt");
				if(result > 0){
					System.out.print("isid"); 
				}else{
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
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}

