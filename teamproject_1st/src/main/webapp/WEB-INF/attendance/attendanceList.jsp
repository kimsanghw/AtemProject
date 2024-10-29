<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<%@ pave import="FrontController.vo.ClassVO" %>
<%@ page import="FrontController.util.*" %>

<script type="text/javascript">
    $(document).ready(function(){
        $("select[name=search_mode]").change(function () {
        $("#search_mode").submit();

        });
    });
</script>
<section>
        <article>
          <div class="article_inner">
            <h2>출결 관리</h2>
            <div style="border-top: 5px solid #0b70b9; width: 86%;"></div>
            <div class="content_inner">
            	<form action="/attendance/attendanceList.do" method="get" id="search_mode">
	              <div>
	                <select  name="search_mode" id="search_mode">
	                	<option value="">전체</option>
	                  	<option value="강의">현재 강의 중인 강의</option>
	                </select>
	              </div>
	              </form>
              <div class="content_c">
                  <h3>[2025 수능 특강] 한병훈의 국어-화법과 작문</h3><br>
                     학생 10/20<br>
                    <button type="button" class="app_btn"><a href="<%=request.getContextPath()%>/attendance/attedanceView.do">출결관리</a></button><br>
              </div>
            </div>
            <div class="paging_inner">
				<a href="">이전</a>
                <a href="">1</a>
                <a href="">2</a>
                <a href="">다음</a>
            </div>
          </div>
        </article>
      </section>
<%@ include file="../../include/footer.jsp" %>