<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>강사상세</title>
    <style>
        .class_hr{
            border-top : 5px solid #007ACC;
            margin-bottom: 20px;
        }
        .course-list {
            width: 63%;
            margin: 0px auto;
            background-color: white;
            border-radius: 8px;
        }
        .first_content{
            display: flex;
            justify-content: space-between;
            
        }
        .cont_info{
            margin-left: 30px;
            font-size: 27px;
        }
        .cont_info ul{
            margin-right: 200px;
        }
        .second_title_hr{
            border-top : 5px solid #007ACC;
            margin-bottom: 20px;
        }
        .sub{
            font-weight: bold;
        }
        .sub a {
            text-decoration-line: none;
            color: black;
        }
        .meta-info{
            font-size: 14px;
            color: #9e9e9e;
        }
        .html, body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .html, body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body>
      <section class="course-list">
        <div class="first_title">
            <h1>강사 정보</h1>
            <div class="class_hr" style="width: 93%;"></div>
        </div>
        <div class="first_content">
            <img src="강사사진1.png">
            <div class="cont_info">
                <ul>
                    <li>용인 외대부고 졸업</li>
                    <li>서울대 의료기기산업학과 졸업</li>
                    <li>석사 이수</li>
                    <li>박사 이수</li>
                    <li>메가스터디 온라인 영어 대표강사</li>
                    <li>러셀 대치 영어 대표강사</li>
                </ul>
            </div>
        </div>
        <div>
            <h1>최신 강의</h1>
            <div class="second_title_hr" style="width: 93%;"></div>
        </div>
        <div >
            <span class="sub"><h2><a href=""> [수능특강] 한병훈의 국어 -화법과 작문 선택-</a></h2></span>
            <div class="meta-info"><span>수강인원 20/20</span></div>
            <hr>
        </div>
        <div>
            <span class="sub"><h2><a href="">[2025 수능특강] 최서희의 문학</a></h2></span>
            <div class="meta-info"><span>수강인원 10/20</span></div>
            <hr >
        </div>
      </section>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>