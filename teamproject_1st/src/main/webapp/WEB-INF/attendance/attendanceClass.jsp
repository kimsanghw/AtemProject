<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="FrontController.vo.ClassVO" %>
<%@ page import="FrontController.util.*" %>
<%@ include file="../../include/header.jsp" %>
<%

 List<ClassVO> clist = (List<ClassVO>)request.getAttribute("clist");

%>

<title>Insert title here</title>
<style>
	.section {
      flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
      padding-bottom: 80px;
    }
    article{
      width: 1400px;
      margin:0px auto;
    }
    .article_inner{
      margin-left: 100px;
    }
    .paging_inner{
      width: 80%;
      text-align: center;
    }
    select{
      height: 25px;
      width: 90px;
      font-size: 20px;
    }
    table{
      border: 2px solid black;
      width: 50%;
      text-align: center;
      height: 400px;
      border-radius: 5px;
     
    }
      td{
        width: 100px;
        font-size: 20px;
      }
      .button{
        text-align: right;
      }
      thead{
        height: 40px; 
        font-size: 30px;
        background-color: #0b70b9; 
        font-family: Lato;
      }
      .attendance_info{
            font-size: 25px;
            font-weight: 900;
            margin: 50px 355px;
        }
        .class_menu{
            font-size: 20px;
            font-weight: 900;
            margin: 25px 355px;
        }
        .class_menu a{
            text-decoration: none;
            color: black;
        }
        .mypage_admin{
            /*display: none;*/
        }
        .app_line{
            border: 1px solid black;
            width: 150px;
            margin: 0px 355px;
        }
        /*nav부분 끝*/
        .attendance_box{
            border: 2px solid gray;
            width: 890px;
            padding-bottom: 30px;
            border-radius: 20px;
            margin: -20px 0 0 -280px;
            margin-bottom: 40px;
        }
        .info_flex{
            float: left;
        }
        .attendance_border{
            margin: 0 50px;
            width: 830px;
            border: none;
        }
        .mypage_number{
            margin-top: 15px;
            display: none;
        }

       img{
        width: 150px;
        height: 50px;
       }

       .app_check{
        margin-top: 20px;
        margin-bottom: 50px;
        margin-left: 50px;
        font-size: 25px;
       }
       
       .app_check h3{
        margin-bottom: 50px
       }
       .app_check div{
        margin-bottom: 15px;
        font-size: 20px;
       }

        element.style {
        width: 720px;
        height: 600px;
        margin-left: 50px;
        }

        div#calendar {
         width: 760px;
         margin-left: 50px;
		}
    </style>
     <section>
        <div class="attendance_info">수강정보</div>
        <div class="info_flex">
            <div class="app_class class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceClass.do">수강중인 강의 ></a></div>
            <div class="app_line"></div>
            <div class="attendance_check class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceCheck.do">출석체크하기 ></a></div>
            <div class="app_line"></div>
            <div class="attendance_Info class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceInfoView.do">출석정보보기 ></a></div>
            <div class="app_line"></div>
        </div>
        <div class="attendance_box info_flex">
            <%
			 for(ClassVO vo : clist){
			 %>
            <div class="app_check">
            	<h3>수강 중인 강의</h3>
	            	<div>강의 제목 : <%=vo.getTitle() %></div>
	            	<div>강의 과목 : <%=vo.getSubject() %></div>
	            	<div>강의 난이도 : <%=vo.getDifficult() %></div>
	            	<div>강의 교제 : <%=vo.getBook() %></div>
	            	<div>강의 시작 날짜 : <%=vo.getDuringclass() %></div>
	            	<div>강의 마지막 날짜 : <%=vo.getEnd_duringclass() %></div>
            </div>
             <%} %>
        </div>
    </section>
<%@ include file="../../include/footer.jsp" %>

            