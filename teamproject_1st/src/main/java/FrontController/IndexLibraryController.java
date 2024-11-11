package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

import FrontController.util.DBConn;
import FrontController.vo.libraryVO;

public class IndexLibraryController extends HttpServlet {

    public List<libraryVO> makeLibraryList() throws ServletException, IOException {
    	System.out.println("makeNoticeList() 가 호출되었습니다");
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        
        List<libraryVO> noticeList = new ArrayList<>();
        
        try {
            conn = DBConn.conn();
            
            String sql = " SELECT * " +
                    " FROM library " +
                    " ORDER BY rdate DESC " + // 예를 들어, rdate 기준으로 최신 순 정렬
                    " LIMIT 3"; // 최신 공지사항 3개만 가져오기
            
            psmt = conn.prepareStatement(sql);
            rs = psmt.executeQuery();
            
            while (rs.next()) {
            	libraryVO notice = new libraryVO();
                notice.setTitle(rs.getString("title"));
                notice.setLno(rs.getInt("lno"));
                
                // 필요 시 다른 속성도 설정
                // notice.setOtherField(rs.getString("other_column"));

                noticeList.add(notice);
            }
            
///            return noticeList;
            
//            request.setAttribute("noticeList", noticeList);
//            request.getRequestDispatcher("./index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                DBConn.close(rs, psmt, conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
		return noticeList;
    }
}
