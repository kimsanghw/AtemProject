<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
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
%>
      <section>
        <h2>강의 등록</h2>
        <div class="title_hr"></div>
        <div class="title">
        <form action="<%= request.getContextPath()%>/class/writer.do" method="POST" enctype="multipart/form-data">
        	<input type="hidden" name="uno" value="<%= userId2.getUno()%>">
            <input type="text" name="title" placeholder="제목을 입력하세요.">
	        </div>
	        <div class="content">
	            <div>
	                강사이름 <input  type="text" name="teacher_name">
	            </div>
	            <div >
	                과목
	                <select name="subject" id="subject">
	                    <option value="A">국어</option>
	                    <option value="B">수학</option>
	                    <option value="C">영어</option>
	                    <option value="D">사회 탐구</option>
	                    <option value="E">과학 탐구</option>
	                </select>
	            </div>
	            <div>수강 신청 기간 : <input type="date" name="jdate"> ~ <input type="date" name="jdate"></div>
	            <div>
	                강의 난이도 : <select name="diffcult">
	                <option value="상">상</option>
	                <option value="중">중</option>
	                <option value="하">하</option>
	                </select>
	            </div>
	            <div class="book_input">교재 <input type="text" name="book"></div>
	            <div>강의 기간 <input type="date" name="duringclass"> ~ <input type="date" name="duringclass"></div>
	        </div>
	        <div class="filse">
	            <hr>
	            <input type="file" name="attach" >
	            <hr> 
	        </div>
	        <div class="last_button">
	            <button>등록</button>
	        </div>
        </form>
      </section>
		<%@ include file="../../include/footer.jsp" %>
</body>
</html>