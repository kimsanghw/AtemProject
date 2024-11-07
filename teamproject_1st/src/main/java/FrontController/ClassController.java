package FrontController;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import FrontController.util.DBConn;
import FrontController.util.PagingUtil;
import FrontController.vo.ClassVO;
import FrontController.vo.UserVO;



public class ClassController {
	public ClassController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
	
		if(comments[comments.length-1].equals("view.do")) {
			if(request.getMethod().equals("GET")){
				view(request,response);
			} else if(request.getMethod().equals("POST")) {
				
			}
		} else if(comments[comments.length-1].equals("list.do")) {
			if(request.getMethod().equals("GET")){
				list(request,response);
			}
		} else if(comments[comments.length-1].equals("writer.do")) {
			if(request.getMethod().equals("GET")){
				writer(request,response);
			} else if(request.getMethod().equals("POST")) {
				writerOk(request,response);
			}
		} else if(comments[comments.length-1].equals("modify.do")) {
			if(request.getMethod().equals("GET")){
				modify(request,response);
			} else if(request.getMethod().equals("POST")) {
				modifyOk(request,response);
			}
		} else if(comments[comments.length-1].equals("delete.do")) {
			if(request.getMethod().equals("POST")){
				delete(request,response);
			} 
		} else if(comments[comments.length-1].equals("app_class.do")) {
			if(request.getMethod().equals("POST")){
				app_class(request,response);
			} 
		}
	}
	public void view (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = "SELECT c.*, u.name FROM class c INNER JOIN user u ON c.uno = u.uno WHERE c.cno = ?";			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, cno);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				ClassVO vo = new ClassVO();
				vo.setCno(rs.getInt("cno"));
				vo.setName(rs.getString("name"));
				vo.setRdate(rs.getString("rdate"));
				vo.setTitle(rs.getString("title"));
				vo.setBook(rs.getString("book"));
				vo.setDuringclass(rs.getString("duringclass"));
				vo.setJdate(rs.getString("jdate"));
				vo.setSubject(rs.getString("subject"));
				vo.setDifficult(rs.getString("difficult"));
				vo.setState(rs.getString("state"));
				vo.setEnd_duringclass(rs.getString("end_duringclass"));
				vo.setEnd_jdate(rs.getString("end_jdate"));
				vo.setOrgFileName(rs.getString("orgFileName"));
				vo.setNewFileName(rs.getString("newFileName"));
				
				request.setAttribute("vo", vo);
				request.getRequestDispatcher("/WEB-INF/class/class_view.jsp").forward(request, response);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
	            DBConn.close(psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
	}
	public void list (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String searchType = request.getParameter("category");
		String searchKeyword = request.getParameter("searchKeyword");

		List<ClassVO> coursList  = new ArrayList<ClassVO>();
		int nowPage = 1;

		if(request.getParameter("nowPage") != null && !request.getParameter("nowPage").isEmpty()){
		    nowPage = Integer.parseInt(request.getParameter("nowPage"));
		} else {
		    nowPage = 1;
		}

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		PreparedStatement psmtTotal = null;
		ResultSet rsTotal = null;

		try {
		    conn = DBConn.conn();
		    
		    // 기본 SQL 쿼리
		    String sqlTotal = "SELECT COUNT(*) AS total FROM class c JOIN user u ON c.uno = u.uno WHERE c.state = 'E'";
		    String sql = "SELECT c.* FROM class c JOIN user u ON c.uno = u.uno WHERE c.state = 'E'";

		    // 검색 조건 추가
		    if (searchKeyword != null && !searchKeyword.isEmpty()) {
		        if ("title".equals(searchType)) {
		            sqlTotal += " AND c.title LIKE ?";
		            sql += " AND c.title LIKE ?";
		        } else if ("content".equals(searchType)) {
		            sqlTotal += " AND c.content LIKE ?";
		            sql += " AND c.content LIKE ?";
		        }
		    }

		    // 총 개수 쿼리 준비
		    psmtTotal = conn.prepareStatement(sqlTotal);
		    
		    // 검색 키워드가 있을 경우 파라미터 설정
		    int paramIndex = 1;
		    if (searchKeyword != null && !searchKeyword.isEmpty()) {
		        psmtTotal.setString(paramIndex++, "%" + searchKeyword + "%");
		    }

		    rsTotal = psmtTotal.executeQuery();
		    int total = 0;
		    if(rsTotal.next()){
		        total = rsTotal.getInt("total");
		    }

		    // 페이징 처리
		    PagingUtil paging = new PagingUtil(nowPage, total, 5); 

		    // 강의 목록 쿼리 준비
		    sql += " ORDER BY c.rdate DESC LIMIT ? OFFSET ?";
		    psmt = conn.prepareStatement(sql);
		    
		    paramIndex = 1; // 파라미터 인덱스 초기화
		    if (searchKeyword != null && !searchKeyword.isEmpty()) {
		        psmt.setString(paramIndex++, "%" + searchKeyword + "%");
		    }

		    psmt.setInt(paramIndex++, paging.getPerPage());
		    psmt.setInt(paramIndex, (paging.getNowPage() - 1) * paging.getPerPage());

		    rs = psmt.executeQuery(); // 결과 집합 가져오기

		    while(rs.next()) {
		        ClassVO vo = new ClassVO();
		        vo.setCno(rs.getInt("cno"));
		        vo.setTitle(rs.getString("title"));
		        vo.setDifficult(rs.getString("difficult"));
		        vo.setDuringclass(rs.getString("duringclass"));
		        vo.setName(rs.getString("name"));
		        vo.setOrgFileName(rs.getString("orgFileName"));
		        vo.setNewFileName(rs.getString("newFileName"));

		        coursList.add(vo);
		    }

		    request.setAttribute("coursList", coursList);
		    request.setAttribute("paging", paging);
		    
		    request.getRequestDispatcher("/WEB-INF/class/class_list.jsp").forward(request, response);

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
		
	}
	public void writer (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_add.jsp").forward(request, response);
	}
	public void writerOk (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		int size = 10*1024*1024; 
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload"); //절대경로
		MultipartRequest multi = null;

		try{
		multi = new MultipartRequest(
				request, 
				uploadPath, 
				size, 
				"UTF-8", 
				new DefaultFileRenamePolicy()	
				);
		}catch( Exception e){
			System.out.println(e);
			response.sendRedirect(""); return;
		}
		
		String name = multi.getParameter("name");
		Enumeration<?> files= multi.getFileNames();
		String phyName = "";
		String logiName = "";
		
		if (files != null) {
		    String fileId = (String) files.nextElement();
		    String fileName = multi.getFilesystemName("attach");
		    if (fileName != null) {
		        String newFileName = UUID.randomUUID().toString();
		        String orgName = uploadPath + "\\" + fileName;
		        String newName = uploadPath + "\\" + newFileName;
		        File srcFile = new File(orgName);
		        File targetFile = new File(newName);
		        if (srcFile.renameTo(targetFile)) {
		            phyName = newFileName;
		            logiName = multi.getOriginalFileName("attach"); // 원본 파일명 가져오기
		        }
		    }
		}
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			

			int uno = loginUser.getUno(); 
			int cno = 0;
			String title = multi.getParameter("title"); 
			String teacher_name = multi.getParameter("teacher_name");
			String subject = multi.getParameter("subject");
			String jdate = multi.getParameter("jdate");
			String diffcult = multi.getParameter("diffcult");
			String book = multi.getParameter("book");
			String duringclass = multi.getParameter("duringclass");
			String orgFileName = multi.getOriginalFileName("attach");
			String end_jdate = multi.getParameter("end_jdate");
			String end_duringclass = multi.getParameter("end_duringclass");
			
			Connection conn = null;
			PreparedStatement psmt = null;
			
			try {
		        conn = DBConn.conn();
		        String classSql = "INSERT INTO class(title, subject, jdate, difficult, book, duringclass, name, uno, end_jdate, end_duringclass, orgFileName, newFileName) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		        
		        psmt = conn.prepareStatement(classSql);
		        psmt.setString(1, title);
		        psmt.setString(2, subject);
		        psmt.setString(3, jdate);
		        psmt.setString(4, diffcult);
		        psmt.setString(5, book);
		        psmt.setString(6, duringclass);
		        psmt.setString(7, teacher_name);
		        psmt.setInt(8, uno);
		        psmt.setString(9, end_jdate);
		        psmt.setString(10, end_duringclass);
		        psmt.setString(11, orgFileName);
		        psmt.setString(12, phyName);
		        
		        
		        psmt.executeUpdate();
		        
		       
		        response.sendRedirect(request.getContextPath() + "/class/list.do");
			    } catch (Exception e) {
			        e.printStackTrace();
			    } finally {
			        try {
			            DBConn.close( psmt, conn);
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
			    }
	}
	public void modify (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = "SELECT cno, title, c.name, subject, difficult, book, c.uno FROM class c INNER JOIN user u ON c.uno = u.uno WHERE cno = ?";			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, cno);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				ClassVO vo = new ClassVO();
				vo.setName(rs.getString("name"));
				vo.setTitle(rs.getString("title"));
				vo.setSubject(rs.getString("subject"));
				vo.setDifficult(rs.getString("difficult"));
				vo.setBook(rs.getString("book"));
				vo.setUno(rs.getInt("uno"));
				vo.setCno(rs.getInt("cno"));
				
				request.setAttribute("vo", vo);
				request.getRequestDispatcher("/WEB-INF/class/class_modify.jsp").forward(request, response);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
	}
	public void modifyOk (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int size = 10*1024*1024; // 첨부파일의 크기 4MB?
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload"); //절대경로
		MultipartRequest multi = null;

		try{
		multi = new MultipartRequest(
				request, 
				uploadPath, 
				size, 
				"UTF-8", 
				new DefaultFileRenamePolicy()	
				);
		}catch( Exception e){
			System.out.println(e);
			response.sendRedirect(""); return;
		}
		
		String name = multi.getParameter("name");
		Enumeration<?> files= multi.getFileNames();
		String phyName = "";
		String logiName = "";
		
		if (files != null) {
		    String fileId = (String) files.nextElement();
		    String fileName = multi.getFilesystemName("attach");
		    if (fileName != null) {
		        String newFileName = UUID.randomUUID().toString();
		        String orgName = uploadPath + "\\" + fileName;
		        String newName = uploadPath + "\\" + newFileName;
		        File srcFile = new File(orgName);
		        File targetFile = new File(newName);
		        if (srcFile.renameTo(targetFile)) {
		            phyName = newFileName;
		            logiName = multi.getOriginalFileName("attach"); // 원본 파일명 가져오기
		        }
		    }
		}
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			

			int uno = loginUser.getUno(); 
			int cno =  Integer.parseInt(multi.getParameter("cno"));
			System.out.println("현재 cno : "+Integer.parseInt(multi.getParameter("cno")));
			String title = multi.getParameter("title"); 
			String Tname = multi.getParameter("name");
			String subject = multi.getParameter("subject");
			String jdate = multi.getParameter("jdate");
			String difficult = multi.getParameter("difficult");
			String book = multi.getParameter("book");
			String duringclass = multi.getParameter("duringclass");
			String orgFileName = multi.getOriginalFileName("attach");
			String end_jdate = multi.getParameter("end_jdate");
			String end_duringclass = multi.getParameter("end_duringclass");
			String newFileName = "";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			try {
		        conn = DBConn.conn();
		        String classSql = "UPDATE class SET title=?, subject=?, jdate=?, difficult=?, book=?, duringclass=?, name=?, end_jdate=?, end_duringclass=?, orgFileName=?, newFileName=? WHERE cno = ?"; 
		        
		        // Statement.RETURN_GENERATED_KEYS를 지정하여 PreparedStatement 생성
		        psmt = conn.prepareStatement(classSql);
		        psmt.setString(1, title);
		        psmt.setString(2, subject);
		        psmt.setString(3, jdate);
		        psmt.setString(4, difficult);
		        psmt.setString(5, book);
		        psmt.setString(6, duringclass);
		        psmt.setString(7, Tname);
		        psmt.setString(8, end_jdate);
		        psmt.setString(9, end_duringclass);
		        psmt.setString(10, orgFileName);
		        psmt.setString(11, phyName);
		        psmt.setInt(12, cno);
		        
		        psmt.executeUpdate();
		        
		        response.sendRedirect(request.getContextPath() + "/class/view.do?cno=" + cno);
			    } catch (Exception e) {
			        e.printStackTrace();
			    } finally {
			        try {
			            DBConn.close(rs, psmt, conn);
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
			    }
	}
	public void delete (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		System.out.println("현재 cno " + cno );
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			
			conn = DBConn.conn();
			
			String sql = "UPDATE class SET state='D' WHERE cno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, cno);
			
			psmt.executeUpdate();
			
			//3. /board/main.do�� �̵�
			response.sendRedirect(request.getContextPath()+"/class/list.do");
			
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
	public void app_class (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//데이터를 가져오기
		int cno = Integer.parseInt(request.getParameter("cno"));
		int uno = Integer.parseInt(request.getParameter("uno"));
		String title = request.getParameter("title");
		String subject = request.getParameter("subject");
		String jdate = request.getParameter("jdate");
		String end_jdate = request.getParameter("end_jdate");
		String difficult = request.getParameter("difficult");
		String book = request.getParameter("book");
		String duringclass = request.getParameter("duringclass");
		String end_duringclass = request.getParameter("end_duringclass");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		   try {
		        conn = DBConn.conn();

		        // 이미 다른 강의를 신청했는지 확인
		        String sqlCheck = "SELECT COUNT(*) AS count FROM app_class WHERE uno = ?";
		        psmt = conn.prepareStatement(sqlCheck);
		        psmt.setInt(1, uno);

		        rs = psmt.executeQuery();
		        if (rs.next() && rs.getInt("count") > 0) {
		            // 이미 다른 강의를 신청한 경우 경고 메시지 출력
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('이미 다른 강의를 신청하셨습니다. 추가로 신청할 수 없습니다.');");
		            out.println("history.back();");
		            out.println("</script>");
		            return; // 더 이상 진행하지 않음
		        }

		        // 중복되지 않은 경우에만 강의 신청
		        String insertSQL = "INSERT INTO app_class (uno, cno) VALUES (?, ?)";
		        psmt = conn.prepareStatement(insertSQL);
		        psmt.setInt(1, uno);
		        psmt.setInt(2, cno);

		        int result = psmt.executeUpdate();

		        if (result > 0) {
		            // 성공적으로 등록되면 마이페이지로 이동
		            request.getRequestDispatcher("/WEB-INF/mypage/mypage2.jsp").forward(request, response);
		        } else {
		            // 실패한 경우 오류 메시지 출력
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('강의 신청에 실패했습니다. 다시 시도해주세요.');");
		            out.println("history.back();");
		            out.println("</script>");
		        }

		    } catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBConn.close(rs, psmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}

	
