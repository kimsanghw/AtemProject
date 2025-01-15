<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="FrontController.vo.ClassVO" %>
<%@ page import ="FrontController.vo.UserVO" %>
<%@ page import ="java.util.*" %>
<%@ include file="../../include/header.jsp" %>
<%
	ClassVO vo = (ClassVO)request.getAttribute("vo");
	UserVO user = (UserVO) session.getAttribute("loginUser");
	
	if (user == null) {
		%>
		        <script>
		            alert("로그인이 필요한 서비스입니다.");
		            window.location.href = "<%=request.getContextPath()%>/user/login.do";
		        </script>
		<%
		        return;  
		    }
		%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>강의 상세
    </title>
    <style>
    img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
    	.class_hr{
    		border-top : 5px solid #007ACC;
    		 
    	}
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
                    <span class="option">작성자</span> <span class="option_db"><%=vo.getName() %></span>
                    <span class="option">등록일</span> <span class="option_db"><%=vo.getRdate() %></span>
                    <span class="option">조회수</span> <span class="option_db">120</span>
                </div>
                    <hr>
                </div>
                <div class="main_content">
                    <div class="img">
                    <!-- 현재 쿼리는 class user만 하고 있음 그래서 orgFileName을 불러오려면 서브쿼리를 사용? -->
                        <img src="<%=request.getContextPath()%>/upload/<%=vo.getNewFileName()%>">
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
                            <dd><%=vo.getJdate() %> ~ <%=vo.getEnd_jdate() %></dd>
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
                            <dd><%=vo.getDuringclass() %> ~ <%=vo.getEnd_duringclass() %></dd>
                        </dl>
                        
                    </div>
                </div>
            </div>
        </div>

        <hr>
        <div class="mother">
        <%
			    if (user != null) {
			        String authorization = user.getAuthorization();
			        if ("S".equals(authorization)) {
			%>
        	<span class="center_button"><button class="register-btn" onclick="document.fre.submit()">수강신청</button></span>
        	<%
			        }
			    }
			%>
        	<form name="fre" action="<%=request.getContextPath()%>/class/app_class.do" method="POST">
        		<input type="hidden" name="cno" value="<%=vo.getCno() %>">
        		<input type="hidden" name="uno" value="<%=user.getUno() %>">
        		<input type="hidden" name="title" value="<%=vo.getTitle() %>">
			    <input type="hidden" name="subject" value="<%=vo.getSubject() %>">
			    <input type="hidden" name="jdate" value="<%=vo.getJdate() %>">
			    <input type="hidden" name="end_jdate" value="<%=vo.getEnd_jdate() %>">
			    <input type="hidden" name="difficult" value="<%=vo.getDifficult() %>">
			    <input type="hidden" name="book" value="<%=vo.getBook() %>">
			    <input type="hidden" name="duringclass" value="<%=vo.getDuringclass() %>">
			    <input type="hidden" name="end_duringclass" value="<%=vo.getEnd_duringclass() %>">
        	</form>
            <span class="center_button"><button class="register-btn" onclick="location.href='<%=request.getContextPath()%>/class/list.do'">목록</button></span>
            
			<%
			    if (user != null) {
			        String authorization = user.getAuthorization();
			        if ("A".equals(authorization)) {
			%>
			            <span><button class="register-btn" onclick="location.href='<%=request.getContextPath()%>/class/modify.do?cno=<%=vo.getCno()%>'">수정</button></span>
			            <span><button class="register-btn" onclick="document.frm.submit()">삭제</button></span>
			            <form name="frm" action="<%=request.getContextPath()%>/class/delete.do" method="POSt">
			            	<input type="hidden" name="cno" value="<%=vo.getCno() %>">
			            </form>			
			            <%
			        }
			    }
			%>
        </div>
      </section>
      <%@ include file="../../include/footer.jsp" %>
</body>
</html>