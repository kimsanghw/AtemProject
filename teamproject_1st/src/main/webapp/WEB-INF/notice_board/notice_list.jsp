<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../include/header.jsp" %>

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