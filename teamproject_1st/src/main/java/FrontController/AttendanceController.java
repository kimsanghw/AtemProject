package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FrontController.util.DBConn;
import FrontController.vo.ClassVO;

public class AttendanceController {
	
	public AttendanceController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException { 
		
		if(comments[comments.length-1].equals("attendanceView.do")) {
			attendanceView(request,response);
		}
	}
	public void attendanceView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int cno = Integer.parseInt(request.getParameter("cno"));
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = " SELECT c.*,u.id "
						+"   FROM class c , user u "
						+"  WHERE n.uno = u.uno"
						+"    AND cno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, cno);
			rs = psmt.executeQuery();
			
			//3. 찾은 상세 데이터 request에 담기
			if(rs.next()) {
				ClassVO vo = new ClassVO();
				vo.setCno(rs.getInt("cno"));
				vo.setTitle(rs.getString("title"));
				vo.setId(rs.getString("id"));
				vo.setRdate(rs.getString("rdate"));
				vo.setHit(rs.getInt("hit"));
				vo.setState(rs.getString("state"));
				vo.setContent(rs.getString("content"));
				
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
	}

}
