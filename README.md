# AtemProject (teamproject_1st)
JSP/Servlet 기반의 간단한 LMS + 출결 관리 웹 애플리케이션입니다.

Front Controller 패턴으로 공지/자료실/Q&A/강의/출결/마이페이지 기능을 모듈화했고, 권한(A/T/S) 에 따라 화면과 동작이 달라집니다.

 ---
## 핵심 기능
인증/세션

로그인/로그아웃, 세션에 loginUser 저장

권한: A(관리자) / T(강사) / S(학생)

공지사항 (관리자)

목록/상세/등록/수정/삭제

관리자만 작성·수정·삭제 가능

자료실 (강사, 파일 업로드)

목록/상세/등록/수정/삭제

COS 라이브러리로 파일 업로드, /upload 저장

Q&A (학생 질문, 강사 답변)

학생: 질문(게시글) CRUD

강사: 댓글(답변) CRUD (일부 AJAX 수정 반영)

강의/수강신청/출결

관리자: 강의 등록/수정/삭제

학생: 강의 상세에서 수강신청

출결 관련 화면 분리(강사/학생)

마이페이지 & 관리자 페이지

내 정보 및 수강중·종료 강의

관리자: 사용자 목록 페이징 + 권한 변경(AJAX)

---
## 기술 스택
Backend: Java (JSP/Servlet, JDBC)

Web: JSP, HTML5, CSS3, JavaScript(jQuery)

DB: MySQL 8.x

서버/IDE: Apache Tomcat 9, Eclipse

라이브러리:
mysql-connector-j-8.4.0.jar (JDBC)
cos-05Nov2002.jar (파일 업로드)
json-simple-1.1.1.jar (경량 JSON 처리)

---
## 프로젝트 구조
```text
.
├─ LICENSE
├─ README.md
├─ ppt/
│  └─ (발표 자료 .pptx)
├─ project_structure.txt
└─ teamproject_1st
   ├─ build/
   │  └─ classes/
   ├─ document/
   │  └─ SQL/
   │     ├─ DB.sql                 # 초기 스키마/샘플데이터
   │     └─ NewFile.html
   └─ src/
      └─ main/
         ├─ java/
         │  └─ FrontController/
         │     ├─ FrontController.java          # 진입점(라우팅)
         │     ├─ AttendanceController.java     # 출결
         │     ├─ ClassController.java          # 강의/수강신청
         │     ├─ IndexLibraryController.java   # 메인-자료실 섹션
         │     ├─ IndexNoticeController.java    # 메인-공지 섹션
         │     ├─ MyPageController.java         # 마이페이지/관리자
         │     ├─ SearchController.java         # 통합 검색
         │     ├─ UserController.java           # 사용자/세션
         │     ├─ library_controller.java       # 자료실
         │     ├─ notice_controller.java        # 공지
         │     ├─ qna_controller.java           # Q&A
         │     ├─ util/
         │     │  ├─ DBConn.java                # JDBC 연결 헬퍼
         │     │  └─ PagingUtil.java            # 공통 페이징
         │     └─ vo/                           # VO(DTO)
         │        ├─ UserVO.java
         │        ├─ ClassVO.java
         │        ├─ App_classVO.java
         │        ├─ AttendanceVO.java
         │        ├─ NoticeVO.java
         │        ├─ libraryVO.java
         │        ├─ qnaVO.java
         │        ├─ commentVO.java
         │        └─ SearchVO.java
         └─ webapp/
            ├─ META-INF/
            │  └─ MANIFEST.MF
            ├─ WEB-INF/
            │  ├─ web.xml                       # *.do 매핑(FrontController)
            │  ├─ lib/
            │  │  ├─ cos-05Nov2002.jar
            │  │  ├─ json-simple-1.1.1.jar
            │  │  └─ mysql-connector-j-8.4.0.jar
            │  ├─ attendance/
            │  │  ├─ attendanceCheck.jsp
            │  │  ├─ attendanceClass.jsp
            │  │  ├─ attendanceInfoView.jsp
            │  │  ├─ attendanceList.jsp
            │  │  └─ attendanceView.jsp
            │  ├─ class/
            │  │  ├─ class_add.jsp
            │  │  ├─ class_list.jsp
            │  │  ├─ class_modify.jsp
            │  │  ├─ class_view.jsp
            │  │  └─ teacher_view.jsp
            │  ├─ index_search/index_search.jsp
            │  ├─ library_board/
            │  │  ├─ library_list.jsp
            │  │  ├─ library_modify.jsp
            │  │  ├─ library_view.jsp
            │  │  └─ library_write.jsp
            │  ├─ notice_board/
            │  │  ├─ notice_list.jsp
            │  │  ├─ notice_modify.jsp
            │  │  ├─ notice_view.jsp
            │  │  └─ notice_write.jsp
            │  ├─ qna_board/
            │  │  ├─ qna_list.jsp
            │  │  ├─ qna_modify.jsp
            │  │  ├─ qna_view.jsp
            │  │  └─ qna_write.jsp
            │  └─ user/
            │     ├─ join.jsp
            │     ├─ login.jsp
            │     └─ logout.jsp
            ├─ include/
            │  ├─ header.jsp
            │  └─ footer.jsp
            ├─ index.jsp                         # 메인
            ├─ js/jquery-3.7.1.js
            ├─ teamProject.erm                   # ERD
            └─ upload/                           # 업로드 저장소
```
---
## 데이터 모델(VO 기준 개요)

UserVO : 사용자(uno, id, pw, name, email, phone, authorization(A/T/S), …) 

ClassVO : 강의(cno, title, subject, name(강사), difficult, book, 기간 등, 파일명 등)

App_classVO : 수강신청(학생–강의 매핑)

AttendanceVO : 출결(학생–강의–일자–상태)

NoticeVO : 공지

libraryVO : 자료실

qnaVO / commentVO : Q&A 본문/댓글

SearchVO : 통합검색 결과 DTO

---

## 라우팅 개요

라우팅 구조(Front Controller)
모든 요청은 FrontController를 통해 서브 컨트롤러(모듈)로 위임됩니다.
URL 패턴은 /모듈/핸들러.do 형태이며, JSP는 WEB-INF 하위로 직접 접근을 막고 컨트롤러가 forward 합니다.

사용자(User)
GET /user/login.do → user/login.jsp

POST /user/login.do → 로그인 처리, 세션 loginUser 저장

GET /user/logout.do → 세션 무효화

GET /user/join.do → user/join.jsp

POST /user/join.do → 회원가입 처리

GET /user/checkid.do?id=… → 아이디 중복 체크 (AJAX, "isid"|"isNotId")

GET /user/checkEmail.do?email=… → 이메일 중복 체크 (AJAX)

강의(Class)
GET /class/list.do → 강의 목록(검색/페이징) → class/class_list.jsp

GET /class/view.do?cno=… → 강의 상세 → class/class_view.jsp

GET /class/writer.do → (권한 A) 등록 폼 → class/class_add.jsp

POST /class/writer.do → 강의 등록(파일 업로드 포함)

GET /class/modify.do?cno=… → (권한 A) 수정 폼 → class/class_modify.jsp

POST /class/modify.do → 수정 처리

POST /class/delete.do → 삭제

POST /class/app_class.do → (권한 S) 수강신청

공지(Notice)

GET /notice/notice_list.do

GET /notice/notice_view.do?nno=…

GET /notice/notice_write.do (권한 A)

POST /notice/notice_write.do

GET /notice/notice_modify.do?nno=… (권한 A)

POST /notice/notice_modify.do

POST /notice/notice_delete.do

자료실(Library)

GET /library/library_list.do (검색/페이징)

GET /library/library_view.do?lno=…

GET /library/library_write.do (권한 T)

POST /library/library_write.do (파일 업로드)

GET /library/library_modify.do?lno=… (작성자 본인)

POST /library/library_modify.do

POST /library/library_delete.do

Q&A
GET /qna/qna_list.do (검색/페이징)

GET /qna/qna_view.do?qno=…

GET /qna/qna_write.do (권한 S)

POST /qna/qna_write.do

GET /qna/qna_modify.do?qno=… (작성자 본인)

POST /qna/qna_modify.do

POST /qna/qna_delete.do

댓글(권한 T)
POST /qna/comment_writeok.do

POST /qna/comment_modifyok.do (작성자 본인, AJAX 응답 "OK")

POST /qna/comment_deleteok.do

통합검색
GET /search.do?search=…&indexSearch=… → index_search/index_search.jsp

마이페이지
GET /mypage/mypage.do → 기본 정보/이메일·연락처 수정 폼

POST /mypage/mypage.do → 이메일/연락처 업데이트 (action=modifyEmail|modifyPhone)

GET /mypage/mypage2.do → 수강 중/종료 강의 목록

GET /mypage/mypage3.do → (권한 A) 권한 관리 + 페이징/검색

POST /mypage/mypage3.do → (권한 A) AJAX 권한 변경 { id, authority }

---
## 출결(Attendance) 모듈 — 자세한 흐름

SP 구성과 프로젝트 전반의 라우팅 규칙을 바탕으로, 출결 기능의 유저 흐름과 엔드포인트/파라미터/권한 요구사항을 아래처럼 정리했습니다.
관련 JSP
WEB-INF/attendance/attendanceList.jsp : 출결 메인(강의/기간 검색, 리스트)
WEB-INF/attendance/attendanceClass.jsp : 특정 강의의 수강생/출결 개요
WEB-INF/attendance/attendanceView.jsp : 특정 수강생의 출결 상세(캘린더/일자별 상태)
WEB-INF/attendance/attendanceCheck.jsp : (강사용) 일자별 출결 체크 폼
WEB-INF/attendance/attendanceInfoView.jsp : 종합 요약(출결 통계/요약 카드)
권한
강사(T): 출결 등록/수정 가능
학생(S): 자신의 출결 조회만 가능
관리자(A): 전반 조회/관리 가능
추정 엔드포인트 (컨트롤러 디스패치 기반)
GET /attendance/list.do
용도: 출결 대시보드/검색(강의, 기간, 상태 필터)
뷰: attendanceList.jsp
파라미터 예: subject, cno, startDate, endDate, status(P/A/L)
GET /attendance/class.do?cno=…
용도: 특정 강의의 수강생 목록과 최근 출결 요약
뷰: attendanceClass.jsp
GET /attendance/view.do?cno=…&uno=…
용도: 특정 수강생의 출결 상세(한 강의 기준)
뷰: attendanceView.jsp
GET /attendance/check.do?cno=…&date=…
용도: (강사) 특정 날짜의 해당 강의 출결 체크 폼 로드
뷰: attendanceCheck.jsp
POST /attendance/check.do
용도: (강사) 일괄 출결 저장/수정
폼데이터 예: cno, date, attendance[uno]=P|A|L…
처리 후: /attendance/class.do?cno=… 또는 /attendance/view.do?cno=…&uno=… 리다이렉트
GET /attendance/info.do?cno=…
용도: (관리자/강사) 출결 통계(지각/결석 횟수, 출석률 등)
뷰: attendanceInfoView.jsp
데이터 모델 (VO/테이블 개념)
AttendanceVO(예시): ano(PK), cno, uno, adate(date), status(‘P’ 출석, ‘A’ 결석, ‘L’ 지각), memo
연동: UserVO(uno), ClassVO(cno), 수강신청 App_classVO(uno,cno)
화면 흐름 예시
강사 T가 로그인 → 출결 목록 /attendance/list.do → 기간/강의 필터
강좌 선택 → /attendance/class.do?cno=10
특정 날짜 체크 → /attendance/check.do?cno=10&date=2025-10-02
학생별 라디오/셀렉트: P/A/L 입력 후 저장(POST)
학생별 상세 확인 → /attendance/view.do?cno=10&uno=501
통계 확인 → /attendance/info.do?cno=10 (출석률, 결석 상위자 등)

---

## 권한별 기능 요약

| 역할     | 주요 권한                                    |
| ------ | ---------------------------------------- |
| 관리자(A) | 공지/강의 CRUD, 사용자 권한 변경, 전역 관리             |
| 강사(T)  | 자료실 CRUD, Q&A 댓글 CRUD, 본인 글 수정/삭제, 출결 관리 |
| 학생(S)  | Q&A 질문 CRUD, 강의 신청/조회, 출결 확인, 마이페이지      |

---

