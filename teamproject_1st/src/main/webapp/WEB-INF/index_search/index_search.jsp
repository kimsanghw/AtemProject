<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="FrontController.vo.SearchVO" %>
<%@ include file="../../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>search_page</title>
    <style>
        /* section 부분 시작 */
        section {
            width: 63%;
            margin: 0px auto;
            background-color: white;
            border-radius: 8px;
            flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
            padding-bottom: 80px;
        }
        .free_title {
            border-bottom: 5px solid #007ACC;
            margin-top: 55px;
        }
        .index_search_table table {
            width: 1200px;
            height: 35px;
            margin-top: 30px;
        }
        .search_line {
            border: 1px solid black;
        }
        .pagination {
            display: flex;
            justify-content: center; /* 가운데 정렬 */
            margin: 20px 0; 
        }
        .pagination a, .pagination strong {
            margin: 0 5px;	
            text-decoration: none;
            color: black;
        }
        /* 페이지 번호의 스타일 */
        .pagination a {
            padding: 5px 10px; /* 링크에 패딩 추가 */
            border: 1px solid #007ACC; /* 테두리 추가 */
            border-radius: 5px; /* 모서리 둥글게 */
            transition: background-color 0.3s; /* 호버 효과를 부드럽게 */
        }
        .pagination a:hover {
            background-color: #007ACC; /* 호버 시 배경색 변경 */
            color: white; /* 호버 시 글자색 변경 */
        }
        .pagination strong {
            padding: 5px 10px; /* 강조된 페이지 번호에 패딩 추가 */
            background-color: #007ACC; /* 강조된 페이지 번호 배경색 */
            color: white; /* 강조된 페이지 번호 글자색 */
            border-radius: 5px; /* 모서리 둥글게 */
        }
    </style>
</head>
<body>
    <section>
        <div class="free_title"><h2>검색 결과</h2></div>
        <div class="index_search_table">
            <table>
                <thead>
                    <tr>
                        <th style="width: 150px;">게시판 종류</th>
                        <th style="width: 150px;">작성자</th>
                        <th style="width: 600px;">제목</th>
                        <th style="width: 250px;">작성 날짜</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    ArrayList<SearchVO> searchResults = (ArrayList<SearchVO>) request.getAttribute("searchResults");
                    if (searchResults != null && !searchResults.isEmpty()) {
                        for (SearchVO result : searchResults) { 
                            String detailUrl = "";
                            switch (result.getBoard()) {
                                case "공지게시판":
                                    detailUrl = request.getContextPath() + "/noticeDetail.do?no=" + result.getNo();
                                    break;
                                case "qna게시판":
                                    detailUrl = request.getContextPath() + "/qnaDetail.do?no=" + result.getNo();
                                    break;
                                case "자료실게시판":
                                    detailUrl = request.getContextPath() + "/library/library_view.do?lno=" + result.getNo();
                                    break;
                                default:	
                                    detailUrl = "#";
                            }
                    %>
                            <tr>
                                <th><%= result.getBoard() %></th>
                                <th><%= result.getName() %></th>
                                <th>
                                    <a href="<%= detailUrl %>">
                                        <%= result.getTitle() %>
                                    </a>
                                </th>
                                <th><%= result.getRdate() %></th>
                            </tr>
                    <% 
                        }
                    } else { 
                    %>
                        <tr><td colspan="4">검색 결과가 없습니다.</td></tr>
                    <% } %>
                </tbody>
            </table>
            <div class="pagination">
                <% 
                    int startPage = (Integer) request.getAttribute("startPage");
                    int endPage = (Integer) request.getAttribute("endPage");
                    int nowPage = (Integer) request.getAttribute("nowPage");
                    int totalPages = (Integer) request.getAttribute("totalPages");
                    String search = request.getParameter("search");
                    String indexSearch = request.getParameter("indexSearch");
            
                    // 이전 버튼
                    if (startPage > 1) { 
                %>
                    <a href="?search=<%= search %>&indexSearch=<%= indexSearch %>&nowPage=<%= startPage - 1 %>">Previous</a>
                <% 
                    }
            
                    // 페이지 번호 표시
                    for (int i = startPage; i <= endPage; i++) { 
                        if (i == nowPage) { 
                %>
                            <strong><%= i %></strong> 
                <% 
                        } else { 
                %>
                            <a href="?search=<%= search %>&indexSearch=<%= indexSearch %>&nowPage=<%= i %>"><%= i %></a>
                <% 
                        }
                    } 
            
                    // 다음 버튼
                    if (endPage < totalPages) { 
                %>
                    <a href="?search=<%= search %>&indexSearch=<%= indexSearch %>&nowPage=<%= endPage + 1 %>">Next</a>
                <% 
                    } 
                %>
            </div>
        </div>
    </section>
    <%@ include file="../../include/footer.jsp" %>
</body>
</html>
