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
		
		int page = 1; // 기본 페이지는 1
	    if (request.getParameter("page") != null) {
	        page = Integer.parseInt(request.getParameter("page"));
	    }
	    
	    int recordsPerPage = 10; // 페이지당 표시할 게시글 수
	    int totalRecords = 0; // 전체 게시글 수
	    int totalPages = 0; // 총 페이지 수
	    
	    HttpSession session = request.getSession();
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBConn.conn();
			
			String pagesql = "SELECT COUNT(*) AS total_count FROM library;";
			psmt = conn.prepareStatement(pagesql);
			rs = psmt.executeQuery();
			
	        if (rs.next()) {
	            totalRecords = rs.getInt("total_count"); // 전체 게시글 수
	        }
	        
	        // 총 페이지 수 계산
	        totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
			
	        // **이전 rs와 psmt를 닫고 새 쿼리 실행을 위해 초기화**
	        rs.close();
	        psmt.close();

	        String boardsql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') AS rdate, l.hit  FROM library l INNER JOIN user u ON l.uno = u.uno ORDER BY l.lno DESC LIMIT ?, ?";
	        
	        
	        // 게시글 정보 가져오기 쿼리
//			String boardsql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') as rdate, l.hit FROM library l INNER JOIN user u ON l.uno = u.uno;";
			psmt = conn.prepareStatement(boardsql);
	        // LIMIT 절에 사용할 시작 인덱스와 게시글 수 설정
	        psmt.setInt(1, (page - 1) * recordsPerPage); // 시작 인덱스
	        psmt.setInt(2, recordsPerPage); // 표시할 게시글 수
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
	        request.setAttribute("currentPage", page);   // 현재 페이지
	        request.setAttribute("totalPages", totalPages); // 전체 페이지 수
			// 뷰페이지로 이동
			request.getRequestDispatcher("/WEB-INF/library_board/library_list.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBConn.close(rs, psmt, conn);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
				
				
				  // 조회수 증가 쿼리 
				String sql = "UPDATE library SET hit = hit + 1 WHERE lno = ?";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, lno);
			 	// 조회수 업데이트 실행
				psmt.executeUpdate();
				
				// 게시글 정보 가져오기 쿼리
				sql = "SELECT l.*, u.id, f.orgFileName FROM library l INNER JOIN user u ON l.uno = u.uno left outer join file f on l.lno=f.lno WHERE l.lno = ?";
				// 리스트 생성
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, lno);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
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
