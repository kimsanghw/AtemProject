<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
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
            position: absolute;
            right: 70px;
            width: 45px;
        }
        .email_modify_back{
            position: absolute;
            right: 13px;
            width: 45px;
        }
        .mypage_email{
            margin-top: 15px;
            display: none;
        }
        .number_button_modify{
            position: relative;
            width: 45px;
        }
        .mypage_number{
            margin-top: 15px;
            display: none;
        }
        .mypage_class{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        /*ì¹ì ìì­ ë*/
        </style>
</head>
<body>
<%
	 	UserVO userId2 = null;
	 	userId2 = (UserVO)session.getAttribute("user");
	 	if( userId2 == null )
	 	{
	 		System.out.println("세션에 정보가 없습니다");
	 	}
%>
      <section>
        <div class="mypage">마이페이지</div>
        <div class="mypage_flex">
            <div class="mypage_mypage mypage_menu"><a href="#">마이페이지 ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_study mypage_menu"><a href="#">내 강의 목록 ></a></div>
            <div class="mypage_line"></div>
            <% if(userId2 != null) { 
            	String authorization = userId2.getAuthorization();
            	if("A".equals(authorization)) {
            %>
            <div class="mypage_admin mypage_menu" id="admin_page"><a href="#">관리자 페이지 ></a></div> <!-- ì´ëë¯¼ì¼ë¡ ë¡ê·¸ì¸ ì ë³´ì´ë divìì­-->
            <div class="mypage_line mypage_admin"></div>
            <% } 
            }
            %>
        </div>
        <div class="mypage_box mypage_flex">
            <div class="mypage_join">회원정보</div>
            <table border="1" class="mypage_border">
                <tbody>
<<<<<<< HEAD
                <%= userId2.getEmail() %>
                
=======
>>>>>>> branch 'main' of https://github.com/doroo-test-organization/1st.git
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
                            <form>
                                <div class="email_text_modify">
                                    <input type="text" placeholder="이메일을 입력해주세요." name="email_modify" class="mypage_email">
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
                            <form>
                                <div class="email_text_modify">
                                    <input type="text" placeholder="번호를 입력해주세요" name="number_modify" class="mypage_number">
                                    <button type="submit" class="email_modify_button mypage_number">수정</button>
                                    <button type="button" class="email_modify_back mypage_number" onclick="toggleNumberForm()">취소</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="mypage_class">수강중인 강의</div>
            <div></div>
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
</body>
</html>