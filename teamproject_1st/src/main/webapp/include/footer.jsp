<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	        /* footer 부분 시작 */
        section {
            flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
            padding-bottom: 80px;
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
        /* footer 부분 끝 */
</style>
</head>
<body>
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
          <div class="footer_logo"><img src="로고시안.png"></div>
          <div class="footer_address">
              <p>(54930)전북특별자치도 전주시 덕진구 백제대로 572 4층</p>
              <p>대표번호 : 063-276-2381</p>
              <p>문의시간 : 09:00~18:00 (월~금)</p>
          </div>
          <div class="footer_copy">
              <p>Copyright © ezen Corp. All rights reserved.</p>
          </div>
      </div>
    </footer>
</body>
</html>