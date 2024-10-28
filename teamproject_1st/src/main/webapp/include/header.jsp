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
<<<<<<< HEAD
</style>
</head>
<body>

</body>
</html>
<title>attendance</title>
 <style>
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
    /*----------------------------------------------------------------section부분---------------------------------------*/
    .section {
      flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
      padding-bottom: 80px;
    }
    article{
      width: 1400px;
      margin:0px auto;
    }
    .article_inner{
      margin-left: 100px;
    }
    .content_inner{
      width: 86%;
    }
    .content_inner>*{
      width: 100%;
    }
    .content_inner form{
      height: 50px;
      padding-top: 20px;
    }
    .content_inner input{
      width: 70%;
    }
    .content_c {
      border-top: 3px solid black;
      border-bottom: 2px solid black;
      color: gray;
      margin-bottom: 40px;
    }
    .content_c h3 {
      color: black;
      font-size: 20px;
    }
    
    select{
      height: 25px;
      width: 90px;
      font-size: 20px;
      margin-top: 20px;
      margin-bottom: 20px;
    }
    .app_btn{/*버튼 css*/
      width: 90px;
      height: 30px;
      border: 2px solid;
      background-color: #CEECF5;
      margin-left: 700px;
      margin-bottom: 15px;
    }
    .app_btn a {/*버튼 안에 있는 a링크 */
      color: black;
    }
    .attendance_btn{
      width: 90px;
      height: 30px;
      border: 2px solid;
      background-color: #CEECF5;
      margin-left: 700px;
    }
    .attendance_btn1{
      width: 60px;
      height: 30px;
      border: 2px solid;
      background-color: #CEECF5;
      border-radius: 15px;
    }
    .today_date{
      margin-top: 15px;
      margin-bottom: 15px;
    }
     /*-----checkbox css부분*/
    input[type='checkbox'] {
      -webkit-appearance: none; 
      -moz-appearance: none; 
      appearance: none; 
      width: 13px;
      height: 13px;
      border: 1px solid #ccc; 
      border-radius: 50%;
      outline: none; 
      cursor: pointer;
    }

    input[type='checkbox']:checked {
      background-color: #111; 
      border: 3px solid #fff; 
      box-shadow: 0 0 0 1px #111; 
    }
    .button{
      text-align: right;
      margin-top: 30px;
    }
     /*테이블부분 css*/
    table{
      width: 100%;
      text-align: center;
      height: 475px;
      border-radius: 5px;
    }
    thead{/*테이블 thead색깔*/
      height: 40px; 
      font-size: 30px;
      background-color: #f7f7f7; 
      font-family: Lato;
    }
    td{
      width: 100px;
      font-size: 20px;
    }
    .check_button{
      margin-left: 7px;
    }
    /*----------------------------------------------------------페이징부분---------------------------------------*/
    .paging_inner{
      width: 80%;
      text-align: center;
      margin-bottom: 15px;
    }
    /*----------------------------------------------------------footer부분-----------------------------------------*/
    .index_footer{
      width: 100%;
      height: 150px;
      background-color:#0b70b9;
      margin-top: auto;
    }
    .footer_menu ul{
      display: flex;
      list-style-type: none;
      margin-left: 445px;
      padding-top: 25px;
    }
    .footer_menu li{
      margin: 0 0 0 20px;
      font-size: 15px;
    }
    .footer_menu a{
      text-decoration: none;
      color: white;
    }
    .footer_logo{
      margin-left: 350px;
      margin-top: -35px;
      float: left;
    }
    .footer_logo img{
      height: 100px;
    }
    .footer_address{
      display: flex;
    }
    .footer_address p{
      margin: 0 0 0 18px;
      font-size: 15px;
      color: white;
    }
    .footer_copy p{
      margin: 20px 0 0 505px;
      color: white;
    }
  
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
=======
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
