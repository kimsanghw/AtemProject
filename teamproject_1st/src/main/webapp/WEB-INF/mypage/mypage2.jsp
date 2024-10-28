<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        /*헤더 부분 시작*/
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
        /*헤더 부분 끝*/
        /*nav 부분 시작*/
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
        /*nav 부분 끝*/
        /*섹션 부분 시작*/
        section {
            flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
            padding-bottom: 80px;
        }
        .mypage_box{
            border: 2px solid gray;
            width: 930px;
            border-radius: 20px;
            margin: -20px 0 0 -280px;
            padding-bottom: 30px;
        }
        .mypage_flex{
            float: left;
        }
        .mypage_class_start{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_start_subject{
            border: 1px solid black;
            width: 800px;
            height: 80px;
            margin-left: 50px;
        }
        .mypage_class_end{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_end_subject{
            border: 1px solid black;
            width: 800px;
            height: 80px;
            margin-left: 50px;
        }
        .mypage_class_back{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_back_subject{
            border: 1px solid black;
            width: 800px;
            height: 80px;
            margin-left: 50px;
        }
        /*섹션 부분 끝*/
        /*푸터 부분 시작*/
        .html, body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .index_footer{
            width: 100%;
            height: 150px;
            background-color: #0b70b9;
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
        /*푸터 부분 끝*/
    </style>
</head>
<body>
    <header>
        <h1 class="index_logo headerSlide"><a href="index.html"><img src="로고1.png"></a></h1>
      <div class="index_nav headerSlide">
        <ul>
          <li><a href="#">수강신청</a></li>
          <li><a href="#">출결관리</a></li>
          <li><a href="#">공지사항</a></li>
          <li><a href="#">QnA</a></li>
          <li><a href="#">자료실</a></li>
        </ul>
      </div>
      <div class="index_loginPage headerSlide">
        <div class="index_login"><a href="#">로그인</a>　|　<a href="#">회원가입</a></div>
        <div class="index_logOut"><a href="#">로그아웃</a>　|　<a href="#">마이페이지</a></div> <!-- 로그인 시 나오는 div 영역 -->
      </div>
      </header>
      <section>
        <div class="mypage">마이페이지</div>
        <div class="mypage_flex">
            <div class="mypage_mypage mypage_menu"><a href="#">마이페이지 ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_study mypage_menu"><a href="#">내 강의 목록 ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_admin mypage_menu" id="admin_page"><a href="#">관리자 페이지 ></a></div> <!-- 어드민으로 로그인 시 보이는 div영역-->
            <div class="mypage_line mypage_admin"></div>
        </div>
        <div class="mypage_box mypage_flex">
            <div class="mypage_class_start">수강 중 강의</div>
            <div class="mypage_start_subject"></div>
            <div class="mypage_class_end">수강 종료된 강의</div>
            <div class="mypage_end_subject"></div>
            <div class="mypage_class_back">수강 취소한 강의</div>
            <div class="mypage_back_subject"></div>
        </div>
        </section>
        <footer>
            <div class="index_footer">
                <div class="footer_menu">
                    <ul>
                        <li><a href="#">회사소개</a></li>
                        <li><a href="#">이용약관</a></li>
                        <li><a href="#">개인정보처리방침</a></li>
                        <li><a href="#">청소년 보호정책</a></li>
                    </ul>
                </div>
                <div class="footer_logo"><img src="로고1.png"></div>
                <div class="footer_address">
                    <p>(54930)전북특별자치도 전주시 덕진구 백제대로 572 4층</p>
                    <p>대표번호 : 063-276-2381</p>
                    <p>문의시간 : 09:00~18:00 (월~금)</p>
                </div>
                <div class="footer_copy">
                    <p>Copyright © ezen Corp. All rights reserved.</p>
                </div>
              </div>
            </div>
        </footer>
        <script>
            // 권한에 따른 관리자 페이지 보이기
            const userRole = 'admin'; // 사용자 권한 (예: 'admin' 또는 'user')

            function showAdminPage() {
                if (userRole === 'admin') {
                    document.getElementById('adminPage').style.display = 'block';
                }
            }
        showAdminPage();
        </script>
</body>
</html>