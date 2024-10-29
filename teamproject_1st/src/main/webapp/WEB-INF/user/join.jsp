<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script>
	function idCheck() {
		let id = $(".id").val();
		let msgBox = $(".msgbox").eq(0);
		let idPattern = /^(?=.*[a-zA-Z])[a-zA-Z0-9]{4,30}$/;
		let idCheckFlag = false;
		if(id.trim() === "") {
			msgBox.html("<span style='color:red'>아이디를 입력하세요</span>");
			return false;
		} else if(!idPattern.test(id)) {
			msgBox.html("<span style='color:red'>아이디는 4~30자의 영문과 숫자만 가능합니다</span>");
			return false;
		} else {
			$.ajax({
				url: "<%=request.getContextPath()%>/user/checkid.do?action=check",
				data: { id: id },
				type: "get",        
				success: function(data) {
				data = data.trim();
				console.log(data);
				if(data === "isid") {
					msgBox.html("<span style='color:red'>사용할 수 없는 아이디입니다.</span>");
					idCheckFlag = false;
				} else if(data === "isNotId") {
					msgBox.html("<span style='color:green'>사용할 수 있는 아이디입니다</span>");
					idCheckFlag = true;
				} else {
					msgBox.html("<span style='color:red'>서버 응답 오류: " + data + "</span>");
					console.log("Unexpected server response:", data);
					idCheckFlag = false;
				}
			},
				error: function(error) {
				console.error("AJAX error:", status, error);
				msgBox.html("<span style='color:red'>서버 통신 오류</span>");
				idCheckFlag = false;
				}
			});
		return idCheckFlag;
		}

	function pwCheck(){
		let pw = $(".pw").val();
		let msgBox = $(".msgbox").eq(1);
		let pwPattern = /^(?=.*[a-zA-Z])[a-zA-Z0-9]+$/;
		if(pw.trim() === ""){
			msgBox.html("<span style='color:red'>비밀번호를 입력하세요</span>");
			return false;
		} else if(pw.length < 8){  // .value 제거
			msgBox.html("<span style='color:red'>비밀번호는 8자 이상 입력하세요</span>");
			return false;
		} else if(!pwPattern.test(pw)){
			msgBox.html("<span style='color:red'>비밀번호는 영문과 숫자만 입력하세요</span>");
			return false;
		} else {
			msgBox.html("");
			return true;
		}
	}

	function pw2Check(){
		let pw = $(".pw").val();
		let pw2 = $(".pw2").val();
		let msgBox = $(".msgbox").eq(3);
		if(pw !== pw2){
			msgBox.html("<span style='color:red'>비밀번호가 일치하지 않습니다</span>");
			return false;
		} else {
			msgBox.html("");
			return true;
		}
	}

	function pwMath(){
		var pw = $(".pw")[0];
		var pw2 = $(".pw2")[0];
		var msgBox = $(".msgbox")[3];
		if( pw.value != pw2.value ){
			msgBox.innerHTML = "<span style='color:red'>비밀번호가 일치하지 않습니다</span>";
			pw2.value = "";
			return false;
		}else {
			msgBox.innerHTML = "";
		}
		return true;
	}
	
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

	function emailCheck(){
		let email = $(".email").val();
		let msgBox = $(".msgbox").eq(5);
		let emailPattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$/;
		if(email.trim() === ""){
			msgBox.html("<span style='color:red'>이메일을 입력하세요</span>");
			emailCheckFlag = false;
			return;
		} else if(!emailPattern.test(email)){
			msgBox.html("<span style='color:red'>유효한 이메일 주소를 입력하세요</span>");
			emailCheckFlag = false;
			return;
		} else {
			$.ajax({
				url: "<%=request.getContextPath()%>/user/checkEmail.do",
				type: "get",
				data: { email: email },
				success: function(data) {
					data = data.trim();
					console.log(data);
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

/*   function DoJoin(){
	  if(!idCheckFlag) {
	    alert("아이디를 확인하세요.");
	    return false;
	  }
	  if(!emailCheckFlag) {
	    alert("이메일을 확인하세요.");
	    return false;
	  }
	  if(!pwCheck()) {
	    alert("비밀번호를 확인하세요.");
	    return false;
	  }
	  if(!pw2Check()) {
	    alert("비밀번호 확인을 다시 해주세요.");
	    return false;
	  }
	  if(!nameCheck()) {
	    alert("이름을 확인하세요.");
	    return false;
	  }
	  if(!phoneCheck()) {
	    alert("전화번호를 확인하세요.");
	    return false;
	  }
	  return confirm("회원가입을 진행하시겠습니까?");
	} */



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