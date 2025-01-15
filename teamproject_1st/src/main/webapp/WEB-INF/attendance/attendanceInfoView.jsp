<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import="java.util.*" %>
<%  UserVO user = (UserVO) session.getAttribute("loginUser");
    if (user == null) {
%> <script>
		            alert("로그인이 필요한 서비스입니다.");
		            window.location.href = "<%=request.getContextPath()%>/user/login.do";
		        </script>
		<%
		        return;  
		    }
		%>
   		

<title>출석 정보</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
//JSP에서 서버 사이드 데이터를 자바스크립트 변수로 전달
var attendanceEvents = [
    <% 
        List<Map<String, Object>> attendanceData = (List<Map<String, Object>>) request.getAttribute("attendanceData");
        for (Map<String, Object> data : attendanceData) {
            String status = (String) data.get("status");
            String date = (String) data.get("date");
    %>
        {
            title: "<%= status %>", // 출석 상태
            start: "<%= date %>", // 날짜 정보
            color: getColorForStatus("<%= status %>") // 상태에 맞는 색상
        },
    <% } %>
];

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: attendanceEvents,
        eventContent: function(info) {
            var status = info.event.title;
            return { html: "<div class='event-status'>" + status + "</div>" }; // 날짜를 숨기고 상태만 표시
        },
        eventTextColor: 'white',
        eventBackgroundColor: 'transparent',
        eventBorderColor: 'transparent',
        eventDisplay: 'block',
    });
    calendar.render();
});

// 출결 상태에 따른 색상을 반환하는 함수
function getColorForStatus(status) {
    switch(status) {
        case '출석': return 'green';
        case '결석': return 'red';
        case '지각': return 'orange';
        default: return 'gray';
    }
}
</script>
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
        margin-bottom: 20px;
        margin-left: 50px;
        font-size: 25px;
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
		.fc-day-number {
	    display: none; /* 날짜를 숨깁니다. */
		}
	
		.fc-event {
	    padding: 5px;
	    border-radius: 5px;
	    text-align: center;
	    font-size: 14px;
	    color: white;
		}
	
		.fc-event-title {
	    font-weight: bold;
		}
	
		.fc-event .event-status {
	    text-align: center;
		}
    </style>

<section>
    <div class="attendance_info">출석정보</div>
    <div class="info_flex">
        <div class="app_class class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceClass.do">수강중인 강의 ></a></div>
        <div class="app_line"></div>
        <div class="attendance_check class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceCheck.do">출석체크하기 ></a></div>
        <div class="app_line"></div>
        <div class="attendance_Info class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceInfoView.do">출석정보보기 ></a></div>
        <div class="app_line"></div>
    </div>
    <div class="attendance_box info_flex">
        <div class="app_check">출석정보</div>
        <div id='calendar'></div>
    </div>
</section>

<%@ include file="../../include/footer.jsp" %>