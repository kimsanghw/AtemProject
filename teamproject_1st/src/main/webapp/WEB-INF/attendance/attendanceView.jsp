<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="FrontController.util.*" %>
<%@ page import="FrontController.vo.App_classVO" %>
<%

 List<App_classVO> attendanceList = (List<App_classVO>)request.getAttribute("attendanceList");
 String selectedDate = (String)request.getAttribute("selectedDate");
 String todayDate = (String)request.getAttribute("todayDate");
 Integer cno = (Integer) request.getAttribute("cno");
 if (cno == null) {
     cno = 0;  // 기본값 설정
 }


%>
<title>Insert title here</title>
<script src='<%=request.getContextPath()%>/js/jquery-3.7.1.js'></script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const dateInput = document.getElementById("dateInput");
	    if (dateInput) {
	        dateInput.addEventListener("change", function() {
	            document.getElementById("dateForm").submit();
	        });
	    }
	
	    // 출결 변경 버튼에 대한 이벤트 리스너
	    $(".attendanceChange_button").on("click", function(e) {
	        e.preventDefault();
	        
	        var $button = $(this);
	        var $row = $button.closest("tr");
	        var attendanceChange = $row.find("select[name='attendanceChange']").val();
	        var ano = $row.find("input[name='ano']").val();
	        
	        $.ajax({
	            url: "<%=request.getContextPath()%>/attendance/attendanceView.do",
	            type: "POST",
	            data: { attendanceChange: attendanceChange, ano: ano },
	            success: function(response) {
	                if(response.trim() === "success") {
	                    alert("출결 변경에 성공하였습니다.");
	                    
	                    // UI 즉시 업데이트
	                    var $statusCell = $row.find("td:eq(2)"); // 세 번째 열(출결구분)
	                    $statusCell.text(attendanceChange);
	                    
	                    // 선택된 옵션 업데이트
	                    $row.find("select[name='attendanceChange']").val(attendanceChange);
	                } else {
	                    alert("출결 변경에 실패했습니다.");
	                }
	            },
	            error: function() {
	                alert("서버와의 통신에 실패했습니다.");
	            }
	        });
	    });
	});

	function generateAndShowRandomNumber() {
	    const cno = "<%= cno %>"; // 서버에서 전달받은 cno를 사용

	    $.ajax({
	        url: "<%=request.getContextPath()%>/attendance/updateRandom_number.do",
	        type: "POST",
	        data: { cno: cno },
	        success: function(response) {
	            if (response.trim() === "success") {
	                // 인증코드 성공적으로 저장되면 모달창 표시
	                const random_number = document.getElementById("generatedRandom_number").value;
	                document.getElementById("random_number").innerText = random_number;
	                document.getElementById("random_numberModal").style.display = "block";
	                alert("인증코드가 성공적으로 저장되었습니다.");
	            } else {
	                alert("인증코드 저장에 실패했습니다.");
	            }
	        },
	        error: function() {
	            alert("서버와의 통신에 실패했습니다.");
	        }
	    });
	}

	function closeModal() {
	    document.getElementById("random_numberModal").style.display = "none";
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
    .content_inner{
      width: 86%;
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
      margin-bottom: 40px;
    }
    .content_c h3 {
      color: black;
      font-size: 20px;
    }
    
    select{
      height: 25px;
      width: 90px;
      font-size: 20px;
      margin-top: 20px;
      margin-bottom: 30px;
    }
    .app_btn{/*버튼 css*/
      width: 90px;
      height: 30px;
      border: 2px solid;
      background-color: #CEECF5;
      margin-left: 700px;
      margin-bottom: 15px;
    }
    .app_btn a {/*버튼 안에 있는 a링크 */
      color: black;
    }
    .attendance_btn{
      width: 90px;
      height: 30px;
      border: 2px solid;
      background-color: #CEECF5;
      margin-left: 700px;
    }
    .attendance_btn1{
      width: 60px;
      height: 30px;
      border: 2px solid;
      background-color: #CEECF5;
      border-radius: 15px;
    }
    .today_date{
      margin-top: 15px;
      margin-bottom: 15px;
    }
     /*-----checkbox css부분*/
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
    input[type='submit']{
      -webkit-appearance: none; 
      -moz-appearance: none; 
      appearance: none; 
      width: 60px;
      height: 30px;
      border: 1px solid #ccc; 
      cursor: pointer;
    }
    input[type='submit']:checked{
      background-color: greenyellow;
    }
    .button{
      text-align: right;
      margin-top: 30px;
    }
     /*테이블부분 css*/
    table{
      width: 100%;
      text-align: center;
      height: 475px;
      border-radius: 5px;
    }
    thead{/*테이블 thead색깔*/
      height: 40px; 
      font-size: 30px;
      background-color: #f7f7f7; 
      font-family: Lato;
    }
    td{
      width: 100px;
      font-size: 20px;
    }
    .check_button{
      margin-left: 7px;
    }
    </style>
    
      <section>
        <article>
          <div class="article_inner">
           <h2>출결 관리</h2>
	          <%
				   // SecureRandom을 사용하여 6자리 인증코드 생성
				   java.security.SecureRandom random = new java.security.SecureRandom();
				   int random_number = 100000 + random.nextInt(900000); // 6자리 숫자 인증코드 (100000~999999 범위)
			  %>
				<input type="hidden" id="generatedRandom_number" value="<%= random_number%>">
				<div style="margin-bottom: 20px;">
				    <button type="button" onclick="generateAndShowRandomNumber()">인증코드 생성</button>
				</div>
				<div id="random_numberModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0, 0, 0, 0.4);">
				    <div style="background-color: #fefefe; margin: 30% auto; padding: 20px; border: 1px solid #888; width: 500px; text-align: center; font-size: 70px;">
				        <h2>인증코드</h2>
				        <p id="random_number"></p>
				        <button onclick="closeModal()">닫기</button>
				    </div>
				</div>
            <div style="border-top:  5px solid #0b70b9; width: 86%;" ></div>
            <form action="<%=request.getContextPath()%>/attendance/attendanceView.do" method="get"  id="dateForm">
            <div class="today_date" >
              <input type="date" name="date" id="dateInput" value="<%= selectedDate != null ? selectedDate : todayDate %>" >
              <input type="hidden" name="cno" value="<%=cno%>">
              
              <span> 현재 일자 : <%= selectedDate != null ? selectedDate : todayDate %></span>
            </div>
            </form>
            <div class="content_inner">
              <table>
                <thead>
                  <tr>
                    <td style="width: 40px;">번호</td>
                    <td style="width: 40px;">이름</td>
                    <td style="width: 40px;">출결구분</td>
                    <td style="width: 40px;">출결상태</td>
                   </tr>
                </thead>
                 <tbody>
        <% int studentNumber = 1; %>
        <% if (attendanceList != null) { %>
            <% for (App_classVO studentInfo : attendanceList) { %>
                <tr>
                    <td><%= studentNumber %><input type="hidden" name="ano" value="<%= studentInfo.getAno()%>"></td>
                    <td><%= studentInfo.getName() %></td>
                    <td><%= studentInfo.getAttendance() != null ? studentInfo.getAttendance() : "미등록" %></td> <!-- 출석 상태가 없으면 '미등록' -->
                    <td>
                        <select name="attendanceChange">
                            <option value="출석" <%= "출석".equals(studentInfo.getAttendance()) ? "selected" : "" %>>출석</option>
                            <option value="지각" <%= "지각".equals(studentInfo.getAttendance()) ? "selected" : "" %>>지각</option>
                            <option value="조퇴" <%= "조퇴".equals(studentInfo.getAttendance()) ? "selected" : "" %>>조퇴</option>
                            <option value="병결" <%= "병결".equals(studentInfo.getAttendance()) ? "selected" : "" %>>병결</option>
                            <option value="결석" <%= "결석".equals(studentInfo.getAttendance()) ? "selected" : "" %>>결석</option>
                        </select>
                        <button class="attendanceChange_button" type="button">등록</button>
                    </td>
                </tr>
                <% studentNumber++; %>
            <% } %>
        <% } else { %>
            <p>출석 데이터가 없습니다.</p>
        <% } %>
    </tbody>
              </table>
            </div>
          </div>
        </article>
      </section>
<%@ include file="../../include/footer.jsp" %>


                  