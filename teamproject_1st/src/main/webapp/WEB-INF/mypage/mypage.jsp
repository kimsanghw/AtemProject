<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
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
            position: absolute;
            margin-left: 428px;
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
            position: absolute;
            margin-left: 506px;
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
<%@ include file="../include/footer.jsp" %>
        </style>
</head>
<body>
    <header>
        <h1 class="index_logo headerSlide"><a href="index.html"><img src="ë¡ê³ 1.png"></a></h1>
      <div class="index_nav headerSlide">
        <ul>
          <li><a href="#">ìê°ì ì²­</a></li>
          <li><a href="#">ì¶ê²°ê´ë¦¬</a></li>
          <li><a href="#">ê³µì§ì¬í­</a></li>
          <li><a href="#">QnA</a></li>
          <li><a href="#">ìë£ì¤</a></li>
        </ul>
      </div>
      <div class="index_loginPage headerSlide">
        <div class="index_login"><a href="#">ë¡ê·¸ì¸</a>ã|ã<a href="#">íìê°ì</a></div>
        <div class="index_logOut"><a href="#">ë¡ê·¸ìì</a>ã|ã<a href="#">ë§ì´íì´ì§</a></div> <!-- ë¡ê·¸ì¸ ì ëì¤ë div ìì­ -->
      </div>
      </header>
      <section>
        <div class="mypage">ë§ì´íì´ì§</div>
        <div class="mypage_flex">
            <div class="mypage_mypage mypage_menu"><a href="#">ë§ì´íì´ì§ ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_study mypage_menu"><a href="#">ë´ ê°ì ëª©ë¡ ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_admin mypage_menu" id="admin_page"><a href="#">ê´ë¦¬ì íì´ì§ ></a></div> <!-- ì´ëë¯¼ì¼ë¡ ë¡ê·¸ì¸ ì ë³´ì´ë divìì­-->
            <div class="mypage_line mypage_admin"></div>
        </div>
        <div class="mypage_box mypage_flex">
            <div class="mypage_join">íìì ë³´</div>
            <table border="1" class="mypage_border">
                <tbody>
                    <tr class="mypage_tbody">
                        <th>ìì´ë</th>
                        <td>qortmddn567</td>
                    </tr>
                    <tr>
                        <th>ì´ë¦</th>
                        <td>ë°±ì¹ì°</td>
                    </tr>
                    <tr>
                        <th>ì´ë©ì¼</th>
                        <td>
                            qortmddn567@naver.com
                            <button class="email_button_modify" onclick="toggleEmailForm()">ë³ê²½</button>
                            <form>
                                <div class="email_text_modify">
                                    <input type="text" placeholder="ì´ë©ì¼ì ìë ¥í´ì£¼ì¸ì." name="email_modify" class="mypage_email">
                                    <button type="submit" class="email_modify_button mypage_email">ìì </button>
                                    <button type="button" class="email_modify_back mypage_email" onclick="toggleEmailForm()">ì·¨ì</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <th>ì°ë½ì²</th>
                        <td>
                            010-4197-2216
                            <button class="number_button_modify" onclick="toggleNumberForm()">ë³ê²½</button>
                            <form>
                                <div class="email_text_modify">
                                    <input type="text" placeholder="ì°ë½ì²ë¥¼ ìë ¥í´ì£¼ì¸ì." name="number_modify" class="mypage_number">
                                    <button type="submit" class="email_modify_button mypage_number">ìì </button>
                                    <button type="button" class="email_modify_back mypage_number" onclick="toggleNumberForm()">ì·¨ì</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="mypage_class">ìê°ì¤ì¸ ê°ì</div>
            <div></div>
        </div>
      </section>
    <footer>
      <div class="index_footer">
        <div class="footer_menu">
            <ul>
                <li><a href="#">íì¬ìê°</a></li>
                <li><a href="#">ì´ì©ì½ê´</a></li>
                <li><a href="#">ê°ì¸ì ë³´ì²ë¦¬ë°©ì¹¨</a></li>
                <li><a href="#">ì²­ìë ë³´í¸ì ì±</a></li>
            </ul>
        </div>
        <div class="footer_logo"><img src="ë¡ê³ 1.png"></div>
        <div class="footer_address">
            <p>(54930)ì ë¶í¹ë³ìì¹ë ì ì£¼ì ëì§êµ¬ ë°±ì ëë¡ 572 4ì¸µ</p>
            <p>ëíë²í¸ : 063-276-2381</p>
            <p>ë¬¸ììê° : 09:00~18:00 (ì~ê¸)</p>
        </div>
        <div class="footer_copy">
            <p>Copyright Â© ezen Corp. All rights reserved.</p>
        </div>
      </div>
    </footer>
    <script>
        // ê¶íì ë°ë¥¸ ê´ë¦¬ì íì´ì§ ë³´ì´ê¸°
        const userRole = 'admin'; // ì¬ì©ì ê¶í (ì: 'admin' ëë 'user')

        function showAdminPage() {
            if (userRole === 'admin') {
                document.getElementById('adminPage').style.display = 'block';
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