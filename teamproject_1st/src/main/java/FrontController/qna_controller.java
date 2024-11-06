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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import FrontController.util.DBConn;
import FrontController.util.PagingUtil;
import FrontController.vo.qnaVO;

public class qna_controller {

	public qna_controller(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException {

		if(comments[comments.length-1].equals("qna_write.do")) {
			if(request.getMethod().equals("GET")){
				qna_write(request,response);	
			}else if(request.getMethod().equals("POST")){
				qna_writeok(request,response);	
			}
		}else if(comments[comments.length-1].equals("qna_list.do")) {
			if(request.getMethod().equals("GET")){
				qna_list(request,response);	
			}
		}else if(comments[comments.length-1].equals("qna_view.do")) {
			if(request.getMethod().equals("GET")){
				qna_view(request,response);	
			}
		}else if(comments[comments.length-1].equals("qna_modify.do")) {
			if(request.getMethod().equals("GET")){
				qna_modify(request,response);	
			}else if(request.getMethod().equals("POST")) {
				//수정페이지에서 데이터 수정 후 서브밋 했을 때
				qna_modifyOk(request,response);
			}
		}else if(comments[comments.length-1].equals("qna_delete.do")) {
			if(request.getMethod().equals("POST")) {
				qna_delete(request,response);
			}
			
		}
	}
	
	
	private void qna_write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/qna_board/qna_write.jsp").forward(request, response);
	}
	
	private void qna_writeok(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		// 파일 업로드 설정
	    int size = 10 * 1024 * 1024;  // 최대 파일 크기 10MB
	    String uploadPath = request.getSession().getServletContext().getRealPath("/upload");  // 서버 상의 파일 저장 경로
	    MultipartRequest multi = null;
	    
	    try {
	        // MultipartRequest를 사용해 파일 업로드 및 폼 데이터를 처리
	        multi = new MultipartRequest(
	                request,
	                uploadPath,
	                size,
	                "UTF-8",
	                new DefaultFileRenamePolicy()
	        );
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("/error.jsp");  // 오류 페이지로 리다이렉트
	        return;
	    }
	    
		int qno = Integer.parseInt(multi.getParameter("qno"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
	        // 1. qna 테이블 업데이트 (title, content 수정)
	        String sql = "UPDATE qna_board SET title = ?, content = ? WHERE qno = ?";
	        
	        psmt = conn.prepareStatement(sql);
	        
	        psmt.setString(1, title);
	        psmt.setString(2, content);
	        psmt.setInt(3, qno);
	        
	        psmt.executeUpdate();
	        
	        // 쿼리 실행
	        int result = psmt.executeUpdate();
	        
	        // 성공 시 리다이렉트
	        if (result > 0) {
	            response.sendRedirect("qna_view.do?qno="+qno);
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
	
	private void qna_list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int nowpage = 1; // 기본 페이지는 1
		
	    if (request.getParameter("nowpage") != null) {
	    	nowpage = Integer.parseInt(request.getParameter("nowpage"));
	    }
	    
	    int recordsPerPage = 10; // 페이지당 표시할 게시글 수
	    int totalRecords = 0; // 전체 게시글 수
	    int totalPages = 0; // 총 페이지 수
	    
	    HttpSession session = request.getSession();
	    
	    // 검색 조건 추가
	    String searchType = request.getParameter("searchType"); // 검색 필드 (예: title, id 등)
	    String searchValue = request.getParameter("searchValue"); // 검색어
	    
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
	        // 전체 게시글 수를 가져오는 쿼리 (검색 조건이 있을 경우 이를 반영)
			String pagesql = "SELECT COUNT(*) AS total_count FROM qna_board q INNER JOIN user u ON q.uno = u.uno AND q.state='E'";
			
	        // 검색 조건이 있을 경우 WHERE 절 추가
	        if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
	            pagesql += " WHERE " + searchType + " LIKE ?";
	        }
	        
	        psmt = conn.prepareStatement(pagesql);
	        
	        // 검색 조건이 있을 때 검색어 바인딩
	        if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
	            psmt.setString(1, "%" + searchValue + "%");
	        }
	        
	        rs = psmt.executeQuery();
	        
	        if (rs.next()) {
	            totalRecords = rs.getInt("total_count"); // 전체 게시글 수
	        }
	        
	        // 이전 rs와 psmt를 닫고 새 쿼리 실행을 위해 초기화
	        rs.close();
	        psmt.close();
	        
	        PagingUtil paging = new PagingUtil(nowpage,totalRecords,recordsPerPage);
	        
	        String boardsql = "SELECT q.qno, q.title, DATE_FORMAT(q.rdate, '%Y-%m-%d') AS rdate, q.hit " +
	                  "FROM qna_board q INNER JOIN user u ON q.uno = u.uno " +
	                  "WHERE q.state = 'E'";
	        
	        // 검색 조건이 있을 경우 WHERE 조건 추가
	        if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
	            boardsql += "WHERE " + searchType + " LIKE ?";
	        }
	        
	        boardsql += "ORDER BY q.qno DESC LIMIT ?, ?"; // 최신 게시글 순으로 정렬 및 LIMIT 사용
	        
	        psmt = conn.prepareStatement(boardsql);
	        
	        int paramIndex = 1; // PreparedStatement 파라미터 인덱스
	        if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
	            psmt.setString(paramIndex++, "%" + searchValue + "%"); // 검색어 바인딩
	        }
	        
	        // LIMIT 절에 사용할 시작 인덱스와 표시할 게시글 수 설정
	        psmt.setInt(paramIndex++,paging.getStart()); // 시작 인덱스
	        psmt.setInt(paramIndex, recordsPerPage); // 표시할 게시글 수
	        
			rs = psmt.executeQuery();
			
			// 리스트 생성
			List<qnaVO> list = new ArrayList<qnaVO>(); 
			
			while(rs.next()){
				// vo생성
				qnaVO vo = new qnaVO();
				// vo에 값 넣기
				vo.setQno(rs.getInt("qno"));
				vo.setTitle(rs.getString("title"));
				vo.setRdate(rs.getString("rdate"));
				vo.setHit(rs.getInt("hit"));
				// 리스트에 vo 넣기
				list.add(vo);
			}	
			
			// 모델에 리스트 저장
			request.setAttribute("list", list);
	        request.setAttribute("paging", paging); // 전체 페이지 수
	        request.setAttribute("searchType", searchType); // 검색 필드
	        request.setAttribute("searchValue", searchValue); // 검색어
	        
			request.getRequestDispatcher("/WEB-INF/qna/qna_list.jsp").forward(request, response);
	        
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
		
	private void qna_view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	private void qna_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	private void qna_modifyOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	private void qna_delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	












	
	
}
