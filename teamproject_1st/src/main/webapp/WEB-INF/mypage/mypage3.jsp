<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="FrontController.vo.UserVO" %>
<%@ page import="FrontController.vo.UserVO" %>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<%@ include file="../../include/header.jsp" %>
<%
	UserVO role = (UserVO) session.getAttribute("loginUser");
    
    if( role == null || !role.getAuthorization().equals("A")){
    	response.sendRedirect(request.getContextPath()+ "/user/login.do");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    .pagination {
    display: flex;
    justify-content: center;
    margin: 20px 0; 
	}

	.pagination a, .pagination strong {
	    margin: 0 5px;	
	    text-decoration: none;
	    color: black;
	}
    .mypage{
        font-size: 25px;
        font-weight: 900;
        margin: 50px 355px;
    }
    .mypage_menu{
        font-size: 20px;
        font-weight: 900;
        margin: 25px 355px;
    }
    .mypage_menu a{
        text-decoration: none;
        color: black;
    }
    .mypage_admin{
        /*display: none;*/
    }
    .mypage_line{
        border: 1px solid black;
        width: 150px;
        margin: 0px 355px;
    }
    section {
        flex-grow: 1; /* ë¨ì ê³µê°ì ì°¨ì§íëë¡ ì¤ì  */
        padding-bottom: 80px;
    }
    .mypage_box{
        border: 2px solid gray;
        width: 930px;
        border-radius: 20px;
        margin: -20px 0 0 -280px;
        padding-bottom: 30px;
    }
    .mypage_flex{
        float: left;
    }
    .admin_page{
        font-size: 20px;
        font-weight: 900;
        margin: 40px 50px;
    }
    .admin_page_table{
        margin: 0px 50px;
        border: none;
    }
    .admin_page_border th{
        
        background-color: silver;
    }
    .admin_page_my th{
        background-color: rgb(253, 253, 253);
    }
    select{
        width: 80px;
    }
    .authority_container{
        display: flex;
        align-items: center;
    }
    .authority_button {
        margin-left: 10px; /* ë²í¼ê³¼ select ê°ê²© ì¡°ì  */
        width: 50px;
    }
    .mypage_searchBox{
        text-align: center;
        margin: 0px 200px;
        margin-top: 30px;
        width: 500px;
        height: 30px;
    }
    .search_options{
        height: 30px;
        position: absolute;
        margin: 30px 200px;
    }
    .search{
        position: absolute;
        margin: 30px 658px;
        width: 50px;
        height: 30px;
    }
    
    </style>
</head>
<body>
      <section>
        <div class="mypage">관리자 페이지</div>
        <div class="mypage_flex">
            <div class="mypage_mypage mypage_menu"><a href="<%=request.getContextPath()%>/mypage/mypage.do">마이페이지 ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_study mypage_menu"><a href="<%=request.getContextPath()%>/mypage/mypage2.do">내 강의 목록 ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_admin mypage_menu" id="admin_page"><a href="<%=request.getContextPath()%>/mypage/mypage3.do">관리자 페이지 ></a></div> <!-- 어드민으로 로그인 시 보이는 div영역-->
            <div class="mypage_line mypage_admin"></div>
        </div>
        <div class="mypage_box mypage_flex">
            <div class="admin_page">권한 설정</div>
            <table border="1" class="admin_page_table">
                <thead>
                    <tr class="admin_page_border">
                        <th width="120px">아이디</th>
                        <th width="90px">이름</th>
                        <th width="300px">이메일</th>
                        <th width="200px">연락처</th>
                        <th width="120px">권한</th>
                    </tr>
                </thead>
                <tbody>
<% 
					    List<UserVO> userList = (List<UserVO>) request.getAttribute("userList");
					    int currentPage = (Integer) request.getAttribute("currentPage");
					    int totalPages = (Integer) request.getAttribute("totalPages");
					    if (userList != null) {
				        for (UserVO user : userList) { 
%>
                    <tr class="admin_page_my"> <!--form태그를 없애고 등록 버튼을 눌렀을 때 ajax로 select값을 넘겨주게 해야함.-->
                        <td width="120px"><%= user.getId() %></td>
                        <td width="90px"><%= user.getName() %></td>
                        <td width="300px"><%= user.getEmail() %></td>
                        <td width="200px"><%= user.getPhone() %></td>
                        <td width="120px">
                            <div class="authority_container">
						        <select name="authority">
						            <%
						                String authorization = user.getAuthorization();
						                String defaultOption = "";
						                if ("S".equals(authorization)) {
						                    defaultOption = "학생";
						                } else if ("T".equals(authorization)) {
						                    defaultOption = "강사";
						                } else if ("A".equals(authorization)) {
						                    defaultOption = "관리자";
						                }
						            %>
						            <option value="<%= authorization %>" selected disabled hidden><%= defaultOption %></option>
						            <option value="S">학생</option>
						            <option value="T">강사</option>
						            <option value="A">관리자</option>
						        </select>
						        <button class="authority_button" type="submit">등록</button>
						    </div>
                        </td>
                    </tr>
<%						}
					  }    
%>
                </tbody>
            </table>
            <!-- 페이지 네비게이션 추가 -->
            <div class="pagination">
			    <% 
			        int startPage = (Integer) request.getAttribute("startPage");
			        int endPage = (Integer) request.getAttribute("endPage");
			        
			        // Display "Previous" button if current page is beyond the first set
			        if (startPage > 1) { 
			    %>
			        <a href="<%=request.getContextPath()%>/mypage/mypage3.do?page=<%= startPage - 1 %>">Previous</a>
			    <% 
			        }
			        
			        // Display page numbers within the current set
			        for (int i = startPage; i <= endPage; i++) { 
			            if (i == currentPage) { 
			    %>
			                <strong><%= i %></strong> 
			    <% 
			            } else { 
			    %>
			                <a href="<%=request.getContextPath()%>/mypage/mypage3.do?page=<%= i %>"><%= i %></a>
			    <% 
			            }
			        } 
			        
			        // Display "Next" button if there are more pages beyond the current set
			        if (endPage < totalPages) { 
			    %>
			        <a href="<%=request.getContextPath()%>/mypage/mypage3.do?page=<%= endPage + 1 %>">Next</a>
			    <% 
			        } 
			    %>
			</div>
            <form action="action=<%=request.getContextPath()%>/mypage/mypage3search.do" method="GET">
                <select class="search_options" name="search_option">
                    <option value="id">아이디</option>
                    <option value="name">이름</option>
                    <option value="email">이메일</option>
                    <option value="phone">연락처</option>
                </select>
                <button class="search" type="submit">검색</button>
                <input class="mypage_searchBox" type="text" placeholder="검색어를 입력해주세요" name="mypage_search">
            </form>
        </div>
    </section>
<%@ include file="../../include/footer.jsp" %>
</body>
<script>
	$(document).ready(function() {
	    $(".authority_button").on("click", function(e) {
	        e.preventDefault();
	        
	        var selectedAuthority = $(this).siblings("select[name='authority']").val();
	        var userId = $(this).closest("tr").find("td:first").text();
	        
	        $.ajax({
	            url: "<%=request.getContextPath()%>/mypage/mypage3.do",
	            type: "POST",
	            data: { id: userId, authority: selectedAuthority },
	            success: function(response) {
					alert("권한 변경에 성공하였습니다.");
	            },
	            error: function() {
	                alert("권한 변경에 실패했습니다.");
	            }
	        });
	    });
	});
</script>
</html>