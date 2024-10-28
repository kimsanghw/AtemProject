<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        section {
            flex-grow: 1; /* ë¨ì ê³µê°ì ì°¨ì§íëë¡ ì¤ì  */
            padding-bottom: 80px;
        }
        .mypage_box{
            border: 2px solid gray;
            width: 930px;
            border-radius: 20px;
            margin: -20px 0 0 -280px;
            padding-bottom: 30px;
        }
        .mypage_flex{
            float: left;
        }
        .mypage_class_start{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_start_subject{
            border: 1px solid black;
            width: 800px;
            height: 80px;
            margin-left: 50px;
        }
        .mypage_class_end{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_end_subject{
            border: 1px solid black;
            width: 800px;
            height: 80px;
            margin-left: 50px;
        }
        .mypage_class_back{
            font-size: 20px;
            font-weight: 900;
            margin: 40px 50px;
        }
        .mypage_back_subject{
            border: 1px solid black;
            width: 800px;
            height: 80px;
            margin-left: 50px;
        }
        /*ì¹ì ë¶ë¶ ë*/
    </style>
</head>
<body>
      <section>
        <div class="mypage">ë§ì´íì´ì§</div>
        <div class="mypage_flex">
            <div class="mypage_mypage mypage_menu"><a href="#">ë§ì´íì´ì§ ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_study mypage_menu"><a href="#">ë´ ê°ì ëª©ë¡ ></a></div>
            <div class="mypage_line"></div>
            <div class="mypage_admin mypage_menu" id="admin_page"><a href="#">ê´ë¦¬ì íì´ì§ ></a></div> <!-- ì´ëë¯¼ì¼ë¡ ë¡ê·¸ì¸ ì ë³´ì´ë divìì­-->
            <div class="mypage_line mypage_admin"></div>
        </div>
        <div class="mypage_box mypage_flex">
            <div class="mypage_class_start">ìê° ì¤ ê°ì</div>
            <div class="mypage_start_subject"></div>
            <div class="mypage_class_end">ìê° ì¢ë£ë ê°ì</div>
            <div class="mypage_end_subject"></div>
            <div class="mypage_class_back">ìê° ì·¨ìí ê°ì</div>
            <div class="mypage_back_subject"></div>
        </div>
        </section>
        <%@ include file="../include/footer.jsp" %>
        <script>
            // ê¶íì ë°ë¥¸ ê´ë¦¬ì íì´ì§ ë³´ì´ê¸°
            const userRole = 'admin'; // ì¬ì©ì ê¶í (ì: 'admin' ëë 'user')

            function showAdminPage() {
                if (userRole === 'admin') {
                    document.getElementById('adminPage').style.display = 'block';
                }
            }
        showAdminPage();
        </script>
</body>
</html>