package FrontController;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import FrontController.util.DBConn;
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
		} else if(comments[comments.length-1].equals("register.do")) {
			if(request.getMethod().equals("GET")){
				register(request,response);
			} else if(request.getMethod().equals("POST")) {
				registerOk(request,response);
			}
		}
	}
	
	public void view (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_view.jsp").forward(request, response);
	}
	public void list (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_list.jsp").forward(request, response);
	}
	public void register (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/class/class_add.jsp").forward(request, response);
	}
	public void registerOk (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int size = 10*1024*1024; // 첨부파일의 크기 4MB?
		String uploadPath = "C:\\TEAM\\1st\\teamproject_1st\\src\\main\\webapp\\upload"; //절대경로
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
		
		if( files != null ){
			String fileId = (String) files.nextElement();
			String fileName = (String)multi.getFilesystemName("attach");
			if( fileName != null ){
				String newFileName = UUID.randomUUID().toString();
				String orgName = uploadPath + "\\" + fileName;
				String newName = uploadPath + "\\" + newFileName;
				File srcFile = new File(orgName);
				File targetFile = new File(newName);
				srcFile.renameTo(targetFile);	
				System.out.println("원본파일명 : " + fileName);
				System.out.println("새로운파일명 : " + newFileName);
				System.out.println("저장경로 : " + uploadPath);
				phyName = newFileName;
				logiName = fileName;
			}
		}
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			

			int uno = loginUser.getUno(); 
			String title = multi.getParameter("title"); 
			String Tname = multi.getParameter("name");
			String subject = multi.getParameter("subject");
			String jdate = multi.getParameter("jdate");
			String diffcult = multi.getParameter("diffcult");
			String book = multi.getParameter("book");
			String duringclass = multi.getParameter("duringclass");
			String orgFileName = multi.getParameter("orgFileName");

			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			try {
		        conn = DBConn.conn();
		        String classSql = "INSERT INTO class(title, subject, jdate, difficult, book, duringclass, uno) VALUES(?, ?, ?, ?, ?, ?, ?)";
		        
		        // Statement.RETURN_GENERATED_KEYS를 지정하여 PreparedStatement 생성
		        psmt = conn.prepareStatement(classSql, Statement.RETURN_GENERATED_KEYS);
		        psmt.setString(1, title);
		        psmt.setString(2, subject);
		        psmt.setString(3, jdate);
		        psmt.setString(4, diffcult);
		        psmt.setString(5, book);
		        psmt.setString(6, duringclass);
		        psmt.setInt(7, uno);
		        
		        int classResult = psmt.executeUpdate();
		        
		        if (classResult > 0) {
		            ResultSet generatedKeys = psmt.getGeneratedKeys();
		            if (generatedKeys.next()) {
		                int cno = generatedKeys.getInt(1);
		                String fileSql = "INSERT INTO cfile(orgFileName, NewFileName, cno) VALUES(?, ?, ?)";
		                psmt = conn.prepareStatement(fileSql);
		                psmt.setString(1, logiName);
		                psmt.setString(2, phyName);
		                psmt.setInt(3, cno);

		                int fileResult = psmt.executeUpdate();
		            
		                if (fileResult > 0) {
		                    // 파일 삽입 성공 처리 (필요한 경우)
		                }
		            }
		        }
			        response.sendRedirect(request.getContextPath() + "/class/list.do");
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
}
		


