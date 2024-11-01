<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="FrontController.vo.ClassVO" %>
<%@ page import ="java.util.*" %>
<%@ include file="../../include/header.jsp" %>
<%
	ClassVO vo = (ClassVO)request.getAttribute("vo");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>강의 상세
    </title>
    <style>
        .course-list {
            width: 64%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
        }
        .second_title_info{
            /* display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 0; */
            font-size: 14px;
        }
        .main_content{
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 0; 
            margin-right: 100px;
            margin-left: 100px;

        }
        .cont_info [class*=label] {
            display: flex;
            -webkit-box-align: center;
            align-items: center;
        }
        .cont_info [class*=label]::before{
            content: '';
            position: relative;
            top : 0.1rem;
            display: inline-block;
            width : 2rem;
            height: 16px;
            margin-right: 0.3rem;
            background: url(../img/ico_view_labels.png) no-repeat 0 0;
        }
        .cont_info .label01 ::before{
            background-position: 0 -2rm;
        }
        .cont_info .label02 ::before{
            background-position: 0 -4rm;
        }
        .cont_info .label03 ::before{
            background-position: 0 -6rm;
        }
        .cont_info .label04 ::before{
            background-position: 0 -8rm;
        }
        .cont_info .label05 ::before{
            background-position: 0 -10rm;
        }
        .cont_info .label06 ::before{
            background-position: 0 -12rm;
        }
        .cont_info .label07 ::before{
            background-position: 0 -14rm;
        }
        .cont_info .label08 ::before{
            background-position: 0 -16rm;
        }
        .cont_info dl{
            font-weight: bold;
            font-size: 1.6rem;
            line-height: 1.3;
        }
        .cont_info dd{
            border-bottom: 1px solid #e1e1e1;
            font-weight: 400;
            font-size: 1.3rem;
            line-height: 1.3;
            margin-bottom: 15px;
        }
        .register-btn {
            padding: 10px 20px;
            background-color: #ff5252;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
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
        .register-btn {
            padding: 10px 20px;
            margin: 0 10px;
            background-color: #0b70b9;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 5px;
        }
        .register-btn:hover {
            background-color: #007ACC;
        }
        .option{
            font-size: 12px;
            font-weight: 900;
        }
        .option_db{
            margin-right: 10px;
            margin-left: 4px;
            font-size: 10px;
            font-weight: 900;
        }
        </style>
</head>
<body>
      <section class="course-list">
            <div class="first_title">
                <h1>강의 상세</h1>
                <div class="class_hr"></div>
            </div>
        <div>
            <div>
                <div class="second_title">
                    <div><h3><%=vo.getTitle() %></h3></div>
                <div class="second_title_info">
                    <span class="option">작성자</span> <span class="option_db">홍길동</span>
                    <span class="option">등록일</span> <span class="option_db">2024-10-21</span>
                    <span class="option">조회수</span> <span class="option_db">120</span>
                </div>
                    <hr>
                </div>
                <div class="main_content">
                    <div class="img">
                        <img src="../img/강사사진1.png">
                    </div>
                    <div class="cont_info">
                        <dl>
                            <dt>
                                <span class="label01" ::before>과목</span>
                            </dt>
                            <dd><%=vo.getSubject() %></dd>
                            <dt>
                                <span class="label02" ::before>수강 신청 기간</span>
                            </dt>
                            <dd><%=vo.getJdate() %></dd>
                            <dt>
                                <span class="label03" ::before>수준</span>
                            </dt>
                            <dd><%=vo.getDifficult() %></dd>
                            <dt>
                                <span class="label04" ::before>교재</span>
                            </dt>
                            <dd><%=vo.getBook() %></dd>
                            <dt>
                                <span class="label05" ::before>강의 기간</span>
                            </dt>
                            <dd><%=vo.getDuringclass() %></dd>
                        </dl>
                        
                    </div>
                </div>
            </div>
        </div>

        <hr>
        <div class="mother">
            <span class="center_button"><a href="<%=request.getContextPath()%>/class/list.do"><button class="register-btn">목록</button></a></span>
            <span><button class="register-btn">수정</button></span>
            <span><button class="register-btn">삭제</button></span>
        </div>
      </section>
      <%@ include file="../../include/footer.jsp" %>
</body>
</html>