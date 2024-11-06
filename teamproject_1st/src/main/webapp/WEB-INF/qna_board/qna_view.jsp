<%@page import="java.util.*"%>
<%@page import="FrontController.vo.commentVO"%>
<%@page import="FrontController.vo.qnaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

<%
	List<commentVO> list = (List<commentVO>)request.getAttribute("list"); 
	qnaVO vo = (qnaVO)request.getAttribute("vo");
%>
<%
	//세션에서 로그인 정보 확인하기
	UserVO loginUser;
	// 세션에서 값 가져오기
	loginUser = (UserVO)session.getAttribute("loginUser");
	// 로그인 정보가 없으면 내보냄
	if( loginUser == null) {	/* <!-- 로그인 정보가 없음 --> */
		%>
		<script>
			alert('로그인이 필요합니다.');
			location.href='<%=request.getContextPath()%>/user/login.do'
		</script>
		<%
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>free_board_view</title>
    <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>
    <style>
        /* section 부분 시작 */
        section{
            width: 63%;
            margin: 0px auto;
            background-color: white;
            border-radius: 8px;
        }
        .free_title{
            border-bottom: 5px solid #007ACC;
        }
        .free_board{
            font-size: 9px;
        }
        .comment_title{
            border-bottom: 5px solid #007ACC;
        }
        .free_board_content{
            height: 300px;
        }
        .comment_input input{
            width: 1200px;
            height: 50px;
            outline: none;
            border: none;
        }
        .comment_button{
            display:flex;
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

        .delete_button{
            margin-left: 5px;
        }
        .modify_button{
        	
        }
        .Content{
        	width:1100px; 	
        }
        .comment_view{
        	display:flex;
        }
    </style>
</head>
<body>
      <section>
        <div class="free_title"><h2>Q&A 상세</h2></div>
        <div class="free_board_title">
            <div>
                <h3><%=vo.getTitle() %></h3>
            </div>
            <div class="free_board">작성자 <%=vo.getName() %> 등록일 <%=vo.getRdate() %> 조회수 <%=vo.getHit() %></div>
        </div>
        <hr>
        <div class="free_board_content"><%=vo.getContent() %></div>
        <div>
            <div class="comment_title">
                <h3>댓글</h3>
            </div>
            <form action="comment_writeok.do" method="POST">
                <div class="comment_input">
                	<input type="hidden" name="qno" value="<%=vo.getQno()%>">
                    <input type="text" placeholder="댓글을 입력해주세요." name="content" size="80">
                    <button type="submit">등록</button>
                </div>
            </form>
            <%for(commentVO cvo : list){%>
            	
                <br>
                <div class="comment_view">
                    <div class="Content">
                    	<span class="contentbox"><%=cvo.getContent() %></span>
	                    <form class="commentmodifyfrm" action="comment_modifyok.do" method="POST">
	                    	<input type="hidden" name="content" value="<%=cvo.getContent()%>" size="150">
	                    	<input type="hidden" name="qcno" value="<%=cvo.getQcno()%>">
	                    </form>
                    </div>
                    <div class="comment_button">
	                    
	                    <button class="register_button" type="button" style="display:none;" onclick="commentmodifyfrm(this)">저장</button>
	                    <button class="cencle_button" type="button"  style="display:none;" onclick="cenclefn(this)">취소</button>
	                    <button class="modify_button" type="button" onclick="updateCommentFn(this)" >수정</button>
	                     
	                    
	                    <form name="commentdeletefrm" action="comment_deleteok.do" method="POST" >
	                    	<button class="delete_button" type="submit">삭제</button>
		 					<input type="hidden" name="qcno" value="<%=cvo.getQcno()%>">
		 					<input type="hidden" name="qno" value="<%=vo.getQno()%>">
		 				</form>
                    </div>
                </div>
           
            <%}%>
            <script>
            function cenclefn(obj){
            	$(".commentmodifyfrm").hide();
            	$(".contentbox").show();
            	$(".register_button").hide();
            	$(".cencle_button").hide();
            	$(".modify_button").show();
            	$("[name=commentdeletefrm]").show();
            }
            
            function updateCommentFn(obj){
            	$(".commentmodifyfrm").find("[name=content]").attr("type","hidden");
            	$(".contentbox").show();
            	$(".register_button").hide();
            	$(".cencle_button").hide();
            	$(".modify_button").show();
            	$("[name=commentdeletefrm]").show();
            	let span = $(obj).parent().prev().find("span");
            	let modifyform = $(obj).parent().prev().find("form");
            
            	span.hide();
            	modifyform.find("[name=content]").attr("type","text");
            	$(obj).prev().show();
            	$(obj).prev().prev().show();
            	$(obj).hide();
            	$(obj).next().hide();
            }
            </script>
            
        </div>
        <hr>
        <hr>
        <div class="mother">
            <span class="center_button"><button onclick="location.href='<%=request.getContextPath()%>/qna/qna_list.do'">목록</button></span>
            
            <% if(loginUser != null && vo != null && loginUser.getUno() == vo.getUno()){%>
            	<span><button class="register-btn" type="submit" onclick="location.href='<%=request.getContextPath()%>/qna/qna_modify.do?qno=<%= vo.getQno()%>'">수정</button></span>
            	<span class="delete_button" ><button class="register-btn" type="button" onclick="document.frm.submit();">삭제</button></span>
           		<form name="frm" action="<%=request.getContextPath()%>/qna/qna_delete.do" method="post" >
	 				<input type="hidden" name="qno" value="<%=vo.getQno()%>">
	 			</form>
            <% }%>
            
            
            </div>
        </div>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>