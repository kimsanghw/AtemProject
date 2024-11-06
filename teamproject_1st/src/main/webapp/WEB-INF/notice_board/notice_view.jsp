<%@page import="FrontController.vo.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

<%
	NoticeVO vo = (NoticeVO)request.getAttribute("vo");
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
    <title>notice_board_view</title>
    <style>
        /* section 부분 시작 */
        section{
          flex-grow: 1;
          padding-bottom: 80px;
        }
        .notice_title{/*h2 제목*/
            margin-left: 360px;
            padding-bottom: 10px;
            border-bottom: 2px solid black;
            width: 1200px;
        }
        .notice_board_title{/*제목*/
            margin-left: 360px;
            font-size: 27px;
            padding-bottom: 5px;
        }
        .notice_board{/*작성자 관리자 등록일 2024-10-22 조회수 33*/
            margin-left: 360px;
            font-size: 9px;
            padding-bottom: 15px;
            border-bottom: 1px solid black;
            width: 1200px;
        }
        .notice_board_content{/*내용*/
            margin-left: 360px;
            font-size: 20px;
        }
        .notice_board_file{/*첨부파일명*/
            margin-left: 360px;
            margin-top: 400px;
            font-size: 13px;
            border-top: 1px solid black;
            border-bottom: 1px solid black;
            width: 1200px;
            padding: 10px 0 10px 0;
        }
        .notice_board_list_button{/*목록 버튼*/
            margin-left: 900px;
            margin-top: 30px;
        }
        .notice_board_list_button button{
            text-decoration: none;
            width: 80px;
            height: 30px;
            border: none;
            border-radius:20px;
            cursor: pointer;
        }
        .notice_board_list_button a{
            text-decoration: none;
            color: black;
        }
        .notice_board_button{/*등록,취소 버튼*/
            margin-left: 1450px;
            margin-top: -25px;
        }
        .notice_board_button button{
            border: none;
            border-radius:20px;
            width: 50px;
            height: 25px;
            cursor: pointer;
        }
        .notice_board_button a{
            text-decoration: none;
            color: black;
        }
        /* section 부분 끝 */
    </style>
</head>
<body>
      <section>
        <h2 class="notice_title">공지사항 상세</h2>
        <div class="notice_board_title"><%=vo.getTitle() %></div>
        <div class="notice_board">작성자 <%=vo.getName() %> 등록일 <%=vo.getRdate() %> 조회수 <%=vo.getHit() %></div>
        <div class="notice_board_content"><%=vo.getContent() %></div>
        <div class="notice_board_list_button">
            <button onclick="location.href='<%=request.getContextPath()%>/notice/notice_list.do'">목록</button>
        </div>
        <div class="notice_board_button">
        
        <%
        if(loginUser != null && vo != null && loginUser.getUno() == vo.getUno()){%>
        	<button type="submit" onclick="location.href='<%=request.getContextPath()%>/notice/notice_modify.do?nno=<%= vo.getNno()%>'">수정</button>
        	<button type="button" onclick="document.frm.submit();">삭제</button>
        	<form name="frm" action="<%=request.getContextPath()%>/notice/notice_delete.do" method="post" >
	 			<input type="hidden" name="nno" value="<%=vo.getNno()%>">
	 		</form>
        <%}%>
        
            
            
        </div>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>