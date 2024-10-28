<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	        /* header 부분 시작*/
        html, body {
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    header{
        background-color: #0b70b9;
        width: 100%;
        height: 140px;
    }
    .index_loginPage{
        position: absolute;
        left: 50%;
        top: 0px;
        width: 600px;
        text-align: right;
        line-height: 1.1;
        padding: 22px 0 0 0;
    }
    .index_loginPage a{
        font-size: 15px;
        text-decoration: none;
        color: white;
        font-weight: 800px;
    }
    .index_logOut{
        display: none;
    }
    .index_logo {
      position: absolute; /* Absolute로 변경 */
      left: 50%;
      margin: 25px 0 0 -600px;
      padding: 0;
    }
    .index_logo img{
        height: 100px;
    }
    
    .index_nav{
      position: absolute;
      margin: 47px 0 0 400px;
    }
    .index_nav li{
      display: block;
      float: left;
      margin: 0 0 0 120px;
      font-size: 22px;
      color: white;
      font-weight: 900;
    }
    .index_nav a{
      text-decoration: none;
      color: white;
    }
        /* header 부분 끝 */
</style>
</head>
<body>
    <header>
        <h1 class="index_logo headerSlide"><a href="<%=request.getContextPath()%>index.jsp"><img src="/TimeProject/img/로고1.png"></a></h1>
      <div class="index_nav headerSlide">
        <ul>
          <li><a href="#">수강신청</a></li>
          <li><a href="<%=request.getContextPath()%>/attendance/attendanceList.do">출결관리</a></li>
          <li><a href="#">공지사항</a></li>
          <li><a href="#">QnA</a></li>
          <li><a href="#">자료실</a></li>
        </ul>
      </div>
      <div class="index_loginPage headerSlide">
        <a href="<%=request.getContextPath()%>/user/login.do">로그인</a>　|　<a href="<%=request.getContextPath()%>/user/join.do">회원가입</a>
        <div class="index_logOut"><a href="#">로그아웃</a>　|　<a href="#">마이페이지</a></div> <!-- 로그인 시 나오는 div 영역 -->
      </div>
      </header>

