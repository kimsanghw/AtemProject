<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
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
    .admin_page{
        font-size: 20px;
        font-weight: 900;
        margin: 40px 50px;
    }
    .admin_page_table{
        margin: 0px 50px;
        border: none;
    }
    .admin_page_border th{
        
        background-color: silver;
    }
    .admin_page_my th{
        background-color: rgb(253, 253, 253);
    }
    select{
        width: 80px;
    }
    .authority_container{
        display: flex;
        align-items: center;
    }
    .authority_button {
        margin-left: 10px; /* ë²í¼ê³¼ select ê°ê²© ì¡°ì  */
        width: 50px;
    }
    .mypage_searchBox{
        text-align: center;
        margin: 0px 200px;
        margin-top: 30px;
        width: 500px;
        height: 30px;
    }
    .search_options{
        height: 36px;
        position: absolute;
        margin: 30px 200px;
    }
    .search{
        position: absolute;
        margin: 30px 658px;
        width: 50px;
        height: 36px;
    }
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
            <div class="admin_page">ê¶í ì¤ì </div>
            <table border="1" class="admin_page_table">
                <thead>
                    <tr class="admin_page_border">
                        <th width="120px">ìì´ë</th>
                        <th width="90px">ì´ë¦</th>
                        <th width="300px">ì´ë©ì¼</th>
                        <th width="200px">ì°ë½ì²</th>
                        <th width="120px">ê¶í</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="admin_page_my"> <!--formíê·¸ë¥¼ ìì ê³  ë±ë¡ ë²í¼ì ëë ì ë ajaxë¡ selectê°ì ëê²¨ì£¼ê² í´ì¼í¨.-->
                        <td width="120px">qortmddn567</td>
                        <td width="90px">ë°±ì¹ì°</td>
                        <td width="300px">qortmddn567@naver.com</td>
                        <td width="200px">01041972216</td>
                        <td width="120px">
                            <div class="authority_container">
                                <select name="authority">
                                    <option value="student">íì</option>
                                    <option value="teacher">ê°ì¬</option>
                                </select>
                                <button class="authority_button" type="submit">ë±ë¡</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <form><!--ì¬ê¸°ë formíê·¸ ìì ê³  ê²ì ë²í¼ ëë ì ë ajaxë¡ selectê° ëê²¨ì£¼ê².-->
                <select class="search_options" name="search_option">
                    <option value="id">ìì´ë</option>
                    <option value="name">ì´ë¦</option>
                    <option value="email">ì´ë©ì¼</option>
                    <option value="number">ì°ë½ì²</option>
                </select>
                <button class="search" type="submit">ê²ì</button>
                <input class="mypage_searchBox" type="text" placeholder="ê²ìì´ë¥¼ ìë ¥í´ì£¼ì¸ì" name="mypage_search">
            </form>
        </div>
    </section>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>