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
import FrontController.util.PagingUtil;
import FrontController.vo.NoticeVO;
import FrontController.vo.UserVO;

public class notice_controller {

	public notice_controller(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException {
		
		if(comments[comments.length-1].equals("notice_write.do")) {
			if(request.getMethod().equals("GET")){
				notice_write(request,response);	
			}else if(request.getMethod().equals("POST")){
				notice_writeok(request,response);	
			}
		}else if(comments[comments.length-1].equals("notice_list.do")) {
			if(request.getMethod().equals("GET")){
				notice_list(request,response);	
			}
		}else if(comments[comments.length-1].equals("notice_view.do")) {
			if(request.getMethod().equals("GET")){
				notice_view(request,response);	
			}
		}else if(comments[comments.length-1].equals("notice_modify.do")) {
			if(request.getMethod().equals("GET")){
				notice_modify(request,response);	
			}else if(request.getMethod().equals("POST")) {
				//수정페이지에서 데이터 수정 후 서브밋 했을 때
				notice_modifyOk(request,response);
			}
		}else if(comments[comments.length-1].equals("notice_delete.do")) {
			if(request.getMethod().equals("POST")) {
				notice_delete(request,response);
			}
			
		}
	}

	
	private void notice_write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/notice_board/notice_write.jsp").forward(request, response);
	}
	private void notice_writeok(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 요청 데이터의 인코딩 설정
	    request.setCharacterEncoding("UTF-8");
	    
	    // 세션에서 로그인된 사용자 정보 가져오기
	    HttpSession session = request.getSession();
	    UserVO loginVO = (UserVO) session.getAttribute("loginUser");
	    
	    String title = request.getParameter("title");

	    String content = request.getParameter("content");
	    
	    Connection conn = null;  // DB 연결
	    PreparedStatement psmt = null;
	    
	    try {
	    	 // DB 연결
	        conn = DBConn.conn();
	        
	        // 1. notice 테이블에 데이터 삽입 (게시글 정보)
	        String sql = "INSERT INTO notice_board(title, content, uno) VALUES(?, ?, ?)";
	        psmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
	        psmt.setString(1, title);
	        psmt.setString(2, content);
	        psmt.setInt(3, loginVO.getUno());
	        
	        int result = psmt.executeUpdate();  // SQL 실행 (데이터 삽입)
	        
	        if(result > 0) {
	        	response.sendRedirect("notice_list.do");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            DBConn.close(psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}
	private void notice_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int nowpage = 1; // 기본 페이지는 1
		
	    if (request.getParameter("nowpage") != null) {
	    	nowpage = Integer.parseInt(request.getParameter("nowpage"));
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

	        // 전체 게시글 수를 가져오는 쿼리 (검색 조건이 있을 경우 이를 반영)
			String pagesql = "SELECT COUNT(*) AS total_count FROM notice_board n INNER JOIN user u ON n.uno = u.uno AND n.state = 'E'";

	        psmt = conn.prepareStatement(pagesql);
	        
	        rs = psmt.executeQuery();
	        
	        if (rs.next()) {
	            totalRecords = rs.getInt("total_count"); // 전체 게시글 수
	        }
			
	        PagingUtil paging = new PagingUtil(nowpage,totalRecords,recordsPerPage);
	        
	        // 이전 rs와 psmt를 닫고 새 쿼리 실행을 위해 초기화
	        rs.close();
	        psmt.close();
	        
	        String boardsql = "SELECT n.nno, n.title,n.state, DATE_FORMAT(n.rdate, '%Y-%m-%d') AS rdate, n.hit " +
	                  "FROM notice_board n INNER JOIN user u ON n.uno = u.uno " +
	                  "WHERE n.state = 'E'";
	        
	        boardsql += "ORDER BY n.nno DESC LIMIT ?, ?"; // 최신 게시글 순으로 정렬 및 LIMIT 사용
	        
	        psmt = conn.prepareStatement(boardsql);
	        
	        int paramIndex = 1; // PreparedStatement 파라미터 인덱스
	        
	        // LIMIT 절에 사용할 시작 인덱스와 표시할 게시글 수 설정
	        psmt.setInt(paramIndex++,paging.getStart()); // 시작 인덱스
	        psmt.setInt(paramIndex, recordsPerPage); // 표시할 게시글 수
	        
			rs = psmt.executeQuery();
			
			// 리스트 생성
			List<NoticeVO> list = new ArrayList<NoticeVO>(); 
						
			while(rs.next()){
				// vo생성
				NoticeVO vo = new NoticeVO();
				// vo에 값 넣기
				vo.setNno(rs.getInt("nno"));
				vo.setTitle(rs.getString("title"));
				vo.setRdate(rs.getString("rdate"));
				vo.setHit(rs.getInt("hit"));
				vo.setState(rs.getString("state"));
				
				// 리스트에 vo 넣기
				list.add(vo);
			}	
			
			// 모델에 리스트 저장
				request.setAttribute("list", list);
				request.setAttribute("paging", paging); // 전체 페이지 수
				
			// 뷰페이지로 이동
				request.getRequestDispatcher("/WEB-INF/notice_board/notice_list.jsp").forward(request, response);
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
	private void notice_view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int nno = 0;
		
		 if(request.getParameter("Nno") != null) { 
			  nno = Integer.parseInt(request.getParameter("Nno"));
		  }
		 
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			try {
				conn = DBConn.conn();
				
				// 조회수 증가 쿼리 
				String sql = "UPDATE notice_board SET hit = hit + 1 WHERE nno = ?";
				
				psmt = conn.prepareStatement(sql);
				
				psmt.setInt(1, nno);
				
			 	// 조회수 업데이트 실행
				psmt.executeUpdate();
				
				// 게시글 정보 가져오기 쿼리
				sql = "SELECT n.*, u.name FROM notice_board n INNER JOIN user u ON n.uno = u.uno WHERE n.nno = ?"; 
				
				// 리스트 생성
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, nno);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					// vo생성
					NoticeVO vo = new NoticeVO();
					// vo에 값 넣기
					vo.setNno(rs.getInt("nno"));
					vo.setName(rs.getString("name"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setRdate(rs.getString("rdate"));
					vo.setHit(rs.getInt("hit"));
					vo.setState(rs.getString("state"));
					vo.setTopYn(rs.getString("topYn"));
					vo.setUno(rs.getInt("uno"));
					
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
		
		request.getRequestDispatcher("/WEB-INF/notice_board/notice_view.jsp").forward(request, response);
	}
	private void notice_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			String sql = "SELECT n.nno, n.title, n.content, u.id FROM notice_board n INNER JOIN user u ON n.uno = u.uno WHERE n.nno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, nno);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				NoticeVO vo = new NoticeVO();
				vo.setNno(rs.getInt("nno"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setId(rs.getString("id"));
				
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
		
		request.getRequestDispatcher("/WEB-INF/notice_board/notice_modify.jsp").forward(request, response);
		
	}
	private void notice_modifyOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
	        // 1. library 테이블 업데이트 (title, content 수정)
	        String sql = "UPDATE notice_board SET title = ?, content = ? WHERE nno = ?";
	        
	        psmt = conn.prepareStatement(sql);
	        
	        psmt.setString(1, title);
	        psmt.setString(2, content);
	        psmt.setInt(3, nno);
	        
	        psmt.executeUpdate();
	        
	     // 쿼리 실행
	        int result = psmt.executeUpdate();

	        // 성공 시 리다이렉트
	        if (result > 0) {
	            response.sendRedirect("notice_view.do?Nno="+nno);
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
	private void notice_delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = "UPDATE notice_board SET state = 'D' WHERE nno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, nno);
			
			int result = psmt.executeUpdate();
			
			if(result > 0) {
				response.sendRedirect(request.getContextPath()+"/notice/notice_list.do");
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
