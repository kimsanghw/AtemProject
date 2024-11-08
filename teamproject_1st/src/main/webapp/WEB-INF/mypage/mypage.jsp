<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import ="FrontController.vo.UserVO" %>
<%@ page import ="FrontController.vo.ClassVO" %>
<%@ page import="FrontController.util.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        /*ì¹ì ìì­*/
        section {
            flex-grow: 1; /* ë¨ì ê³µê°ì ì°¨ì§íëë¡ ì¤ì  */
            padding-bottom: 80px;
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
        /*navë¶ë¶ ë*/
        .mypage_box{
            border: 2px solid gray;
            width: 930px;
            padding-bottom: 30px;
            border-radius: 20px;
            margin: -20px 0 0 -280px;
        }
        .mypage_flex{
            float: left;
        }
        .mypage_join{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_border{
            margin: 0 50px;
            width: 830px;
            border: none;
        }
        .mypage_border th{
            background-color: silver;
            width: 140px;
            border: 1px solid;
        }
        .mypage_border td{
            border: 1px solid;
        }
        .mypage_border tr{
            width: 200px;
            height: 50px;
        }
        .email_button_modify{
            position: relative;
            width: 45px;
        }
        .email_text_modify{
            position: relative;
            margin-top: 0; /* ê³µë°± ì ê±° */
        }
        .email_text_modify input{
            width: 250px;
            margin-top: 20px;
        }
        .email_modify_button{
            width: 45px;
        }
        .email_modify_back{
            width: 45px;
        }
        .mypage_email{
            margin-top: -17px;
            display: none;
        }
        .number_button_modify{
            width: 45px;
        }
        .mypage_number{
            display: none;
        }
        .mypage_class{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .email_modify_text{
        	display: none;
        }
        .number_modify_text{
        	display: none;
        }
		.course-item {
		    display: flex;
		    align-items: center;
		    margin: 20px 50px;
		    padding: 15px;
		    background-color: #e0f7da;
		    border-radius: 5px;
		}
		.course-item a{
			text-decoration-line: none;
			color: black;
		}
		.course-item img {
		    width: 100px;
		    height: 100px;
		    margin-right: 20px;
		}
        /*ì¹ì ìì­ ë*/
        </style>
</head>
<body>
      <section>
        <div class="mypage">마이페이지</div>
        <div class="mypage_flex">
            <div class="mypage_mypage mypage_menu"><a href="#">마이페이지 ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_study mypage_menu"><a href="<%=request.getContextPath()%>/mypage/mypage2.do">내 강의 목록 ></a></div>
            <div class="mypage_line"></div>
            <%
            
		 	UserVO userId2 = null;
		 	userId2 = (UserVO)session.getAttribute("user");
		 	if( userId2 == null )
		 	{
		 		System.out.println("세션에 정보가 없습니다");
		 	}
            
            if(userId2 != null)
            { 
            	String authorization = userId2.getAuthorization();
            	if("A".equals(authorization))
            	{
            %>
            <div class="mypage_admin mypage_menu" id="admin_page"><a href="<%=request.getContextPath()%>/mypage/mypage3.do">관리자 페이지 ></a></div> <!-- ì´ëë¯¼ì¼ë¡ ë¡ê·¸ì¸ ì ë³´ì´ë divìì­-->
            <div class="mypage_line mypage_admin"></div>
            <% } 
            }
            %>
        </div>
        <div class="mypage_box mypage_flex">
            <div class="mypage_join">회원정보</div>
            <table border="1" class="mypage_border">
                <tbody>

                    <tr class="mypage_tbody">
                        <th>아이디</th>
                        <td><%= userId2.getId() %></td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td><%= userId2.getName() %></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>
                            <%= userId2.getEmail() %>
                            <button class="email_button_modify" onclick="toggleEmailForm()">변경</button>
                            <form action="<%=request.getContextPath()%>/mypage/mypage.do" method="POST" onsubmit="return validateEmailForm()">
                                <div class="email_text_modify">
                                	<input type="hidden" name="action" value="modifyEmail">
                                    <input type="text" placeholder="이메일을 입력해주세요." name="email_modify" class="mypage_email">
                                    <div class="email_modify_text" id="emailError">34982347923479823</div>
                                    <button type="submit" class="email_modify_button mypage_email">수정</button>
                                    <button type="button" class="email_modify_back mypage_email" onclick="toggleEmailForm()">취소</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>
                            <%= userId2.getPhone() %>
                            <button class="number_button_modify" onclick="toggleNumberForm()">변경</button>
                            <form action="<%=request.getContextPath()%>/mypage/mypage.do" method="POST" onsubmit="return validatePhoneForm()">
                                <div class="email_text_modify">
                                	<input type="hidden" name="action" value="modifyPhone">
                                    <input type="text" placeholder="번호를 입력해주세요" name="number_modify" class="mypage_number">
                                    <div class="number_modify_text" id="phoneError">124124124124124</div>
                                    <button type="submit" class="email_modify_button mypage_number">수정</button>
                                    <button type="button" class="email_modify_back mypage_number" onclick="toggleNumberForm()">취소</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
            <% ClassVO enrolledClass = (ClassVO) request.getAttribute("enrolledClass"); %>
		<div class="mypage_class">수강중인 강의</div>
				<% if (enrolledClass != null) { %>
				    <div class="course-item">
				        <img src="<%=request.getContextPath()%>/upload/<%=enrolledClass.getNewFileName()%>">
				        <div class="course-info">
				            <a href="<%= request.getContextPath() %>/class/view.do?cno=<%= enrolledClass.getCno() %>">
				                <div><h2><%= enrolledClass.getTitle() %></h2></div>
				            </a>
				            <div class="class_info">
				                <p>난이도: <%= enrolledClass.getDifficult() %></p>
				                <p>강사: <%= enrolledClass.getName() %></p>
				                <p>강의 기간: <%= enrolledClass.getDuringclass() %></p>
				            </div>
				        </div>
				    </div>
				<% } else { %>
				    <p>현재 수강 중인 강의가 없습니다.</p>
				<% } %>

        </div>
      </section>
      <%@ include file="../../include/footer.jsp" %>
    <script>
        // ê¶íì ë°ë¥¸ ê´ë¦¬ì íì´ì§ ë³´ì´ê¸°
        const userRole = 'admin'; // ì¬ì©ì ê¶í (ì: 'admin' ëë 'user')

        function showAdminPage() {
            if (userRole === 'admin') {
                document.getElementById('admin_page').style.display = 'block';
            }
        }
        showAdminPage();

        function toggleEmailForm() { //ì´ë©ì¼ ë²í¼ ì´ë²¤í¸
            const emailFields = document.querySelectorAll('.mypage_email');
            emailFields.forEach(field => {
                field.style.display = field.style.display === 'none' || field.style.display === '' ? 'inline-block' : 'none';
            });
        }
        function toggleNumberForm() { //ì°ë½ì² ë²í¼ ì´ë²¤í¸
            const emailFields = document.querySelectorAll('.mypage_number');
            emailFields.forEach(field => {
                field.style.display = field.style.display === 'none' || field.style.display === '' ? 'inline-block' : 'none';
            });
        }
    </script>
    <script>
	    function validateEmailForm() {
	        const email = document.querySelector('input[name="email_modify"]').value;
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	        const emailError = document.getElementById('emailError');
	        
	        if (!emailRegex.test(email)) {
	            emailError.innerText = "유효한 이메일 주소를 입력해 주세요.";
	            emailError.style.display = 'block'; // 오류 메시지를 표시
	            emailError.style.color = 'red';
	            return false;
	        }
	        
	        emailError.innerText = ""; // 유효성 통과 시 에러 메시지 삭제
	        emailError.style.display = 'none'; // 오류 메시지 숨김
	        return true;
	    }
	
	    function validatePhoneForm() {
	        const phone = document.querySelector('input[name="number_modify"]').value;
	        const phoneRegex = /^[0-9]{10,11}$/; // 10~11자리의 숫자만 허용
	        const phoneError = document.getElementById('phoneError');
	        
	        if (!phoneRegex.test(phone)) {
	            phoneError.innerText = "유효한 연락처 번호를 입력해 주세요. (숫자 10~11자리)";
	            phoneError.style.display = 'block'; // 오류 메시지를 표시
	            phoneError.style.color = 'red';
	            return false;
	        }
	        
	        phoneError.innerText = ""; // 유효성 통과 시 에러 메시지 삭제
	        phoneError.style.display = 'none'; // 오류 메시지 숨김
	        return true;
	    }
	</script>
</body>
</html>