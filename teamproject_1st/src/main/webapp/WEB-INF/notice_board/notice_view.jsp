<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>notice_board_view</title>
    <style>
        /* section 부분 시작 */
        section{
          flex-grow: 1;
          padding-bottom: 80px;
        }
        .notice_title{/*h2 제목*/
            margin-left: 360px;
            padding-bottom: 10px;
            border-bottom: 2px solid black;
            width: 1200px;
        }
        .notice_board_title{/*제목*/
            margin-left: 360px;
            font-size: 27px;
            padding-bottom: 5px;
        }
        .notice_board{/*작성자 관리자 등록일 2024-10-22 조회수 33*/
            margin-left: 360px;
            font-size: 9px;
            padding-bottom: 15px;
            border-bottom: 1px solid black;
            width: 1200px;
        }
        .notice_board_content{/*내용*/
            margin-left: 360px;
            font-size: 20px;
        }
        .notice_board_file{/*첨부파일명*/
            margin-left: 360px;
            margin-top: 400px;
            font-size: 13px;
            border-top: 1px solid black;
            border-bottom: 1px solid black;
            width: 1200px;
            padding: 10px 0 10px 0;
        }
        .notice_board_list_button{/*목록 버튼*/
            margin-left: 900px;
            margin-top: 30px;
        }
        .notice_board_list_button button{
            text-decoration: none;
            width: 80px;
            height: 30px;
            border: none;
            border-radius:20px;
            cursor: pointer;
        }
        .notice_board_list_button a{
            text-decoration: none;
            color: black;
        }
        .notice_board_button{/*등록,취소 버튼*/
            margin-left: 1450px;
            margin-top: -25px;
        }
        .notice_board_button button{
            border: none;
            border-radius:20px;
            width: 50px;
            height: 25px;
            cursor: pointer;
        }
        .notice_board_button a{
            text-decoration: none;
            color: black;
        }
        /* section 부분 끝 */
    </style>
</head>
<body>
      <section>
        <h2 class="notice_title">공지사항 상세</h2>
        <div class="notice_board_title">첫 번째 제목입니다.</div>
        <div class="notice_board">작성자 관리자 등록일 2024-10-22 조회수 33</div>
        <div class="notice_board_content">첫 번째 내용입니다.</div>
        <div class="notice_board_file">등록된 첨부파일명.JPG</div>
        <div class="notice_board_list_button">
            <button><a href="#">목록</a></button>
        </div>
        <div class="notice_board_button">
            <button type="submit"><a href="#">등록</a></button>
            <button type="button">취소</button>
        </div>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>