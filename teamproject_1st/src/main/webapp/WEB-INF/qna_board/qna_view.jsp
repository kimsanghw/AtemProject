<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>free_board_view</title>
    <style>
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
    </style>
</head>
<body>
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
</body>
</html>
<%@ include file="../../include/footer.jsp" %>