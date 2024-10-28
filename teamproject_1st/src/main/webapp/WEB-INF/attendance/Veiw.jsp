<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
      <section>
        <article>
          <div class="article_inner">
            <h2>출결 관리</h2>
            <div style="border-top:  5px solid #0b70b9; width: 86%;" ></div>
            <div class="content_inner">
              <table>
                <thead>
                  <tr>
                    <td style="width: 40px;"><input type="checkbox"></td>
                    <td style="width: 40px;">번호</td>
                    <td style="width: 40px;">이름</td>
                    <td style="width: 40px;">출결구분</td>
                    <td>출결상태</td>
                  </tr>
                </thead>
                <tbody>
                  <form>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">1</td>
                      <td style="width: 40px;">홍길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                          <input type="submit" class="attendance_btn1" value="출석">
                          <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">2</td>
                      <td style="width: 40px;">정길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">3</td>
                      <td style="width: 40px;">청길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">4</td>
                      <td style="width: 40px;">황길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">5</td>
                      <td style="width: 40px;">김길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">6</td>
                      <td style="width: 40px;">박길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">7</td>
                      <td style="width: 40px;">양길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">8</td>
                      <td style="width: 40px;">수길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">9</td>
                      <td style="width: 40px;">백길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 40px;"><input type="checkbox"></td>
                      <td style="width: 40px;">10</td>
                      <td style="width: 40px;">전길동</td>
                      <td>출석</td>
                      <td>
                        <div class="check_button">
                          <label>
                            <input type="submit" class="attendance_btn1" value="출석">
                            <input type="submit" class="attendance_btn1" value="지각">
                          </label>
                        </div>
                      </td>
                    </tr>
                </tbody>
              </table>
              <div class="button">
                <label>
                  <input type="submit" class="attendance_btn1" value="출석">
                  <input type="submit" class="attendance_btn1" value="지각">
                  <input type="submit" class="attendance_btn1" value="조퇴">
                  <input type="submit" class="attendance_btn1" value="결석">
                  <input type="submit" class="attendance_btn1" value="병결">
                </label>
                </div>
            </form>
            </div>
          </div>
        </article>
      </section>
<%@ include file="../../include/footer.jsp" %>