<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

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
    <title>free_board_write</title>
    <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>	
    <style>
        /* section 부분 시작 */
        section{
          flex-grow: 1;
          padding-bottom: 80px;
          position: relative;
        }
        form{
            position: absolute;
            left: 965px;
        }
        .free_title{
          position: absolute;
          left: 50%;
          margin: 47px 0 0 -600px;
          padding: 0;
        }
        .free_title_write input{
            position: absolute;
            left: 50%;
            margin: 120px 0 0 -600px;
            border-left: none;
            border-right: none;
            outline: none; /*input 박스 눌러도 세로선 x*/
            width: 1200px;
            height: 45px;
        }
        .free_body_write textarea{
            position: absolute;
            left: 50%;
            margin: 190px 0 0 -600px;
            height: 350px;
            width: 1200px;
            border-bottom: 2px solid gray;
            border-left: none;
            border-right: none;
            border-top: none;
            outline: none;
            
        }
        .free_board_file{
            width: 100px;
            position: absolute;
            left: 50%;
            top: 550px;
            left: 530px;
            padding-bottom: 10px;
        }
        .free_board_line{
            top: 580px;
            left: 365px;
            position: absolute;
            border: 1px solid gray;
            width: 1200px;
        }
        .free_board_button{
            position: absolute;
            top: 600px;
            left: 500px;
            width: 80px;
            height: 30px;
            font-size: 15px;
            border: none;
            border-radius:20px;
            display: flex;
            width: 120px;
        }
        .free_board_button button{
            margin-left: 10px;
            border: none;
            border-radius:10px;
            cursor: pointer;
        }
        .box{
            position: absolute;
            border: 1px solid black;
            width: 600px;
            height: 30px;
            top: 550px;
            right: 0;
            overflow: hidden;
            border: none;
            text-overflow: ellipsis;
        }
        /* section 부분 끝 */
    </style>
</head>
<body>
      <section>
        <h2 class="free_title">Q&A 등록</h2>
        <form action="<%=request.getContextPath()%>/qna/qna_write.do" method="post">
            <div class="free_title_write">
                <input type="text" placeholder="제목을 입력해주세요." name="title" >
            </div>
            <div class="free_body_write">
                <textarea name="content" placeholder="내용을 입력해주세요."></textarea>
            </div>
            <div class="free_board_button">
                <button type="button" onclick="submitfn(this)">등록</button>
                <button type="button" onclick="location.href='<%=request.getContextPath()%>/qna/qna_list.do'">취소</button>
            </div>
        </form>
        <script>
            function submitfn(obj){
            	
            	 let title = $("input[name='title']").val();
            	 let content = $("textarea[name='content']").val();
                 if (title == "") {
                     alert("제목을 입력해주세요.");
                     if(content == ""){}
                 }
            	if(content == ""){
            		alert("내용을 입력해주세요");
            	}else{
            		$(obj).parent().parent().submit(); //parent() (부모)
            	}
            }
            </script>
        <div class="free_board_line"></div>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>