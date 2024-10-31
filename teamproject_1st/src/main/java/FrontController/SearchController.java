package FrontController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import FrontController.vo.SearchVO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FrontController.util.DBConn;

public class SearchController {
    public SearchController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException {
        if (comments[comments.length - 1].equals("search.do")) {
            if (request.getMethod().equals("GET")) {
                search(request, response);
            }
        }
    }

    public void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("search");  // 오타 수정
        int nowPage = 1;
        int pageSize = 10;
        if (request.getParameter("nowPage") != null) {
            nowPage = Integer.parseInt(request.getParameter("nowPage"));
        }
        int startRow = (nowPage - 1) * pageSize;

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        ArrayList<SearchVO> searchResults = new ArrayList<>();

        try {
            conn = DBConn.conn();
            String sql = "SELECT alltb.*, u.name, hit FROM ("
                    + "SELECT nno AS no, title, '공지게시판' AS type, rdate, uno, hit FROM notice_board WHERE state = 'E' "
                    + "UNION ALL SELECT qno AS no, title, 'qna게시판' AS type, rdate, uno, hit FROM qna_board WHERE state = 'E' "
                    + "UNION ALL SELECT lno AS no, title, '자료실게시판' AS type, rdate, uno, hit FROM library WHERE state = 'E') alltb "
                    + "INNER JOIN user u ON alltb.uno = u.uno ";
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += "WHERE title LIKE ? ";
            }
            sql += "ORDER BY type, rdate DESC LIMIT ?, ?";
            
            psmt = conn.prepareStatement(sql);
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                psmt.setString(paramIndex++, "%" + keyword + "%");
            }
            psmt.setInt(paramIndex++, startRow);
            psmt.setInt(paramIndex, pageSize);
            
            rs = psmt.executeQuery();
            while (rs.next()) {
                int no = rs.getInt("no");
                String board = rs.getString("type");
                String name = rs.getString("name");
                String title = rs.getString("title");
                String rdate = rs.getString("rdate");
                int hit = rs.getInt("hit");
                searchResults.add(new SearchVO(no, board, name, title, rdate, hit));
            }
            
            // 검색 결과 및 페이지 정보 전달
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("totalPages", (int) Math.ceil((double) searchResults.size() / pageSize));

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { DBConn.close(rs, psmt, conn); } catch (Exception e) { e.printStackTrace(); }
        }

        request.getRequestDispatcher("/WEB-INF/index_search/index_search.jsp").forward(request, response);
    }
}
