<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
    <style>
      html,body{
        margin: 0px;
        padding: 0px;
        background-color: #0081FF;
        display: flex;
        align-items: center; 
        justify-content: center; 
        width: 100%;   
        height: 100vh;
      }
      img{
        width: 250px;
        height: 150px;
        
      }
      .login_btn{
        width: 51%;
        height: 50px;
        border: 2px solid;
        background-color: #CEECF5;

      }
      .loginForm{
        background-color: white;
        padding: 40px 20px;
        width: 650px;
        height: 500px;
        text-align: center;
        border-radius: 4px;
      }
      input{
        width: 50%;
        height: 40px;
        border: 2px solid;
        box-shadow: 3px 3px 4px silver;
        margin-bottom: 20px;
      }



    </style>
</head>
<body>
	<div class="loginForm">
    <div>
      <a href="../../index.jsp"><img src="../img/로고시안흑백.PNG"></a>
      </div>
      <div><h2>로그인</h2></div>
    <form action="<%=request.getContextPath()%>/user/login.do" method="post">
      <div>
        <input type="text" name="id" placeholder="아이디를 입력해주세요">
      </div>
      <div>
        <input type="password" name="pw" placeholder="비밀번호를 입력해주세요">
      </div>
      <div>
        <input type="submit" value="로그인"  class="login_btn">
      </div>
    </form>
    <div style="margin-left: 260px;">
      <a href="<%=request.getContextPath()%>/user/join.do" >회원가입</a>
    </div>   
  </div>
</body>
</html>