# AtemProject (teamproject_1st)
JSP/Servlet 기반의 간단한 LMS + 출결 관리 웹 애플리케이션입니다.

Front Controller 패턴으로 공지/자료실/Q&A/강의/출결/마이페이지 기능을 모듈화했고, 권한(A/T/S) 에 따라 화면과 동작이 달라집니다.


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


## 기술 스택
Backend: Java (JSP/Servlet, JDBC)

Web: JSP, HTML5, CSS3, JavaScript(jQuery)

DB: MySQL 8.x

서버/IDE: Apache Tomcat 9, Eclipse

라이브러리:
mysql-connector-j-8.4.0.jar (JDBC)
cos-05Nov2002.jar (파일 업로드)
json-simple-1.1.1.jar (경량 JSON 처리)


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


## 라우팅 개요
FrontController에서 *.do를 받아 각 Controller에서 처리 후 JSP로 forward

사용자: /user/login.do, /user/join.do, /user/logout.do

공지: /notice/notice_list.do, /notice/notice_view.do, /notice/notice_write.do, /notice/notice_modify.do, /notice/notice_delete.do

자료실: /library/library_list.do, /library/library_view.do, /library/library_write.do, /library/library_modify.do, /library/library_delete.do

Q&A: /qna/qna_list.do, /qna/qna_view.do, /qna/qna_write.do, /qna/qna_modify.do, /qna/qna_delete.do

댓글: /qna/comment_writeok.do, /qna/comment_modifyok.do, /qna/comment_deleteok.do

강의: /class/list.do, /class/view.do, /class/writer.do, /class/modify.do, /class/delete.do, /class/app_class.do

출결: /attendance/...

마이/관리자: /mypage/mypage.do, /mypage/mypage2.do, /mypage/mypage3.do(권한 변경 AJAX POST)


## 권한별 기능 요약
| 역할     | 주요 권한                                    |
| ------ | ---------------------------------------- |
| 관리자(A) | 공지/강의 CRUD, 사용자 권한 변경, 전역 관리             |
| 강사(T)  | 자료실 CRUD, Q&A 댓글 CRUD, 본인 글 수정/삭제, 출결 관리 |
| 학생(S)  | Q&A 질문 CRUD, 강의 신청/조회, 출결 확인, 마이페이지      |


