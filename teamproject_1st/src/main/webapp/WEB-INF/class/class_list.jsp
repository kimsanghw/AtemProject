<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="FrontController.vo.ClassVO" %>
<%@ page import ="FrontController.vo.UserVO" %>
<%@ page import="FrontController.util.*" %>
<%@ page import ="java.util.*" %>
<%@ include file="../../include/header.jsp" %>
<%
    List<ClassVO> coursList = (List<ClassVO>)request.getAttribute("coursList");
    UserVO user = (UserVO) session.getAttribute("loginUser");
    String searchType = (String)request.getAttribute("searchType");
    System.out.println("searchtype : "+ searchType );
    String searchKeyword = (String)request.getAttribute("searchKeyword");
    System.out.println("searchkeyword : "+ searchKeyword );
    String nowPageParam = request.getParameter("nowPage");
    int nowPage = 1;
    if(nowPageParam != null){
        nowPage = Integer.parseInt(nowPageParam);
    }
    PagingUtil paging = (PagingUtil)request.getAttribute("paging");
    int StartPage = 1;
    int EndPage = 1;
    if( paging != null ){
        StartPage = paging.getStartPage();
        EndPage = paging.getEndPage();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 목록</title>
    <link rel="stylesheet" href="styles.css">
    <style>
.search-bar {
    display: flex;
    justify-content: center;
    padding: 20px;
    background-color: white;
}
.search-bar input {
  width: 1100px;
  height: 60px;
  margin: 0;
  margin-right: 0;
  box-sizing: border-box;
}
.search-bar #category{
  margin: 0px;
}
.search-bar button{
  margin: 0px;
}

.search-bar select, .search-bar input {
    padding: 5px;
    font-size: 16px;
}

.search-bar button {
    padding: 5px 10px;
    background-color: #0096FF;
    color: white;
    border: none;
    cursor: pointer;
}

.search-bar button:hover {
    background-color: #007ACC;
}

 hr{
  margin-bottom: 25px;
  border-top : 5px solid #007ACC;

 }
/* 강의 목록 스타일 */


.course-list {
    width: 63%;
    margin: 0px auto;
    background-color: white;
    border-radius: 8px;
}

.course-item {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    padding: 15px;
    background-color: #e0f7da;
    border-radius: 5px;
}
.course-item a{
  text-decoration-line: none;
  color: black;
}
.course-item img {
    width: 100px;
    height: 100px;
    margin-right: 20px;
}
.course-info{
  display: flex;
    justify-content: space-between; /* 요소 간의 간격을 균등하게 분배 */
    align-items: center; /* 요소들을 수직 가운데 정렬 */
    width: 100%; /* 부모 요소의 전체 너비 사용 */
}
.class_info{
  margin-right: 400px;
}
.course-info h2 {
    margin: 0;
    font-size: 22px;
}

.course-info p {
    margin: 5px 0;
    font-size: 16px;
}


.register-btn {

    padding: 10px 20px;
    background-color: #007ACC;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 16px;
    border-radius: 5px;
}
.mother {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    .paging-container {
        flex-grow: 1;
        text-align: center;
    }

    .paging {
        display: inline-block;
    }

    .button-container {
        flex-shrink: 0;
    }


.register-btn:hover {
    background-color: #007ACC;
}


    </style>
</head>
<body>
	<form action="<%=request.getContextPath()%>/class/list.do" method="get" class="search-bar">
        <label for="category"></label>
        <select class="search-options" id="category" name="category">
            <option value="title" <%="title".equals(searchType) ? "selected" : ""%>>제목</option>
            <option value="content" <%="content".equals(searchType) ? "selected" : ""%>>내용</option>
        </select>
        <input type="text" name="searchKeyword" placeholder="검색" value="<%=searchKeyword != null ? searchKeyword : ""%>">
        <button type="submit">검색</button>
    </form>

    <!-- 강의 목록 -->
	<section class="course-list">
		<div>
			<h1>강의 목록</h1>
			<hr>
		</div>
		<%
			for(ClassVO vo : coursList){
		%>
		<div class="course-item">
			<img src="<%=request.getContextPath()%>/upload/<%=vo.getNewFileName()%>">
			<div class="course-info">
				<a href="<%=request.getContextPath()%>/class/view.do?cno=<%=vo.getCno() %>"><div><h2><%= vo.getTitle() %></h2></div></a>
				<div class="class_info">
					<p>난이도: <%=vo.getDifficult() %></p>
					<p>강사: <%=vo. getName() %></p>
					<p>강의 기간: <%=vo.getDuringclass() %></p>
				</div>
			</div>
		</div>
		<% } %>

		<div class="mother">
			<div class="paging-container">
				<span class="paging">
			<%
				String queryString = "";
				if (searchType != null && !searchType.isEmpty()) {
				    queryString += "&category=" + searchType;
				}
				if (searchKeyword != null && !searchKeyword.isEmpty()) {
				    queryString += "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8");
				}
				%>
				
				<% if(paging.getStartPage() > 1) { %>
				    <a href="<%=request.getContextPath()%>/class/list.do?nowPage=<%=paging.getStartPage()-1%><%=queryString%>"> &lt; </a>
				<% } %>
				
				<% for(int i = paging.getStartPage(); i <= paging.getEndPage(); i++) { %>
				    <% if(i == nowPage) { %>
				        <strong><%= i %></strong>
				    <% } else { %>
				        <a href="<%=request.getContextPath()%>/class/list.do?nowPage=<%=i%><%=queryString%>"><%=i %></a>
				    <% } %>
				<% } %>
					</span>
			</div>
			<div class="button-container">
			<%
			    if (user != null) {
			        String authorization = user.getAuthorization();
			        if ("A".equals(authorization)) {
			%>
			<a href="<%=request.getContextPath()%>/class/writer.do?uno="><button class="register-btn">등록</button></a>
			<%
			        }
			    }
			%>
			</div>
		</div>
	</section>

    <!-- 푸터 -->
    <%@ include file="../../include/footer.jsp" %>
</body>
</html>
