<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script>
         document.addEventListener('DOMContentLoaded', function() {
          var calendarEl = document.getElementById('calendar');

  // 로컬 스토리지에서 출석 상태 가져오기
  function getAttendanceStatus(date) {
    return localStorage.getItem('attendance-' + date) === 'true';
  }

  // 로컬 스토리지에 출석 상태 저장하기
  function setAttendanceStatus(date) {
    localStorage.setItem('attendance-' + date, 'true');
  }

  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    dayCellDidMount: function(info) {
      console.log('dayCellDidMount 실행됨:', info.date); // 확인용 로그

      var today = new Date();
      today.setHours(0, 0, 0, 0); // 오늘 날짜를 로컬 시간 기준으로 초기화

      // info.date를 로컬 시간대로 변환
      var cellDate = new Date(info.date.getFullYear(), info.date.getMonth(), info.date.getDate());
      cellDate.setHours(0, 0, 0, 0); // 셀 날짜도 로컬 시간 기준으로 초기화

      var dateKey = info.date.toISOString().split('T')[0]; // 날짜 키 생성

     

      // 오늘 날짜와 셀 날짜가 일치하는지 확인
      if (cellDate.getTime() === today.getTime()) {
        console.log('오늘 날짜 셀에 버튼 추가'); // 확인용 로그

        // 버튼 생성
        var button = document.createElement('button');
        button.innerText = '오늘 버튼';
        button.style.marginTop = '10px';

        // 버튼 클릭 이벤트 추가
        button.addEventListener('click', function() {
          alert('출석체크 완료');
          statusText.innerText = '출석완료';
          statusText.style.color = 'green';

          // 출석 상태 저장
          setAttendanceStatus(dateKey);

          // 버튼 제거
          button.remove();
        });

        // 날짜 셀에 버튼 추가
        info.el.appendChild(button);
      }
    }
  });

  calendar.render();
});
    </script>
<style>
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
.content_inner{
  width: 80%;
 
}
.content_inner>*{
  width: 100%;
}
.content_inner form{
  height: 50px;
  padding-top: 20px;
}
.content_inner input{
  width: 70%;
}
.content_c {
  border-top: 3px solid black;
  border-bottom: 2px solid black;
  color: gray;
}
.content_c h3 {
  color: black;
  font-size: 20px;
}
select{
  height: 25px;
  width: 90px;
  font-size: 20px;
}
.app_btn{
  width: 90px;
  height: 30px;
  border: 2px solid;
  background-color: #CEECF5;
  margin-left: 700px;
}
.app_btn a {
  color: black;
 
}
table{
  border: 2px solid black;
  width: 100%;
  text-align: center;
  height: 475px;
  border-radius: 5px;
 
}
.attendance_btn{
  width: 90px;
  height: 30px;
  border: 2px solid;
  background-color: #CEECF5;
  margin-left: 700px;
 
}
.attendance_btn1{
  width: 90px;
  height: 30px;
  border: 2px solid;
  background-color: #CEECF5;
 
}
.attendance_btn2{
  width: 90px;
  height: 30px;
  border: 2px solid;
  background-color: #CEECF5;
  
}
.attendance_btn3{
  width: 90px;
  height: 30px;
  border: 2px solid;
  background-color: #CEECF5;
 
}
.attendance_btn4{
  width: 90px;
  height: 30px;
  border: 2px solid;
  background-color: #CEECF5;
 
}
input[type='checkbox'] {
    -webkit-appearance: none; 
    -moz-appearance: none; 
    appearance: none; 
    width: 13px;
    height: 13px;
    border: 1px solid #ccc; 
    border-radius: 50%;
    outline: none; 
    cursor: pointer;
  }

  input[type='checkbox']:checked {
    background-color: #111; 
    border: 3px solid #fff; 
    box-shadow: 0 0 0 1px #111; 
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
        width: 930px;
        padding-bottom: 30px;
        border-radius: 20px;
        margin: -20px 0 0 -280px;
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
    }</style>
</head>
<body>
	<section>
        <div class="attendance_info">출결정보</div>
        <div class="info_flex">
            <div class="app_class class_menu"><a href="#">수강중인 강의 ></a></div>
            <div class="app_line"></div>
            <div class="attendance_check class_menu"><a href="#">출석체크하기 ></a></div>
            <div class="app_line"></div>
        </div>
        <div class="attendance_box info_flex">
            <div id='calendar' style="height: 50%; width: 820px;"></div>
        </div>
      </section>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>