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
        String keyword = request.getParameter("search");
        String searchField = request.getParameter("indexSearch");
        int nowPage = 1;
        int pageSize = 1; // 페이지당 보여줄 게시물 수 (원하는 수치로 조정 가능)
        int pageGroupSize = 10; // 한번에 보여줄 페이지 수 (원하는 수치로 조정 가능)

        if (request.getParameter("nowPage") != null) {
            nowPage = Integer.parseInt(request.getParameter("nowPage"));
        }
        
        int startRow = (nowPage - 1) * pageSize;
        int totalRecords = 0;

        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("message", "검색 결과가 없습니다.");
            request.setAttribute("searchResults", new ArrayList<>());
            request.setAttribute("totalPages", 1);
            request.setAttribute("nowPage", nowPage);
            request.getRequestDispatcher("/WEB-INF/index_search/index_search.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        ArrayList<SearchVO> searchResults = new ArrayList<>();

        try {
            conn = DBConn.conn();

            // Count total records for pagination
            String countSql = "SELECT COUNT(*) FROM ("
                    + "SELECT nno AS no, title, content, '공지게시판' AS type FROM notice_board WHERE state = 'E' "
                    + "UNION ALL SELECT qno AS no, title, content, 'qna게시판' AS type FROM qna_board WHERE state = 'E' "
                    + "UNION ALL SELECT lno AS no, title, content, '자료실게시판' AS type FROM library WHERE state = 'E') alltb ";
            if (keyword != null && !keyword.trim().isEmpty()) {
                if ("title".equals(searchField)) {
                    countSql += "WHERE title LIKE ? ";
                } else if ("content".equals(searchField)) {
                    countSql += "WHERE content LIKE ? ";
                } else {
                    countSql += "WHERE (title LIKE ? OR content LIKE ?) ";
                }
            }
            
            psmt = conn.prepareStatement(countSql);
            int paramIndex = 1;
            String searchKeyword = "%" + keyword + "%";
            if ("title".equals(searchField) || "content".equals(searchField)) {
                psmt.setString(paramIndex++, searchKeyword);
            } else {
                psmt.setString(paramIndex++, searchKeyword);
                psmt.setString(paramIndex++, searchKeyword);
            }
            rs = psmt.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt(1);
            }
            
            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            // Reset for data retrieval
            rs.close();
            psmt.close();
            
            // Search with pagination
            String sql = "SELECT alltb.*, u.name, hit FROM ("
                    + "SELECT nno AS no, title, content, '공지게시판' AS type, rdate, uno, hit FROM notice_board WHERE state = 'E' "
                    + "UNION ALL SELECT qno AS no, title, content, 'qna게시판' AS type, rdate, uno, hit FROM qna_board WHERE state = 'E' "
                    + "UNION ALL SELECT lno AS no, title, content, '자료실게시판' AS type, rdate, uno, hit FROM library WHERE state = 'E') alltb "
                    + "INNER JOIN user u ON alltb.uno = u.uno ";
            if (keyword != null && !keyword.trim().isEmpty()) {
                if ("title".equals(searchField)) {
                    sql += "WHERE title LIKE ? ";
                } else if ("content".equals(searchField)) {
                    sql += "WHERE content LIKE ? ";
                } else {
                    sql += "WHERE (title LIKE ? OR content LIKE ?) ";
                }
            }
            sql += "ORDER BY type, rdate DESC LIMIT ?, ?";

            psmt = conn.prepareStatement(sql);
            paramIndex = 1;
            if ("title".equals(searchField) || "content".equals(searchField)) {
                psmt.setString(paramIndex++, searchKeyword);
            } else {
                psmt.setString(paramIndex++, searchKeyword);
                psmt.setString(paramIndex++, searchKeyword);
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

            request.setAttribute("searchResults", searchResults);
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("totalPages", totalPages);

            // Calculate start and end pages for pagination
            int startPage = ((nowPage - 1) / pageGroupSize) * pageGroupSize + 1;
            int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

            // Set pagination attributes
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { DBConn.close(rs, psmt, conn); } catch (Exception e) { e.printStackTrace(); }
        }

        request.getRequestDispatcher("/WEB-INF/index_search/index_search.jsp").forward(request, response);
    }
}
