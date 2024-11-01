<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="FrontController.util.*" %>
<%@ page import="FrontController.vo.App_classVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
 String  classNumber = (String)request.getAttribute(" classNumber");
 String selectedDate = attendanceList.isEmpty() ? "" : attendanceList.get(0).getRdate();


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
            <div style="border-top:  5px solid #0b70b9; width: 86%;" ></div>
            <form action="<%=request.getContextPath()%>/attendance/attendanceView.do" method="get"  id="dateForm">
            <div class="today_date" >
              <input type="date" name="date" id="dateInput" >
              <span>오늘 일자 : <%=selectedDate%></span>
            </div>
            </form>
            <div class="content_inner">
              <table>
                <thead>
                  <tr>
                    <td style="width: 40px;"><input type="checkbox"></td>
                    <td style="width: 40px;">번호</td>
                    <td style="width: 40px;">이름</td>
                    <td style="width: 40px;">출결구분</td>
                    <td>출결상태</td></tr>
                </thead>
                <tbody>
                  <form>
                  <%for(App_classVO studentInfo : attendanceList){%>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;"><%= studentInfo.getAno()%></td>
                      <td style="width: 40px;"><%= studentInfo.getName() %></td>
                      <td><%= studentInfo.getAttendance() %></td>
                      <td>
                        <div class="check_button">
                          <label>
                          <input type="submit" class="attendance_btn1" value="출석">
                          <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <%} %>
                </tbody>
              </table>
              <div class="button">
                <label>
                  <input type="submit" class="attendance_btn1" value="출석">
                  <input type="submit" class="attendance_btn1" value="지각">
                  <input type="submit" class="attendance_btn1" value="조퇴">
                  <input type="submit" class="attendance_btn1" value="결석">
                  <input type="submit" class="attendance_btn1" value="병결">
                </label>
                </div>
            </form>
            </div>
          </div>
        </article>
      </section>
<%@ include file="../../include/footer.jsp" %>

                  