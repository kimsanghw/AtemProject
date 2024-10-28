<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

<!DOCTYPE html> 
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>library_board_list</title>
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
        .library_board_input{
            margin-left: 549px;
            margin-top: 10px;
        }
        .library_board_input input{
            width: 900px;
            height: 50px;
        }
        .library_board_img{/*돋보기*/
            position: absolute;
            margin-left: 947px;
            margin-top: -62px;
        }
        .library_title{
          position: absolute;
          left: 50%;
          margin: 47px 0 0 -600px;
          padding: 0;
        }
        .table{
          position: absolute;
          left: 50%;
          margin: 140px 0 0 -600px;
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
          margin-top: 670px;
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
        /* 내용 부분 끝 */
    </style>
</head>
<body>
      <section>
        <form>
            <select name="search_option">
                <option value="title">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" class="search_input" placeholder="검색어를 입력해주세요." name="search_name">
            <div class="library_board_img">
                <button class="search_button" type="submit">검색</button>
            </div>
        </form>
        <div class="library_board_input">
        </div>
        <h2 class="library_title">자료실</h2>
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
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
            <tr>
              <td>01</td>
              <td><a href="#">첫번째 제목입니다.</a></td>
              <td>2024-10-21</td>
              <td>5</td>
            </tr>
          </tbody>
        </table>
            <button class="button">등록</button>
      </section>
</body>
</html>
<%@ include file="../../include/footer.jsp" %>