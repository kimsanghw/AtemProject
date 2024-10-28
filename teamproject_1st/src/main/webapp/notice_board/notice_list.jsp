<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>notice_board_list</title>
    <style>
        /* 내용 부분 시작*/
        section{
          flex-grow: 1;
          padding-bottom: 80px;
        }
        .notice_title{
          position: absolute;
          left: 50%;
          margin: 47px 0 0 -600px;
          padding: 0;
        }
        .table{
          position: absolute;
          left: 50%;
          margin: 140px 0 0 -600px;
          border: 0;
          border-collapse: collapse;
          text-align: center;
        }
        .table tbody td{
          height: 40px;
          border-left: none;
          border-right: none;
        }
        tbody td>a{
          text-decoration: none;
          color: black;
        }
        .table thead th{
          border-left: none;
          border-right: none;
        }
        .button{
          width: 80px;
          height: 30px;
          font-size: 15px;
          border: none;
          border-radius:20px;
          margin-top: 670px;
          margin-left: 1480px;
          cursor: pointer;
        }
        /* 내용 부분 끝 */
        </style>
</head>
<body>
    <header>
        <h1 class="index_logo headerSlide"><a href="#"><img src="./"></a></h1>
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
            <a href="#">로그인</a>　|　<a href="#">회원가입</a>
            <div class="index_logOut"><a href="#">로그아웃</a>　|　<a href="#">마이페이지</a></div> <!-- 로그인 시 나오는 div 영역 -->
        </div>
      </header>
      <section>
        <h2 class="notice_title">공지사항</h2>
        <table frame="void" border="1" class="table">
          <thead style="background-color: #f7f7f7;" height="45px">
            <tr>
              <th width="100">NO</th>
              <th width="850">제목</th>
              <th width="150">등록일</th>
              <th width="100">조회수</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
          </tbody>
        </table>
            <button class="button">등록</button>
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
          <div class="footer_logo"><img src="./로고1.png"></div>
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
<%@ include file="../include/footer.jsp" %>