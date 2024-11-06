<%@page import="FrontController.util.PagingUtil"%>
<%@page import="FrontController.vo.qnaVO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

<%
	List<qnaVO> list = (List<qnaVO>)request.getAttribute("list");
	String searchValue = (String)request.getAttribute("searchValue");
	String searchType = (String)request.getAttribute("searchType");
	PagingUtil paging = (PagingUtil) request.getAttribute("paging");
	
	int nowpage = 1;
	if(request.getParameter("nowpage")!= null){
		nowpage = Integer.parseInt(request.getParameter("nowpage"));
	}
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>free_board_list</title>
    <style>
        /* 내용 부분 시작*/
        section{
          flex-grow: 1;
          padding-bottom: 80px;
        }
        form{
            margin-left: 450px;
        }
        form select{
            position: absolute;
            margin-top: 30px;
            height: 62px;
            width: 100px;
            text-align: center;
        }
        .free_board_input{
            margin-left: 549px;
            margin-top: 10px;
        }
        .free_board_input input{
            width: 900px;
            height: 50px;
        }
        .free_board_img{/*돋보기*/
            position: absolute;
            margin-left: 947px;
            margin-top: -62px;
        }
        .free_title{
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
        .search_button{
          width: 61px;
          height: 62px;
        }
        .search_input{
          width: 1000px;
          height: 56px;
          margin-top: 30px;          
          text-align: center;
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
        <form action="<%=request.getContextPath() %>/qna/qna_list.do" method="get">
            <select name="searchType">
                <option <%=searchType != null && searchType.equals("title")?"seleced":"" %>>제목</option>
                <option value="content" <%=searchType != null && searchType.equals("content' ")?"seleced":"" %>>내용</option>
            </select>
            <input type="text" class="search_input" placeholder="검색어를 입력해주세요." name="searchValue">
            <div class="free_board_img">
                <button class="search_button" type="submit">검색</button>
            </div>
        </form>
        <div class="free_board_input">
        </div>
        <h2 class="free_title">Q&A</h2>
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
          	 <%for(qnaVO vo : list){%>
           <tr>
				<td><%=vo.getQno() %></td>
				<td>
              		<a href="<%=request.getContextPath() %>/qna/qna_view.do?qno=<%=vo.getQno() %>">
              		<%=vo.getTitle() %>
              		</a>
				</td>
              <td><%=vo.getRdate() %></td>
              <td><%=vo.getHit() %></td>
            </tr>
          <%} %>
          </tbody>
        </table>
            <button class="button" onclick="location.href='<%=request.getContextPath()%>/qna/qna_write.do'">등록</button>

            <!-- 페이징 영역 -->
            <div class="paging">
        	
		<%
			if(paging.getStartPage() > 1){
				//시작페이지가 1보다 큰경우 이전 페이지 존재
				if(searchType!=null){
					%>
					<!-- 클릭시 현재 페이지의 시작 페이지 번호 이전 페이지로 이동 13->10으로 이동 -->
					<a href="<%=request.getContextPath()%>/library/library_list.do?nowpage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"> &lt; </a>
				<%			
				}else{
					%>
					<!-- 클릭시 현재 페이지의 시작 페이지 번호 이전 페이지로 이동 13->10으로 이동 -->
					<a href="<%=request.getContextPath()%>/library/library_list.do?nowpage=<%=paging.getStartPage()-1%>"> &lt; </a>
				<%		
				}
		
			}
		
			for(int i= paging.getStartPage();
					i<=paging.getEndPage(); i++){
				if(i == nowpage){
				%>
				<strong><%= i %></strong>
				<%
				}else{
					if(searchType!=null){
						%>
						
						<a href="<%=request.getContextPath()%>/qna/qna_list.do?nowpage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
						<%		
					}else{
						%>
						
						<a href="<%=request.getContextPath()%>/qna/qna_list.do?nowpage=<%=i%>"><%=i %></a>
						<%		
					}
				
				}
			}
			
			if(paging.getLastPage()>paging.getEndPage()){
				//전체 페이지번호 보다 현재 종료 페이지 번호가 더 작은 경우
				if(searchType!=null){
					%>
					<a href="<%=request.getContextPath()%>/qna/qna_list.do?nowpage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
					<%
				}else{
					%>
					<a href="<%=request.getContextPath()%>/qna/qna_list.do?nowpage=<%=paging.getEndPage()+1%>">&gt;</a>
					<%	
				}
				
			}
			
		%>
	
	
        </div>
            
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>