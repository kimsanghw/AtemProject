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
                    <button type="button" onclick="submitfn(this)" >등록</button>
                </div>
            </form>
            
            <script>
            function submitfn(obj){
            	let content = $(obj).prev().val(); // prev() (형)
            	if(content == ""){
            		alert("내용을 입력해주세요");
            	}else{
            		$(obj).parent().parent().submit(); //parent() (부모)
            	}
            }
            </script>
            <%for(commentVO cvo : list){%>
            	
                <br>
                <div class="comment_view">
                    <div class="Content">
                    	<span class="contentbox"><%=cvo.getContent() %></span>
	                    <form class="commentmodifyfrm" action="comment_modifyok.do" method="POST">
	                    	<input type="hidden" name="content" value="<%=cvo.getContent()%>" size="150">
	                    	<input type="hidden" name="qcno" value="<%=cvo.getQcno()%>">
	                    	<input type="hidden" name="qno" value="<%=vo.getQno()%>">
	                    </form>
                    </div>
                    <%if(loginUser != null && vo != null && loginUser.getUno() == vo.getUno()){%>
                    	<div class="comment_button">
	                    <!-- 수정 누른 후 나오는 버튼 -->
	                    <button class="register_button" type="submit" style="display:none;" onclick="commentmodifyfrm(this)">저장</button>
	                    <button class="cencle_button" type="button"  style="display:none;" onclick="cenclefn(this)">취소</button>
	                    <!-- 처음버튼 -->
	                    <button class="modify_button" type="button" onclick="updateCommentFn(this)" >수정</button>
	                     
	                    
	                    <form name="commentdeletefrm" action="comment_deleteok.do" method="POST" >
	                    	<button class="delete_button" type="submit">삭제</button>
		 					<input type="hidden" name="qcno" value="<%=cvo.getQcno()%>">
		 					<input type="hidden" name="qno" value="<%=vo.getQno()%>">
		 				</form>
                    </div>
                </div>
                    <%} %>
                    
           
            <%}%>
            <script>
            
            
            function cenclefn(obj){ // 취소 버튼 클릭 시 실행되는 함수
            	$(".commentmodifyfrm").hide(); // commentmodifyfrm 요소 숨기기 (댓글 수정 폼을 숨김)
            	$(".contentbox").show(); // contentbox 요소 보이기 (기존 댓글 내용 보이기)
            	$(".register_button").hide(); // register_button 요소 숨기기 (저장 버튼 숨김)
            	$(".cencle_button").hide(); // cencle_button 요소 숨기기 (취소 버튼 숨김)
            	$(".modify_button").show(); // modify_button 요소 보이기 (수정 버튼 보이기)
            	$("[name=commentdeletefrm]").show(); // [name=commentdeletefrm] 요소 보이기 (댓글 삭제 폼 보이기)
            }
            
            function updateCommentFn(obj){
            	//모든 commentmodifyfrm 요소에서 [name=content] 필드의 타입을 "hidden"으로 설정 (수정 폼 숨기기)
            	$(".commentmodifyfrm").find("[name=content]").attr("type","hidden"); 
            	
            	//모든 contentbox 요소를 보이도록 설정 (기존 댓글 내용을 표시)
            	$(".contentbox").show();  
            	
            	//register_button 요소 숨기기 (수정 등록 버튼 숨김)
            	$(".register_button").hide(); 
            	
            	//cencle_button 요소 숨기기 (취소 버튼 숨김)
            	$(".cencle_button").hide(); 
            	
            	//modify_button 요소 보이기 (수정 버튼 표시)
            	$(".modify_button").show(); 
            	
            	// name=commentdeletefrm 요소 보이기 (삭제 폼 표시)
            	$("[name=commentdeletefrm]").show();  
            	
            	// 현재 댓글의 수정 폼과 텍스트를 찾기
                // obj가 속한 부모 요소의 이전 형제 요소에서 span과 form 요소를 찾음
            	let span = $(obj).parent().prev().find("span"); // 기존 댓글 텍스트
            	let modifyform = $(obj).parent().prev().find("form"); // 댓글 수정 폼
            	
            	// 기존 댓글 텍스트 숨기기
            	span.hide();
            	modifyform.show();
            	 // 댓글 수정 폼의 name=content 필드 타입을 text로 설정 (수정할 수 있도록 보이기)
            	modifyform.find("[name=content]").attr("type","text");
            	 
            	// obj의 이전 요소를 보이도록 설정 (저장 버튼)
            	$(obj).prev().show();
            	
            	// obj의 두 번째 이전 요소를 보이도록 설정 (취소 버튼)
            	$(obj).prev().prev().show();
            	
            	// obj 요소 자체를 숨기기 (수정 버튼 숨김)
            	$(obj).hide();
            	
            	// obj의 다음 요소를 숨기기 (삭제 버튼 숨김)
            	$(obj).next().hide();
            }
            
            function commentmodifyfrm(obj) {
                // 수정할 댓글 데이터를 준비
                let content = $(obj).parent().prev().find("[name=content]").val(); // 수정된 댓글 내용
                let qcno = $(obj).parent().prev().find("[name=qcno]").val();       // 댓글 번호
                let qno = $(obj).parent().prev().find("[name=qno]").val();         // 게시글 번호
                
                if (content === "") {
                    alert("수정된 내용이 없습니다."); // 경고 메시지 표시
                    
                }else{
                	
                	  console.log(content,qcno,qno);

                      // AJAX 요청을 사용하여 댓글 수정
                      $.ajax({
                          url: "<%=request.getContextPath()%>/qna/comment_modifyok.do", // 서버의 댓글 수정 처리 URL
                          type: "POST",
                          data: { "content": content, "qcno": qcno, "qno": qno }, // 전송할 데이터
                          success: function(response) {
                          	let result = response.trim();
                          	console.log(result);
                          	if(result == "OK" ){
      	                        alert("댓글이 성공적으로 수정되었습니다."); // 성공 메시지 표시
                              	location.reload(); // 페이지 새로고침으로 UI 업데이트
                          	}else{
                          		alert("오류가 발생했습니다");
                          	}
                          },
                          error: function() {
                              // 요청이 실패했을 때 실행할 작업
                              alert("댓글 수정 중 오류가 발생했습니다. 다시 시도해주세요."); // 오류 메시지 표시
                          }
                      });
                }
            }            
            </script>
        </div>
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