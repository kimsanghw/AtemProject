<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script>
    function idCheck(){
        var id = $(".id")[0];
        var msgBox = $(".msgbox")[0];
        var idPattern =/^(?=.*[a-zA-Z])[a-zA-Z0-9]+$/;
        if( id.value.trim() == "" ){
            msgBox.innerHTML = "<span style='color:red'>아이디를 입력하세요</span>";
            return false;
        }else if( id.value.length < 4 ||  id.value.length >= 30  ) {
			        msgBox.innerHTML = "<span style='color:red'>아이디는 4글자 이상 30자 미만으로 입력하세요 </span>";
			        return false;
        }else if( !idPattern.test(id.value)){
          msgBox.innerHTML = "<span style='color:red'>아이디는 영문과 숫자만 가능합니다 </span>";
          return false;
        }else{
        	let value = $("#id").val();
			$.ajax({
				url : "/user/checkId.do",
				type : "get",
				data : "id=" +value,
				success : function(data) {
					if(data.trim() == "isid"){
						$(".msgbox:eq(0)").html("사용할 수 없는 아이디입니다.");	
						return false;
					}else {
						$(".msgbox:eq(0)").html("사용할수 있는 아이디입니다");
						return true;
						}
				}	
			});
			
        }
        
  }

  function pwCheck(){
        var pw = $(".pw")[0];
        var msgBox = $(".msgbox")[1];
        var pwPattern = /^(?=.*[a-zA-Z])[a-zA-Z0-9]+$/;
        if( pw.value.trim() == "" ){
            msgBox.innerHTML = "<span style='color:red'>비밀번호를 입력하세요</span>";
            return false;
        }else if( pw.value.length < 8 ) {
			        msgBox.innerHTML = "<span style='color:red'>비밀번호는 8자 이상 입력하세요</span>";
			        return false;
        }else if( !pwPattern.test(pw.value)){
            msgBox.innerHTML = "<span style='color:red'>비밀번호는 영문과 숫자만 입력하세요</span>";
            return false;
        }else{
          msgBox.innerHTML = "";
        }
        return true;
		}

  function pw2Check(){
        var pw2 = $(".pw2")[0];
        var msgBox = $(".msgbox")[2];
        var pw2Pattern =/^(?=.*[a-zA-Z])[a-zA-Z0-9]+$/;
        if( pw2.value.trim() == "" ){
            msgBox.innerHTML = "<span style='color:red'>비밀번호를 입력하세요</span>";
            return false;
        }else if( pw2.value.length < 8 ) {
			        msgBox.innerHTML = "<span style='color:red'>비밀번호는 8자 이상 입력하세요</span>";
			        return false;
        } else if( !pw2Pattern.test(pw2.value)){
            msgBox.innerHTML = "<span style='color:red'>비밀번호는 영문과 숫자만 입력하세요</span>";
            return false;
        }else{
          msgBox.innerHTML = "";
        }
        return true;
  }
  
  function pwMath(){
    var pw = $(".pw")[0];
    var pw2 = $(".pw2")[0];
    var msgBox = $(".msgbox")[3];
			if( pw.value != pw2.value )
			{
				msgBox.innerHTML = "<span style='color:red'>비밀번호가 일치하지 않습니다</span>";
				pw2.value = "";
				return false;
			}else {
      msgBox.innerHTML = "";
    }
    return true;
  }

<<<<<<< HEAD
  function nameCheck(){
        var name = $(".name")[0];
        var msgBox = $(".msgbox")[4];
        var namePattern = /^[가-힣]+$/;
        if( name.value.trim() == "" ){
            msgBox.innerHTML = "<span style='color:red'>이름을 입력하세요</span>";
            return false;
        }else if( name.value.length < 2 || !namePattern.test(name.value)) {
			        msgBox.innerHTML = "<span style='color:red'>이름은 2글자 이상 한글만 입력하세요</span>";
			        return false;
        }else{
          msgBox.innerHTML = "";
        }
        return true;
  }

  function emailCheck(){
        var emailPattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        var email = $(".email")[0];
        var msgBox = $(".msgbox")[5];
        if( email.value.trim() == "" ){
            msgBox.innerHTML = "<span style='color:red'>이메일을 입력하세요</span>";
            return false;
        }else if( !emailPattern.test(email.value) ) {
			        msgBox.innerHTML = "<span style='color:red'>유효한 이메일 주소를 입력하세요</span>";
			        return false;
        }else{
        	$.ajax({
                url: "/user/checkEmail.do",
                type: "get",
                data: { email },
                success: function(data) {
                  if(data.trim() === "isemail"){
                    msgBox.html("<span style='color:red'>사용할 수 없는 이메일입니다.</span>");
                    emailCheckFlag = false;
                  } else {
                    msgBox.html("<span style='color:green'>사용할 수 있는 이메일입니다</span>");
                    emailCheckFlag = true;
                  }
                }
              });
        }
       
  }
  function phoneCheck(){
        var phonePattern = /^\d{2,3}\d{3,4}\d{4}$/;
        var phone = $(".phone")[0];
        var msgBox = $(".msgbox")[6];
        if( phone.value.trim() == "" ){
            msgBox.innerHTML = "<span style='color:red'>연락처를 입력하세요</span>";
            return false;
        }else if( !phonePattern.test(phone.value)  || phone.value.length >12) {
			        msgBox.innerHTML = "<span style='color:red'>연락처를 올바르게 입력하세요</span>";
			        return false;
        }else{
          msgBox.innerHTML = "";
        }
        return true;
  }
  function DoJoin(){
		
		if(idCheck() == false) return false;
	
		if(pwCheck() == false) return false;
	
		if(pw2Check() == false) return false;
		
		if(pwMath() == false) return false;
		
		if(phoneCheck() == false) return false;
		
		if(nameCheck() == false) return false;
		
		if(emailCheck() == false) return false;

		
		if( confirm("회원가입을 진행하시겠습니까?") == false ) {
			return false;
		}else {
			return true;
		}
	}
   
=======
  
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
</script>
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
        width: 50%;
        height: 50px;
        border: 2px solid;
        background-color: #CEECF5;
      }
      .loginForm{
        background-color: white;
        padding: 40px 20px;
        width: 650px;
        height: 600px;
        text-align: center;
      }
      input{
        width: 50%;
        height: 30px;
        border: 2px solid;
        box-shadow: 3px 3px 4px silver;
        margin-bottom: 10px;
      }
      .join_btn{
        width: 330px;
        height: 50px;
        border: 2px solid;
        background-color: #CEECF5;
        margin-top: 50px;
      }
      .joinForm{
        background-color: white;
        padding: 40px 20px;
        width: 650px;
        height: 700px;
        text-align: center;
        border-radius: 4px;
      }
      /*회원가입*/
      div{
        text-align: center;
      }
      .msgbox{
        font-size: 12px;
      }

    </style>
</head>
<body>
	 <div class="joinForm">
    <div>
    <a href="idex.jsp"><img src="../img/로고시안흑백.PNG"></a>

    </div>
    <div><h2>회원가입</h2></div>
    <form action="<%=request.getContextPath() %>/user/join.do" method="post" onsubmit="return DoJoin();">
    <div>
      <input type="text" name="id"  class="id" onblur="idCheck();" placeholder="아이디를 입력해주세요">
    </div>
    <div>
      <input type="password" name="pw" class="pw"  onblur="pwCheck();"placeholder="비밀번호를 입력해주세요">
    </div>
    <div>
      <input type="password" name="pw2" class="pw2" onblur="if(pw2Check())pwMath();" placeholder="비밀번호를 다시 입력해주세요">
    </div>
    <div class="msgbox"></div>
    <div class="msgbox"></div>
    <div class="msgbox"></div>
    <div class="msgbox"></div>
    <div>
      <input type="text" name="name" class="name" onblur="nameCheck();"placeholder="이름을  입력해주세요">
    </div>
    <div>
      <input type="email" name="email" class="email" onblur="emailCheck();" placeholder="이메일을 입력해주세요">
    </div>
    <div>
      <input type="tel" name="phone" class="phone" onblur="phoneCheck();" placeholder="연락처를 입력하실때는 - 없이 입력해 주세요">
    </div>
    <div class="msgbox"></div>
    <div class="msgbox"></div>
    <div class="msgbox"></div>
    <div>
      <input type="submit" class="join_btn" value="회원가입">
    </div>
  </form>
</div>
</body>
</html>