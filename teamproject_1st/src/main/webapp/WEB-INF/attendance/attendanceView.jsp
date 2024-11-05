<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="FrontController.util.*" %>
<%@ page import="FrontController.vo.App_classVO" %>

<title>Insert title here</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const dateInput = document.getElementById("dateInput");
	    if (dateInput) {
	        dateInput.addEventListener("change", function() {
	            document.getElementById("dateForm").submit();
	        });
	    }
	});
</script>
<%

 List<App_classVO> attendanceList = (List<App_classVO>)request.getAttribute("attendanceList");
 String selectedDate = (String)request.getAttribute("selectedDate");
 String todayDate = (String)request.getAttribute("todayDate");
 Integer cno = (Integer) request.getAttribute("cno");
 if (cno == null) {
     cno = 0;  // 기본값 설정
 }
 

%>
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
          <form>
	          <div>
	          	<button type=submit>인증코드 생성</button>
	          </div>
          </form> 
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
                  <% int studnetNumber = 1; %>
                  <%for(App_classVO studentInfo : attendanceList){%>
                    <tr>
                      <td style="width: 40px;"><%= studnetNumber %><input type="hidden" name="ano" value="<%= studentInfo.getAno()%>"></td>
                      <td style="width: 40px;"><%= studentInfo.getName() %></td>
                      <td><%= studentInfo.getAttendance() %></td>
                      <td>
                      	<div>
                          <select name="attendanceChange">
                          	<option value="출석">출석</option>
                          	<option value="지각">지각</option>
                          	<option value="조퇴">조퇴</option>
                          	<option value="병결">병결</option>
                          	<option value="결석">결석</option>
                          </select>
                          <button class="attendanceChange_button" type="submit">등록</button>
                          </div>   
                      </td>
                    </tr>
                    <% studnetNumber++; %> 
                    <%} %>
                </tbody>
              </table>
            </div>
          </div>
        </article>
      </section>
<%@ include file="../../include/footer.jsp" %>
<script>
	$(document).ready(function() {
	    $(".attendanceChange_button").on("click", function(e) {
	        e.preventDefault();
	        
	        var attendanceChange = $(this).siblings("select[name='attendanceChange']").val();
	        var ano = $(this).closest("tr").find("input[name='ano']").val(); // 숨겨진 input에서 ano 값 추출
	        
	        $.ajax({
	            url: "<%=request.getContextPath()%>/attendance/attendanceViewOk.do",
	            type: "POST",
	            data: { attendanceChange: attendanceChange, ano: ano }, // 출결 상태와 번호 전송
	            success: function(response) {
	                if(response.trim() === "success") {
	                    alert("출결 변경에 성공하였습니다.");
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

</script>

                  