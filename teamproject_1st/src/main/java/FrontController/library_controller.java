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
				//수정페이지에서 데이터 수정 후 서브밋 했을 때
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
			 * // 조회수 증가 쿼리 String sql = "UPDATE library SET hit = hit + 1 WHERE lno = ?";
			 * psmt = conn.prepareStatement(sql); psmt.setInt(1, lno); psmt.executeUpdate();
			 * // 조회수 업데이트 실행
			 */			
			
	        // 게시글 정보 가져오기 쿼리
			String sql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') as rdate, l.hit FROM library l INNER JOIN user u ON l.uno = u.uno;";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			
			// 리스트 생성
			List<libraryVO> list = new ArrayList<libraryVO>();
			
			while(rs.next()){
				// vo생성
				libraryVO vo = new libraryVO();
				// vo에 값 넣기
				vo.setLno(rs.getInt("lno"));
				vo.setTitle(rs.getString("title"));
				vo.setRdate(rs.getString("rdate"));
				vo.setHit(rs.getInt("hit"));
				// 리스트에 vo 넣기
				list.add(vo);
			}	
			
			// 모델에 리스트 저장
			request.setAttribute("list", list);
			// 뷰페이지로 이동
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
				// 리스트 생성
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, lno);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					System.out.println("존재");
					// vo생성
					libraryVO vo = new libraryVO();
					// vo에 값 넣기
					vo.setLno(rs.getInt("lno"));
					vo.setTitle(rs.getString("title"));
					vo.setId(rs.getString("id"));
					vo.setRdate(rs.getString("rdate"));
					vo.setHit(rs.getInt("hit"));
					vo.setState(rs.getString("state"));
					vo.setContent(rs.getString("content"));
					vo.setOrgFileName(rs.getString("orgFileName"));
					
					// 모델에 리스트 저장
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
				
		Connection conn = null;// DB 연결
		PreparedStatement psmt = null;// SQL 등록 실행
		
		try {
			conn = DBConn.conn();
			
			String sql = "insert into library( title,content,uno) values(?,?,?)";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, title); 
			psmt.setString(2, content); 
			psmt.setInt(3, loginVO.getUno()); 
			
			int result = psmt.executeUpdate();  // SQL 실행 (데이터 삽입)
			
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
