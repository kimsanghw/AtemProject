package FrontController;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
		}else if(comments[comments.length-1].equals("library_delete.do")) {
			if(request.getMethod().equals("POST")) {
				library_delete(request,response);
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
	    
	    // 검색 조건 추가
	    String searchType = request.getParameter("searchType"); // 검색 필드 (예: title, id 등)
	    String searchValue = request.getParameter("searchValue"); // 검색어
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBConn.conn();
			
	        // 전체 게시글 수를 가져오는 쿼리 (검색 조건이 있을 경우 이를 반영)
			String pagesql = "SELECT COUNT(*) AS total_count FROM library l INNER JOIN user u ON l.uno = u.uno";
			
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
			
	        // 총 페이지 수 계산
	        totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

	        // 이전 rs와 psmt를 닫고 새 쿼리 실행을 위해 초기화
	        rs.close();
	        psmt.close();
	        
	        // 게시글 정보 가져오기 쿼리
//	        String boardsql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') AS rdate, l.hit  FROM library l INNER JOIN user u ON l.uno = u.uno ORDER BY l.lno DESC LIMIT ?, ?";
//			String boardsql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') as rdate, l.hit FROM library l INNER JOIN user u ON l.uno = u.uno;";
	        String boardsql = "SELECT l.lno, l.title, DATE_FORMAT(l.rdate, '%Y-%m-%d') AS rdate, l.hit " +
                    		  "FROM library l INNER JOIN user u ON l.uno = u.uno ";
	        // 검색 조건이 있을 경우 WHERE 조건 추가
	        if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
	            boardsql += "WHERE " + searchType + " LIKE ? ";
	        }
	        
	        boardsql += "ORDER BY l.lno DESC LIMIT ?, ?"; // 최신 게시글 순으로 정렬 및 LIMIT 사용
	        
	        psmt = conn.prepareStatement(boardsql);
	        
	        int paramIndex = 1; // PreparedStatement 파라미터 인덱스
	        if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
	            psmt.setString(paramIndex++, "%" + searchValue + "%"); // 검색어 바인딩
	        }
			
	        // LIMIT 절에 사용할 시작 인덱스와 표시할 게시글 수 설정
	        psmt.setInt(paramIndex++, (page - 1) * recordsPerPage); // 시작 인덱스
	        psmt.setInt(paramIndex, recordsPerPage); // 표시할 게시글 수
	        
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
	        request.setAttribute("searchType", searchType); // 검색 필드
	        request.setAttribute("searchValue", searchValue); // 검색어
	        
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
				sql = "SELECT l.*, u.id, f.orgFileName,f.newFileName FROM library l INNER JOIN user u ON l.uno = u.uno left outer join file f on l.lno=f.lno WHERE l.lno = ?"; 
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
					vo.setNewFileName(rs.getString("newFileName"));
					
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
		
		int lno = Integer.parseInt(request.getParameter("lno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConn.conn();
			String sql = "SELECT l.lno, l.title, l.content, u.id, f.orgFileName FROM library l INNER JOIN user u ON l.uno = u.uno LEFT JOIN file f ON f.lno = l.lno WHERE l.lno = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, lno);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				libraryVO vo = new libraryVO();
				vo.setLno(rs.getInt("lno"));
				vo.setTitle(rs.getString("title"));
				vo.setId(rs.getString("id"));
				vo.setContent(rs.getString("content"));
				vo.setOrgFileName("orgFileName");
				
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
		
		request.getRequestDispatcher("/WEB-INF/library_board/library_modify.jsp").forward(request, response);
		
	}
private void library_modifyOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
		
		
		int lno = Integer.parseInt(multi.getParameter("lno"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		
		try {
			
			conn = DBConn.conn();
			
	        // 1. library 테이블 업데이트 (title, content 수정)
	        String sql = "UPDATE library SET title = ?, content = ? WHERE lno = ?";
	        
	        psmt = conn.prepareStatement(sql);
	        
	        psmt.setString(1, title);
	        psmt.setString(2, content);
	        psmt.setInt(3, lno);
	        
	        psmt.executeUpdate();
	        
	        
	        // 쿼리 실행
	        int result = psmt.executeUpdate();

	        // 성공 시 리다이렉트
	        if (result > 0) {
	            response.sendRedirect("library_view.do?lno="+lno);
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
	private void library_writeok(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 요청 데이터의 인코딩 설정
	    request.setCharacterEncoding("UTF-8");

	    // 세션에서 로그인된 사용자 정보 가져오기
	    HttpSession session = request.getSession();
	    UserVO loginVO = (UserVO) session.getAttribute("loginUser");

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

	    // MultipartRequest에서 title과 content 가져오기
	    String title = multi.getParameter("title");
	    String content = multi.getParameter("content");

	    // 파일 관련 변수 초기화
	    Enumeration<?> files = multi.getFileNames();
	    String phyName = "";  // 서버에 저장될 실제 파일명
	    String logiName = ""; // 원본 파일명 (사용자가 업로드한 파일명)

	    if (files.hasMoreElements()) {
	        String fileElement = (String) files.nextElement();
	        String fileName = multi.getFilesystemName(fileElement);  // 저장된 파일명 가져오기
	        if (fileName != null) {
	            phyName = UUID.randomUUID().toString();  // 고유한 이름 생성
	            File srcFile = new File(uploadPath + File.separator + fileName);
	            File targetFile = new File(uploadPath + File.separator + phyName);
	            if (srcFile.renameTo(targetFile)) {  // 파일명 변경
	                logiName = multi.getOriginalFileName(fileElement);  // 원본 파일명 저장
	            }
	        }
	    }

	    Connection conn = null;  // DB 연결
	    PreparedStatement psmt = null;

	    try {
	        // DB 연결
	        conn = DBConn.conn();

	        // 1. library 테이블에 데이터 삽입 (게시글 정보)
	        String sql = "INSERT INTO library(title, content, uno) VALUES(?, ?, ?)";
	        psmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
	        psmt.setString(1, title);
	        psmt.setString(2, content);
	        psmt.setInt(3, loginVO.getUno());
	        int result = psmt.executeUpdate();  // SQL 실행 (데이터 삽입)

	        // 게시글 데이터가 성공적으로 삽입되면 파일 정보 삽입
	        if (result > 0) {
	            ResultSet generatedKeys = psmt.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                int lno = generatedKeys.getInt(1);  // 생성된 lno 가져오기

	                // 2. file 테이블에 파일 정보 삽입 (파일이 있는 경우)
	                if (!logiName.isEmpty() && !phyName.isEmpty()) {
	                    String fileSql = "INSERT INTO file(orgFileName, newFileName, lno) VALUES(?, ?, ?)";
	                    try (PreparedStatement filePsmt = conn.prepareStatement(fileSql)) {
	                        filePsmt.setString(1, logiName);
	                        filePsmt.setString(2, phyName);
	                        filePsmt.setInt(3, lno);
	                        filePsmt.executeUpdate();
	                        System.out.println("File inserted successfully: " + logiName + " -> " + phyName);
	                    }
	                }
	            }
	            // 게시글 목록 페이지로 리다이렉트
	            response.sendRedirect("library_list.do");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().println("Error: 데이터베이스 처리 중 오류가 발생했습니다.");
	    } finally {
	        // 리소스 해제
	        try {
	            DBConn.close(psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

	
	private void library_delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int lno = Integer.parseInt(request.getParameter("lno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			
			conn = DBConn.conn();
			
			String sql = "DELETE FROM library WHERE lno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, lno);
			
			int result = psmt.executeUpdate();
			
			response.sendRedirect(request.getContextPath()+"/library/library_list.do");
			
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
