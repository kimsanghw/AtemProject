package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import FrontController.util.DBConn;
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
		}else if(comments[comments.length-1].equals("library_modify.do")) {
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
		
	}
	private void notice_writeok(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 요청 데이터의 인코딩 설정
	    request.setCharacterEncoding("UTF-8");
	    
	    // 세션에서 로그인된 사용자 정보 가져오기
	    HttpSession session = request.getSession();
	    UserVO loginVO = (UserVO) session.getAttribute("loginUser");
	    
	    Connection conn = null;  // DB 연결
	    PreparedStatement psmt = null;
	    
	    try {
	    	
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

	}
	private void notice_view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	private void notice_modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	private void notice_modifyOk(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	private void notice_delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}








}
