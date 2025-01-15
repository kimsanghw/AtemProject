<%@page import="FrontController.util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@page import="FrontController.vo.NoticeVO"%>
<%@ include file="../../include/header.jsp" %>
<%
	List<NoticeVO> list = (List<NoticeVO>)request.getAttribute("list");
	PagingUtil paging = (PagingUtil) request.getAttribute("paging");
	int nowpage =1;
	if(request.getParameter("nowpage")!= null){
		nowpage = Integer.parseInt(request.getParameter("nowpage"));
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>notice_board_list</title>
    <style>
        /* 내용 부분 시작*/
        section{
          flex-grow: 1;
          padding-bottom: 80px;
        }
        .notice_title{
          left: 50%;
          margin: 50px 350px;
          padding: 0;
        }
        .table{
          left: 50%;
          margin: 20px auto;
          border: 0;
          border-collapse: collapse;
          text-align: center;
        }
        .table tbody td{
          height: 40px;
          border-left: none;
          border-right: none;
        }
        tbody td>a{
          text-decoration: none;
          color: black;
        }
        .table thead th{
          border-left: none;
          border-right: none;
        }
        .button{
          width: 80px;
          height: 30px;
          font-size: 15px;
          border: none;
          border-radius:20px;
          margin-left: 1480px;
          cursor: pointer;
        }
        .paging{
        	width:50px;
        	margin: auto;
        }
        .paging a{
        	color: black;
        	text-decoration: none;
        }
        /* 내용 부분 끝 */
        </style>
</head>
<body>
      <section>
        <h2 class="notice_title">공지사항</h2>
        <table frame="void" border="1" class="table">
          <thead style="background-color: #f7f7f7;" height="45px">
            <tr>
              <th width="100">NO</th>
              <th width="850">제목</th>
              <th width="150">등록일</th>
              <th width="100">조회수</th>
            </tr>
          </thead>
          <tbody>
          <%for(NoticeVO vo : list){%>
			<tr>
				<td><%=vo.getNno() %></td>
				<td>
				<a href="<%=request.getContextPath() %>/notice/notice_view.do?Nno=<%=vo.getNno() %>">
					<%=vo.getTitle() %>
				</a>
				</td>
				<td><%=vo.getRdate() %></td>
				<td><%=vo.getHit() %></td>
			</tr>
          <%} %>
          </tbody>
        </table>
        <%
    // 세션에서 로그인 정보 확인하기
    	UserVO loginUser = (UserVO) session.getAttribute("loginUser");

    // 로그인한 사용자가 있고, 권한이 "A"인 경우에만 등록 버튼을 표시
    	if (loginUser != null && "A".equals(loginUser.getAuthorization())) {
%>
        <button class="button" onclick="location.href='<%=request.getContextPath()%>/notice/notice_write.do'">등록</button>
<%
    }
%>		
	
        <div class="paging">
        	<!-- 페이징 영역 -->
	<%
		if(paging.getStartPage() > 1){
			//시작페이지가 1보다 큰경우 이전 페이지 존재
	%>
		<!-- 클릭시 현재 페이지의 시작 페이지 번호 이전 페이지로 이동 13->10으로 이동 -->
		<a href="<%=request.getContextPath()%>/notice/notice_list.do?nowpage=<%=paging.getStartPage()-1%>"> &lt; </a>
	<%
		}
	
		for(int i= paging.getStartPage();
				i<=paging.getEndPage(); i++){
			if(i == nowpage){
			%>
			<strong><%= i %></strong>
			<%
			}else{
			%>
			<a href="<%=request.getContextPath()%>/notice/notice_list.do?nowpage=<%=i%>"><%=i %></a>
			<%	
			}
		}
		
		if(paging.getLastPage()>paging.getEndPage()){
			//전체 페이지번호 보다 현재 종료 페이지 번호가 더 작은 경우
			%>
			<a href="<%=request.getContextPath()%>/notice/notice_list.do?nowpage=<%=paging.getEndPage()+1%>">&gt;</a>
			<%
		}
		
	%>
	
	
        </div>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>