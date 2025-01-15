<%@page import="FrontController.vo.libraryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ include file="../../include/header.jsp" %>

<%
	libraryVO vo = (libraryVO)request.getAttribute("vo");
%>
<%
	//세션에서 로그인 정보 확인하기
	UserVO loginUser;
	// 세션에서 값 가져오기
	loginUser = (UserVO)session.getAttribute("loginUser");
	// 로그인 정보가 없으면 내보냄
	if( loginUser == null) {	/* <!-- 로그인 정보가 없음 --> */
		%>
		<script>
			alert('로그인이 필요합니다.');
			location.href='<%=request.getContextPath()%>/user/login.do'
		</script>
		
		<%

	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>library_board_view</title>
    <style>
        /* section 부분 시작 */
        section{
          flex-grow: 1;
          padding-bottom: 80px;
        }
        .library_title{/*h2 제목*/
            margin-left: 360px;
            padding-bottom: 10px;
            border-bottom: 2px solid black;
            width: 1200px;
        }
        .library_board_title{/*제목*/
            margin-left: 360px;
            font-size: 27px;
            padding-bottom: 5px;
        }
        .library_board{/*작성자 관리자 등록일 2024-10-22 조회수 33*/
            margin-left: 360px;
            font-size: 9px;
            padding-bottom: 15px;
            border-bottom: 1px solid black;
            width: 1200px;
        }
        .library_board_content{/*내용*/
            margin-left: 360px;
            font-size: 20px;
        }
        .library_board_file{/*첨부파일명*/
            margin-left: 360px;
            margin-top: 400px;
            font-size: 13px;
            border-top: 1px solid black;
            border-bottom: 1px solid black;
            width: 1200px;
            padding: 10px 0 10px 0;
        }
        .library_board_list_button{/*목록 버튼*/
            margin-left: 900px;
            margin-top: 30px;
        }
        .library_board_list_button button{
            text-decoration: none;
            width: 80px;
            height: 30px;
            border: none;
            border-radius:20px;
            cursor: pointer;
        }
        .library_board_list_button a{
            text-decoration: none;
            color: black;
        }
        .library_board_button{/*등록,취소 버튼*/
            margin-left: 1450px;
            margin-top: -25px;
        }
        .library_board_button button{
            border: none;
            border-radius:20px;
            width: 50px;
            height: 25px;
            cursor: pointer;
        }
        .library_board_button a{
            text-decoration: none;
            color: black;
        }
        /* section 부분 끝 */
    </style>
</head>
<body>
      <section>
        <h2 class="library_title">자료실 상세</h2>
       	<div class="library_board_title"><%=vo.getTitle() %></div>
       	<div class="library_board">작성자 <%=vo.getName() %> 등록일 <%=vo.getRdate() %> 조회수 <%=vo.getHit() %></div>
      		<div class="library_board_content"><%=vo.getContent().replaceAll("\n", "<br>") %>
      		<% if(vo.getNewFileName()!=null && !vo.getNewFileName().equals("")) {%>
      		<img src="../upload/<%=vo.getNewFileName()%>"> <!-- 이미지 일대만 게시글에 보이기 아니면 안보이게  -->
      		<%} %>
      		</div>
       	<div class="library_board_file">
       		<a href="../upload/<%=vo.getNewFileName()%>" download="<%= request.getContextPath() %>/upload/<%=vo.getOrgFileName() %>">
       			<%=vo.getOrgFileName() %>
       		</a>
       	</div><!-- 다운로드 할수 잇게 링크 입력 -->
        
        
        <div class="library_board_list_button">
            <button onclick="location.href='<%=request.getContextPath()%>/library/library_list.do'">목록</button>
        </div>
        <div class="library_board_button">
        
        <%
        if(loginUser != null && vo != null && loginUser.getUno() == vo.getUno()){%>
        	<button type="submit" onclick="location.href='<%=request.getContextPath()%>/library/library_modify.do?lno=<%= vo.getLno()%>'">수정</button>
			<button type="button" onclick="document.frm.submit();">삭제</button>
			<form name="frm" action="<%=request.getContextPath()%>/library/library_delete.do" method="post" >
	 			<input type="hidden" name="lno" value="<%=vo.getLno()%>">
	 		</form>
        <% }%>

        </div>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>