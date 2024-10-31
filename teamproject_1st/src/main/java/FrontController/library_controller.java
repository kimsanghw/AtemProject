package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import FrontController.util.DBConn;
import FrontController.vo.UserVO;
import FrontController.vo.libraryVO;





public class library_controller {

	public library_controller(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException {
		
		if(comments[comments.length-1].equals("library_list.do")) {
			if(request.getMethod().equals("GET")){
				library_list(request,response);	
			}
		}else if(comments[comments.length-1].equals("library_write.do")) {
			if(request.getMethod().equals("GET")){
				library_write(request,response);	
			}else if(request.getMethod().equals("POST")){
				library_writeok(request,response);	
			}
		}else if(comments[comments.length-1].equals("library_view.do")) {
			if(request.getMethod().equals("GET")){
				library_view(request,response);	
			}
		}else if(comments[comments.length-1].equals("library_modify.do")) {
			if(request.getMethod().equals("GET")){
				library_modify(request,response);	
			}else if(request.getMethod().equals("POST")) {
				//�닔�젙�럹�씠吏��뿉�꽌 �뜲�씠�꽣 �닔�젙 �썑 �꽌釉뚮컠 �뻽�쓣 �븣
				library_modifyOk(request,response);
			}
		}
	}

	private void library_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		
		/*
		 * int lno = 0;
		 * 
		 * if(request.getParameter("lno") != null) { lno =
		 * Integer.parseInt(request.getParameter("lno")); }
		 */

		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			/*
			 * // 議고쉶�닔 利앷� 荑쇰━ String sql = "UPDATE library SET hit = hit + 1 WHERE lno = ?";
			 * psmt = conn.prepareStatement(sql); psmt.setInt(1, lno); psmt.executeUpdate();
			 * // 議고쉶�닔 �뾽�뜲�씠�듃 �떎�뻾
			 */			
			
	        // 寃뚯떆湲� �젙蹂� 媛��졇�삤湲� 荑쇰━
			String sql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') as rdate, l.hit FROM library l INNER JOIN user u ON l.uno = u.uno;";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			
			// 由ъ뒪�듃 �깮�꽦
			List<libraryVO> list = new ArrayList<libraryVO>();
			
			while(rs.next()){
				// vo�깮�꽦
				libraryVO vo = new libraryVO();
				// vo�뿉 媛� �꽔湲�
				vo.setLno(rs.getInt("lno"));
				vo.setTitle(rs.getString("title"));
				vo.setRdate(rs.getString("rdate"));
				vo.setHit(rs.getInt("hit"));
				// 由ъ뒪�듃�뿉 vo �꽔湲�
				list.add(vo);
			}	
			
			// 紐⑤뜽�뿉 由ъ뒪�듃 ���옣
			request.setAttribute("list", list);
			// 酉고럹�씠吏�濡� �씠�룞
			request.getRequestDispatcher("/WEB-INF/library_board/library_list.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
		}
				
			
	}
	private void library_write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/library_board/library_write.jsp").forward(request, response);
		
	}
	private void library_view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		
		  int lno = 0;
		  
		  if(request.getParameter("lno") != null) { 
			  lno = Integer.parseInt(request.getParameter("lno"));
		  }
		  
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
		 
			try {
				conn = DBConn.conn();
				
				String sql = "SELECT l.*, u.id, f.orgFileName FROM library l INNER JOIN user u ON l.uno = u.uno left outer join file f on l.lno=f.lno WHERE l.lno = ?";
				// 由ъ뒪�듃 �깮�꽦
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, lno);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					System.out.println("議댁옱");
					// vo�깮�꽦
					libraryVO vo = new libraryVO();
					// vo�뿉 媛� �꽔湲�
					vo.setLno(rs.getInt("lno"));
					vo.setTitle(rs.getString("title"));
					vo.setId(rs.getString("id"));
					vo.setRdate(rs.getString("rdate"));
					vo.setHit(rs.getInt("hit"));
					vo.setState(rs.getString("state"));
					vo.setContent(rs.getString("content"));
					vo.setOrgFileName(rs.getString("orgFileName"));
					
					// 紐⑤뜽�뿉 由ъ뒪�듃 ���옣
					request.setAttribute("vo", vo);
				}
				
					
					
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					DBConn.close(rs, psmt, conn);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		
		request.getRequestDispatcher("/WEB-INF/library_board/library_view.jsp").forward(request, response);
		
	}
	private void library_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/library_board/library_modify.jsp").forward(request, response);
		
	}
	private void library_modifyOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	private void library_writeok(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		UserVO loginVO = (UserVO)session.getAttribute("loginUser");
				
		Connection conn = null;// DB �뿰寃�
		PreparedStatement psmt = null;// SQL �벑濡� �떎�뻾
		
		try {
			conn = DBConn.conn();
			
			String sql = "insert into library( title,content,uno) values(?,?,?)";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, title); 
			psmt.setString(2, content); 
			psmt.setInt(3, loginVO.getUno()); 
			
			int result = psmt.executeUpdate();  // SQL �떎�뻾 (�뜲�씠�꽣 �궫�엯)
			
			if(result > 0) {
				response.sendRedirect("library_list.do");
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBConn.close(psmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}



}
