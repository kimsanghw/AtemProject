package FrontController;

import java.io.File;
import java.io.IOException;
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
		}
	}
	
	public void view (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cno = Integer.parseInt(request.getParameter("cno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = "SELECT c.*, u.name, (SELECT orgFileName FROM cfile WHERE cfile.cno = c.cno LIMIT 1) AS orgFileName, (SELECT newFileName FROM cfile WHERE cfile.cno = c.cno LIMIT 1) AS newFileName FROM class c, user u WHERE c.uno = u.uno AND c.cno = ?";			
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
		List<ClassVO> coursList  = new ArrayList<ClassVO>();
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		try {
			conn = DBConn.conn();
	        String sql = "SELECT c.*, cf.* FROM class c, cfile cf WHERE c.cno=cf.cno;";
	        
	        psmt = conn.prepareStatement(sql);
	        rs = psmt.executeQuery();
	        
	        while(rs.next()) {
				ClassVO vo = new ClassVO();
				vo.setCno(rs.getInt("cno"));
				vo.setTitle(rs.getString("title"));
				vo.setDifficult(rs.getString("difficult"));
				vo.setDuringclass(rs.getString("duringclass"));
				vo.setName(rs.getString("name"));
				vo.setOrgFileName(rs.getString("orgFileName"));
				
				coursList.add(vo);
			}
	        
	        request.setAttribute("coursList", coursList);
	        
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
	            DBConn.close(rs, psmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
		request.getRequestDispatcher("/WEB-INF/class/class_list.jsp").forward(request, response);
	}
	public void writer (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_add.jsp").forward(request, response);
	}
	public void writerOk (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
			ResultSet rs = null;
			try {
		        conn = DBConn.conn();
		        String classSql = "INSERT INTO class(title, subject, jdate, difficult, book, duringclass, name, uno, end_jdate, end_duringclass) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		        
		        // Statement.RETURN_GENERATED_KEYS를 지정하여 PreparedStatement 생성
		        psmt = conn.prepareStatement(classSql, Statement.RETURN_GENERATED_KEYS);
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
		        
		        int classResult = psmt.executeUpdate();
		        
		        if (classResult > 0) {
		            ResultSet generatedKeys = psmt.getGeneratedKeys();
		            if (generatedKeys.next()) {
		                cno = generatedKeys.getInt(1);
		                String fileSql = "INSERT INTO cfile(orgFileName, NewFileName, cno) VALUES(?, ?, ?)";
		                psmt = conn.prepareStatement(fileSql);
		                psmt.setString(1, logiName);
		                psmt.setString(2, phyName);
		                psmt.setInt(3, cno);

		                int fileResult = psmt.executeUpdate();
		            
		                if (fileResult > 0) {
		                	System.out.println("File inserted successfully: " + logiName + " -> " + phyName);
		                }
		            }
		        }
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
	public void modify (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_modify.jsp").forward(request, response);
	}	
	public void modifyOk (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_modify.jsp").forward(request, response);
	}
}
