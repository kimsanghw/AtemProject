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
        section{
            width: 63%;
            margin: 0px auto;
            background-color: white;
            border-radius: 8px;
            flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
            padding-bottom: 80px;
        }
        .free_title{
            border-bottom: 5px solid #007ACC;
            margin-top: 55px;
        }
        .index_search_table table{
            width: 1200px;
            height: 35px;
            margin-top: 30px;
        }
        .search_line{
        	border: 1px solid black;
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
                                    <!-- 각 게시판 종류에 따라 다른 상세페이지 링크 -->
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
        </div>
    </section>
      <%@ include file="../../include/footer.jsp" %>
</body>
</html>