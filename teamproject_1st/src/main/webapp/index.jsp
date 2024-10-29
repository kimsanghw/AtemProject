<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="FrontController.vo.UserVO" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- Link Swiper's CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<title>Insert title here</title>
<!-- Demo styles -->
  <style>
    /*슬라이드 영역*/
    html,body {
      position: relative;
      height: 100%;
    }
    body {
      background: #eee;
      font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
      font-size: 14px;
      color: #000;
      margin: 0;
      padding: 0;
    }
    header{
      background-color: skyblue;
      width: 100%;
      height: 140px;
    }
    .index_logo img{
        height: 100px;
    }
    .swiper {
      width: 100%;
      height: 100%;
    }
    .wallpaper img{
      height: 1130px;
    }
    /*slide1 영역*/
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
    .index_logo {
      position: absolute; /* Absolute로 변경 */
      bottom: 830px; /* 원하는 위치에 고정 (하단 기준으로 20px) */
      left: 50%;
      margin: 0 0 0 -600px;
      padding: 0;
    }
    .index_nav{
      position: absolute;
      bottom: 870px;
      margin: 0 0 0 400px;
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
    /*검색 영역*/
    .index_search input{
      font-size: 20px;
      text-align: center;
      position: absolute;
      width: 800px;
      height: 70px;
      bottom: 450px;
      left: 50%;
      margin: 0 0 0 -430px;
      border-radius: 10px;
    }
    .index_search input::placeholder{
      font-size: 25px;
      font-weight: 700;
      text-align: center;
    }
    .index_search_select{
      position: absolute;
      width: 100px;
      height: 75px;
      bottom: 450px;
      left: 50%;
      margin: 0 0 0 -430px;
      border-radius: 10px;
      z-index: 9999;
      font-size: 25px;
    }
    .index_search_button{
      border: 1px solid black;
      position: absolute;
      width: 100px;
      height: 75px;
      bottom: 450px;
      left: 50%;
      margin: 0 0 0 280px;
      border-radius: 10px;
      z-index: 9999;
      font-size: 25px;
      cursor: pointer;
    }
    /*검색 영역*/
    /*공지사항 영역*/
    .index_notice h2{
      position: absolute;
      top: 180px;
      left: 50%;
      margin: 50px 0 0 -600px;
      padding: 0;
    }
    .index_notice_content{
      font-size: 15px;
      font-weight: 500;
      position: absolute;
      top: 230px;
      left: 50%;
      margin: 50px 0 0 -600px;
      padding: 0;
    }
    .index_notice_content a{
      text-decoration: none;
      color: black;
    }
    .notice_content{
      overflow: hidden;
      width: 500px;
      white-space: nowrap; /* 줄바꿈을 하지 않음 */
      text-overflow: ellipsis; /* 말줄임표 사용 */
      display: block; /* block으로 설정해 말줄임표를 적용 */
    }
    .index_notice_line{
      border: 1px solid gray;
      margin-top: 13px;
      width: 500px;
      margin-bottom: 13px;
    }
    .index_notice_look{
      position: absolute;
      top: 190px;
      left: 50%;
      margin: 50px 0 0 -150px;
      padding: 0;
    }
    .index_notice_look a{
      text-decoration: none;
      color: black;
    }
    /*공지사항 영역*/
    /*자료실 영역*/
    .index_library h2{
      position: absolute;
      top: 450px;
      left: 50%;
      margin: 50px 0 0 -600px;
      padding: 0;
    }
    .index_library_content{
      font-size: 15px;
      font-weight: 500;
      position: absolute;
      top: 500px;
      left: 50%;
      margin: 50px 0 0 -600px;
      padding: 0;
    }
    .index_library_content a{
      text-decoration: none;
      color: black;
    }

    .library_content{
      overflow: hidden;
      width: 500px;
      white-space: nowrap; /* 줄바꿈을 하지 않음 */
      text-overflow: ellipsis; /* 말줄임표 사용 */
      display: block; /* block으로 설정해 말줄임표를 적용 */
    }
    .index_library_line{
      border: 1px solid gray;
      margin-top: 13px;
      width: 500px;
      margin-bottom: 13px;
    }
    .index_library_look{
      position: absolute;
      top: 460px;
      left: 50%;
      margin: 50px 0 0 -150px;
      padding: 0;
    }
    .index_library_look a{
      text-decoration: none;
      color: black;
    }
    /*자료실 영역*/
    /*포토 영역*/
    .index_photo p{
      border: 1px solid black;
      width: 250px;
      height: 250px;
      margin: 30px 0 0 30px;
      border-radius: 40px;
    }
    .index_photo img{
      border-radius: 40px;
      border: none;
    }
    .index_photo{
      display: flex;
      margin: 170px 0 0 950px;
    }
    /*포토 영역*/
    /*푸터 영역*/
    .index_footer{
      width: 100%;
      height: 150px;
      background-color: #0b70b9;
      position: absolute; /* 혹은 fixed */
      bottom: 0;
      left: 0;
    }
    .footer_menu ul{
      display: flex;
      list-style-type: none;
      margin-left: 445px;
      padding-top: 15px;
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
	 <!-- Swiper -->
	 <%
	 	UserVO userId = (UserVO) session.getAttribute("loginUser");
	 %>
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <div class="wallpaper"><img src="./img/common.png"></div>
        <div class="index_loginPage headerSlide">
        <% if(userId == null) { %>
            <a href="<%=request.getContextPath()%>/user/login.do">로그인</a>　|　<a href="<%=request.getContextPath()%>/user/join.do">회원가입</a>
        <% } else { %>
            <div class="index_logOut"><a href="<%=request.getContextPath()%>/user/logout.do">로그아웃</a>　|　<a href="<%=request.getContextPath()%>/mypage/mypage.do">마이페이지</a></div> <!-- 로그인 시 나오는 div 영역 -->
        <% } %>
          </div>
        <h1 class="index_logo headerSlide"><a href="<%=request.getContextPath()%>index.jsp"><img src="img/로고1.png"></a></h1>
        <div class="index_nav headerSlide">
          <ul>
            <li><a href="#">수강신청</a></li>
            <% if(userId == null || a) { %>
            <li><a href="#">출결정보</a></li>
            <li><a href="#">출결관리</a></li>
            <li><a href="#">공지사항</a></li>
            <li><a href="#">QnA</a></li>
            <li><a href="#">자료실</a></li>
          </ul>
        </div>
        <form action="#">
          <div class="index_search">
            <select class="index_search_select" name="indexSearch">
              <option value="title">제목</option>
              <option value="content">내용</option>
            </select>
            <input type="text" placeholder="검색어를 입력해주세요" name="index_search_input" >
          </div>
          <button class="index_search_button" type="submit">검색</button>
        </form>
      </div>
      <div class="swiper-slide">
        <div class="index_slide2_header">
          <div class="index_loginPage headerSlide">
            <% if(userId == null) { %>
            <a href="<%=request.getContextPath()%>/user/login.do">로그인</a>　|　<a href="<%=request.getContextPath()%>/user/join.do">회원가입</a>
        <% } else { %>
            <div class="index_logOut"><a href="<%=request.getContextPath()%>/user/logout.do">로그아웃</a>　|　<a href="<%=request.getContextPath()%>/mypage/mypage.do">마이페이지</a></div> <!-- 로그인 시 나오는 div 영역 -->
        <% } %>
          </div>
          <h1 class="index_logo headerSlide"><a href="<%=request.getContextPath()%>index.jsp"><img src="img/로고1.png"></a></h1>
          <div class="index_nav headerSlide">
            <ul>
              <li><a href="#">수강신청</a></li>
              <li><a href="#">출결관리</a></li>
              <li><a href="#">공지사항</a></li>
              <li><a href="#">QnA</a></li>
              <li><a href="#">자료실</a></li>
            </ul>
          </div>
          <div class="index_notice">
            <h2>공지사항</h2>
            <div class="index_notice_look"><a href="#">+ 더보기</a></div>
            <div class="index_notice_content">
              <div>
                <div class="notice_content"><a href="#">뭔가 css하기싫은데 해야될 것 같은 느낌11111111111111111111111111111111111111</a></div>
                <div class="index_notice_line"><!--라인--></div>
                <div class="notice_content"><a href="#">아 진짜 너무 하기싫은데 아 너무 귀찮아</a></div>
                <div class="index_notice_line"><!--라인--></div>
                <div class="notice_content"><a href="#">그래도 해야겠지? 어쩌겠어 취업해야지</a></div>
                <div class="index_notice_line"><!--라인--></div>
              </div>
            </div>
          </div>
          <div class="index_library">
            <h2>자료실</h2>
            <div class="index_library_look"><a href="#">+ 더보기</a></div>
            <div class="index_library_content">
              <div>
                <div class="library_content"><a href="#">뭔가 css하기싫은데 해야될 것 같은 느낌11111111111111111111111111111111111111</a></div>
                <div class="index_library_line"><!--라인--></div>
                <div class="notice_content"><a href="#">아 진짜 너무 하기싫은데 아 너무 귀찮아asdsadsadadsadsadasdsadasdsadasdasdasd</a></div>
                <div class="index_library_line"><!--라인--></div>
                <div class="notice_content"><a href="#">그래도 해야겠지? 어쩌겠어 취업해야지</a></div>
                <div class="index_library_line"><!--라인--></div>
              </div>
            </div>
          </div>
          <div class="index_photo">
            <div>
              <p><a href="#"><img src="img/선생1.png"></a></p>
              <p><a href="#"><img src="img/선생2.png"></a></p>
            </div>
            <div>
              <p><a href="#"><img src="img/선생3.png"></a></p>
              <p><a href="#"><img src="img/선생4.png"></a></p>
            </div>
          </div>
          <div class="index_footer">
            <div class="footer_menu">
              <ul>
                  <li><a href="#">회사소개</a></li>
                  <li><a href="#">이용약관</a></li>
                  <li><a href="#">개인정보처리방침</a></li>
                  <li><a href="#">청소년 보호정책</a></li>
              </ul>
          </div>
          <div class="footer_logo"><img src="img/로고1.png"></div>
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
      </div>
    </div>
  </div>
  
  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper(".mySwiper", {
      direction: "vertical",
      slidesPerView: 1,
      spaceBetween: 30,
      mousewheel: true,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    });
  </script>
</body>
</html>