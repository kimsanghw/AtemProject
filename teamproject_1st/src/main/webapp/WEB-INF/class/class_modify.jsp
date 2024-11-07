<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import ="FrontController.vo.ClassVO" %>
<%@ page import ="FrontController.vo.UserVO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
	    section{
        margin: 0px auto;
        width: 64%;
    }
    .title_hr{
        border-top : 5px solid #007ACC;
        margin-bottom: 10px;
    }
    .title input{
        width: 1300px;
        outline: none;
        border: 0;
    }
    .title{
        border-bottom : 5px solid #007ACC;
        margin-bottom: 10px;
        padding-bottom: 10px;
    }
    .content {
        display: flex;
        flex-direction: column; /* 상하로 배치 */
        justify-content: center;
        align-items: flex-start; /* 왼쪽 정렬 */
        height: auto; /* 높이 자동 조정 */
        gap: 20px; /* 상하 간격 */
    }
    .content div {
        width: 100%; /* 각 요소가 가로 전체 차지 */
        margin: 10px 0; /* 상하 여백 추가 */
    }
    .book_input input{
        width: 500px;
    }
    .files {
        display: flex; /* Flexbox로 변경 */
        justify-content: flex-end; /* 내부 요소를 오른쪽 정렬 */
        align-items: center; /* 수직 중앙 정렬 */
        margin-top: 10px;
    }

    .last_button {
        text-align: right; /* 등록 버튼을 오른쪽 정렬 */
    }
    </style>
</head>
<body>
<%
	UserVO userId2 = null;
	userId2 = (UserVO)session.getAttribute("loginUser");
 	if( userId2 == null )
 	{
 		System.out.println("세션에 정보가 없습니다");
 	}
 	ClassVO vo = (ClassVO)request.getAttribute("vo");
 	
%>
      <section>
        <h2>강의 수정</h2>
        <div class="title_hr"></div>
        <div class="title">
        <form action="<%= request.getContextPath()%>/class/modify.do" method="POST" enctype="multipart/form-data">
        	<input type="hidden" name="uno" value="<%= userId2.getUno()%>">
        	<input type="hidden" name="cno" value="<%= vo.getCno()%>">
            <input type="text" name="title" value="<%=vo.getTitle()%>">
	        </div>
	        <div class="content">
	            <div>
	                강사이름 <input  type="text" name="name" value="<%=vo.getName()%>">
	            </div>
	            <div >
	                과목
	                <select name="subject" id="subject">
	                    <option value="국어">국어</option>
	                    <option value="수학">수학</option>
	                    <option value="영어">영어</option>
	                    <option value="사회탐구">사회 탐구</option>
	                    <option value="과학탐구">과학 탐구</option>
	                </select>
	            </div>
	            <div>수강 신청 기간 : <input type="date" name="jdate"> ~ <input type="date" name="end_jdate"></div>
	            <div>
	                강의 난이도 : <select name="difficult">
	                <option value="상">상</option>
	                <option value="중">중</option>
	                <option value="하">하</option>
	                </select>
	            </div>
	            <div class="book_input">교재 <input type="text" name="book" value="<%=vo.getBook()%>"></div>
	            <div>강의 기간 <input type="date" name="duringclass"> ~ <input type="date" name="end_duringclass"></div>
	            <div>강의 시작 시간 <input type="datetime-local" name="class_start"> 강의 종료 시간 <input type="datetime-local" name="class_late"></div><!-- 9시 10분 -->
	        </div>
	        <div class="filse">
	            <hr>
	            <input type="file" name="attach" >
	            <hr> 
	        </div>
	        <div class="last_button">
	            <button>수정</button>
	        </div>
        </form>
      </section>
		<%@ include file="../../include/footer.jsp" %>
</body>
</html>