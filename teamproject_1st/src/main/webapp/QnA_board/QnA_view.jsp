<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>free_board_view</title>
    <style>
    /* header 부분 시작*/
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
        /* header 부분 끝 */
        /* section 부분 시작 */
        section{
            width: 63%;
            margin: 0px auto;
            background-color: white;
            border-radius: 8px;
        }
        .free_title{
            border-bottom: 5px solid #007ACC;
        }
        .free_board{
            font-size: 9px;
        }
        .comment_title{
            border-bottom: 5px solid #007ACC;
        }
        .free_board_content{
            height: 300px;
        }
        .comment_input input{
            width: 1200px;
            height: 50px;
            outline: none;
            border: none;
        }
        .comment_button{
            text-align: right;
        }
        .mother {
            display: flex;
            justify-content: flex-end; /* 나머지 버튼들을 오른쪽에 정렬 */
            margin: 20px auto;
        }
        .center_button{
            flex: 1; 
            text-align: center; 
        }

        .delete_button{
            margin-left: 5px;
        }
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
    <header>
        <h1 class="index_logo headerSlide"><a href="#"><img src="로고1.png"></a></h1>
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
        <div class="free_title">
            <h2 >Q&A 상세</h2>
        </div>
        <div class="free_board_title">
            <div>
                <h3>첫 번째 제목입니다.</h3>
            </div>
            <div class="free_board">작성자 관리자 등록일 2024-10-22 조회수 33</div>
        </div>
        <hr>
        <div class="free_board_content">첫 번째 내용입니다.</div>
        <div>
            <div class="comment_title">
                <h3>댓글</h3>
            </div>
            <form>
                <div class="comment_input">
                    <input type="text" placeholder="댓글을 입력해주세요." name="comment_content">
                </div>
                <br>
                <div class="comment_view">
                    <div>첫번째 댓글입니다.</div>
                    <div class="comment_button">
                    <button type="submit">등록</button>
                    <button type="button">삭제</button>
                    </div>
                </div>
            </form>
        </div>
        <hr>
        <div class="free_board_file">등록된 첨부파일명.JPG</div>
        <hr>
        <div class="mother">
            <span class="center_button"><button>목록</button></span>
            <span><button class="register-btn">수정</button></span>
            <span class="delete_button" ><button class="register-btn">삭제</button></span>
            </div>
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
    </footer>
</body>
</html>