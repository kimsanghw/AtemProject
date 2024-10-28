<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>library_board_write</title>
    <style>
        /* section 부분 시작 */
        section{
          flex-grow: 1;
          padding-bottom: 80px;
          position: relative;
        }
        form{
            position: absolute;
            left: 965px;
        }
        .library_title{
          position: absolute;
          left: 50%;
          margin: 47px 0 0 -600px;
          padding: 0;
        }
        .library_title_write input{
            position: absolute;
            left: 50%;
            margin: 120px 0 0 -600px;
            border-left: none;
            border-right: none;
            outline: none; /*input 박스 눌러도 세로선 x*/
            width: 1200px;
            height: 45px;
        }
        .library_body_write textarea{
            position: absolute;
            left: 50%;
            margin: 190px 0 0 -600px;
            height: 350px;
            width: 1200px;
            border-bottom: 2px solid gray;
            border-left: none;
            border-right: none;
            border-top: none;
            outline: none;
        }
        .library_board_file{
            width: 100px;
            position: absolute;
            left: 50%;
            top: 550px;
            left: 530px;
            padding-bottom: 10px;
        }
        .library_board_line{
            top: 580px;
            left: 365px;
            position: absolute;
            border: 1px solid gray;
            width: 1200px;
        }
        .library_board_button{
            position: absolute;
            top: 600px;
            left: 500px;
            width: 80px;
            height: 30px;
            font-size: 15px;
            border: none;
            border-radius:20px;
            display: flex;
            width: 120px;
        }
        .library_board_button button{
            margin-left: 10px;
            border: none;
            border-radius:10px;
            cursor: pointer;
        }
        .box{
            position: absolute;
            border: 1px solid black;
            width: 600px;
            height: 30px;
            top: 550px;
            right: 0;
            overflow: hidden;
            border: none;
            text-overflow: ellipsis;
        }
        /* section 부분 끝 */
    </style>
</head>
<body>
    <header>
        <h1 class="index_logo headerSlide"><a href="#"><img src="./로고1.png"></a></h1>
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
        <h2 class="library_title">자료실 등록</h2>
        <form action="">
            <div class="library_title_write">
                <input type="text" placeholder="제목을 입력해주세요." name="title">
            </div>
            <div class="library_body_write">
                <textarea name="content" placeholder="내용을 입력해주세요."></textarea>
            </div>
            <div class="box">asfafaseqfkewqkf.jpg</div>
            <div class="library_board_file">
                <button>첨부파일</button>
            </div>
            <div class="library_board_button">
                <button type="submit">등록</button>
                <button type="button">취소</button>
            </div>
        </form>
        <div class="library_board_line"></div>
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