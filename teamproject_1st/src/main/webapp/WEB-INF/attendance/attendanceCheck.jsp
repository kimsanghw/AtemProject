<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import="FrontController.vo.ClassVO" %>
<%@ page import="FrontController.util.*" %>
<%@ page import="java.util.*" %>

<%
    // session에서 vo 객체를 가져옵니다
    ClassVO vo = (ClassVO) session.getAttribute("vo");
    int validCode = 0;
    int cno = 0;
    if (vo != null) {
        validCode = vo.getRandom_number();
        cno = vo.getCno();
    }
%>

<title>Insert title here</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js' rel='stylesheet'></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth'
        });
        calendar.render();

        // 전역 변수로 calendar를 참조할 수 있도록 설정
        window.calendar = calendar;
    });
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
    </style>
     <section>
        <div class="attendance_info">출결정보</div>
	    <div class="info_flex">
	        <div class="app_class class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceClass.do">수강중인 강의 ></a></div>
	        <div class="app_line"></div>
	        <div class="attendance_check class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceCheck.do">출석체크하기 ></a></div>
	        <div class="app_line"></div>
	        <div class="attendance_Info class_menu"><a href="<%=request.getContextPath()%>/attendance/attendanceInfoView.do">출석정보보기 ></a></div>
	        <div class="app_line"></div>
	    </div>
        <div class="attendance_box info_flex">
            <div class="app_check">출석체크</div>
            <div id='calendar' ></div>
            <!-- 인증 코드 입력 및 출석 버튼 -->
             <div style="margin-top: 20px; margin-left: 50px;">
            <form id="attendanceForm" action="<%=request.getContextPath()%>/attendance/attendanceCheck.do" method="POST">
                <div style="margin-top: 20px; margin-left: 50px;">
                    <label for="authCode">인증 코드 입력:</label>
                    <input type="text" id="authCode" name="authCode" placeholder="인증 코드를 입력하세요">
			        <input type="hidden" name="cno" value="<%= cno %>">
			        <%= cno %>
			        <%= vo.getRandom_number() %>
			        <% System.out.println("Received authCode: " + vo.getRandom_number());
			        System.out.println("Received cno: " + cno);
					%>
			        <button type="submit">출석 체크</button>
			    </div>
			</form>
</div>
</div>
</section>
<script>
// 페이지가 완전히 로드된 후에 실행되도록 설정
document.addEventListener("DOMContentLoaded", function() {
    // 폼 제출 이벤트 처리
    const form = document.getElementById('attendanceForm');
    form.addEventListener('submit', function(e) {
        e.preventDefault();  // 기본 폼 제출 방지

        if (validateForm()) {
            const formData = new FormData(form);

            // FormData 객체 확인
            if (formData.has('authCode')) {
                console.log("authCode:", formData.get('authCode'));
            } else {
                console.error("authCode 필드가 폼 데이터에 없습니다.");
            }

            if (formData.has('cno')) {
                console.log("cno:", formData.get('cno'));
            } else {
                console.error("cno 필드가 폼 데이터에 없습니다.");
            }

            // 폼 데이터 전송 전 디버깅용 데이터 출력
            for (let [key, value] of formData.entries()) { 
                console.log(`${key}: ${value}`); 
            }

            fetch(form.action, {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())  // 응답을 텍스트로 받기
            .then(result => handleAttendanceResult(result))  // 처리
            .catch(error => console.error('오류:', error));
        }
    });
});

function validateForm() {
    const enteredCode = document.getElementById('authCode').value.trim();
    console.log("Entered Code:", enteredCode);  // 디버깅용
    if (enteredCode === "") {
        alert("인증 코드를 입력해주세요.");
        return false;
    }
    return true;
}

function handleAttendanceResult(result) {
    const response = JSON.parse(result);  // JSON 응답을 파싱
    if (response.status === 'success') {
        const today = new Date().toISOString().split('T')[0];
        calendar.addEvent({
            title: '출석 완료',
            start: today,
            allDay: true,
            backgroundColor: '#0b70b9',
            borderColor: '#0b70b9',
            textColor: '#fff'
        });
        alert(response.message);  // UTF-8 인코딩으로 전달된 메시지
    } else {
        alert(response.message || "출석 체크 실패");
    }
}


</script>
<%@ include file="../../include/footer.jsp" %>