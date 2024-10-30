<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ page import="FrontController.vo.ClassVO" %>
<%@ page import="FrontController.util.*" %>
<%
// 모델에서 데이터를 불러와서 유효성검사를 하고 변수에 저장한다
 String searchType = "";

  List<ClassVO> clist = (List<ClassVO>)request.getAttribute("clist");
 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script type="text/javascript">
    $(document).ready(function(){
        $("select[name=searchType]").change(function () {
        $("#searchType").submit();

        });
    });
</script>
    <style>
    /*----------------------------------------------------------------section부분---------------------------------------*/
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
      margin-bottom: 20px;
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
    /*----------------------------------------------------------페이징부분---------------------------------------*/
    .paging_inner{
      width: 80%;
      text-align: center;
      margin-bottom: 15px;
    }
    </style>
</head>
<body>
<section>
        <article>
          <div class="article_inner">
            <h2>출결 관리</h2>
            <div style="border-top: 5px solid #0b70b9; width: 86%;"></div>
            <div class="content_inner">
            	<form action="/attendance/attendanceList.do" method="get" id="searchType">
	              <div>
	                <select  name="searchType" id="searchType">
	                	<option value="">전체</option>
	                  	<option value="강의" <%= searchType != null && searchType.equals("강의")?"selected":"" %>>현재 강의 중인 강의</option>
	                </select>
	              </div>
	              </form>
	               <%
			 for(ClassVO vo : clist){
			 %>
              <div class="content_c">
                  <h3><%=vo.getSubject() %> <%= vo.getTitle() %></h3><br>
                     학생 <br>
                    <button type="button" class="app_btn" onclick="location.href=/attendance/attedanceView.do?cno=">출결관리</button><br>
                    
              </div>
              <%} %>
            </div>
            <div class="paging_inner">
				<a href="">이전</a>
                <a href="">1</a>
                <a href="">2</a>
                <a href="">다음</a>
            </div>
          </div>
        </article>
      </section>
<%@ include file="../../include/footer.jsp" %>