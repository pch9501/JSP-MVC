<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8" errorPage="error.jsp" buffer="16kb" autoFlush="true" session="true"
    info="게시판의 목록출력(20-03-09_수정)"
    %>
<%--
	page지시자: jsp파일에 대한 정보를 가지고있음.
	변환코드:
		contentType="text/html; charset=UTF-8"
		=>response.setContentType("text/html; charset=UTF-8")
		=>default: contentType="text/html; charset=ISO-8859-1"
		=>변환 형식
			HTML => text/html
			XML => text/xml
		errorPage: 에러가 있는 경우 지정한 파일로 이동
		import: 라이브러리를 읽어 올 경우, 사용자정의 클래스
		======== default: java.lang, javax.servlet.*
		****** page지시자 속성은 한번만 사용한다.
		단, import같은경우는 예외이다. 여러개를 사용가능
		ex) <%@ page import="java.io.*, java.util.*"%>
			<%@ page import="java.io.*"%>
			<%@ page import="java.util.*"%>
		buffer: 출력버퍼(HTML을 출력하는 메모리공간) => 8kb
		
--%>
<%--
	JSP주석쓰는 방식
	: <%--
	HTML 주석쓰는 방식
	: <!-- -->
	
	<% %> 안에 있는 코딩은
	자바코딩이기때문에, 자바와 같이 주석처리를 사용하면 된다.
	
	JSP란, Java Server Page => 서버에서 실행되는 자바파일
	
	1) JSP의 실행과정
	a.jsp => a_jsp.java => a_jsp.class => 실행(html)
	2) 지시자 // <%@의 형식이면 지시자이다.
	  = page지시자: JSP파일에 대한 정보
	  	ex) <%@ page 속성=값 속성=값..%>
	  = include지시자: JSP안에 다른 JSP를 첨부(조립)
	  	ex) <%@ include file=""%>
	  = 태그 라이브러리
	  	<%@ taglib prefix="" uri=""%>
	  	<c:if>
	  	<c:forEach>
	  	<c:choose>
	  	<c:set>
	  	<c:out>
	3) 자바코딩
		<% %>: 스크립트릿 - 일반 자바코딩
		<%! %>: 선언식 - 멤버변수, 메소드를 만들경우
		<%= %>: 표현식 - 화면출력 (out.println())
	3-1) 자바파일=>DB연동, VO(자바빈)
	4) 내장객체: 미리 생성된 객체
		**request: 사용자요청값,사용자정보(IP,PORT..)를 받을 때
		**response: 서버에서 응답을 할 때
		**session: 서버에서 사용자정보나 기타내용을 저장할 때
		application: 서버정보를 가지고있다.
		out: 출력버퍼에 대한 정보를 가지고있다.(메모리) // <%= %>, ${}로 대체될 것
		**pageContext: JSP와 JSP를 연결할 때 사용 => include, forward와 같은 기법을 사용
		page: this
		config: 환경설정 // web.xml에서 설정
		exception: 예외처리
	5) 에러페이지
		= 한 번에 처리 -> page지시자에 존재함(errorPage="이동할파일명")
		= 분류해서 처리 -> tomcat이 알고있어야함(web.xml)
	6) 액션태그
		<jsp:include>
		<jsp:forward>: request를 보존해야할 때 사용하는 기법.(스프링에서 자주 사용된다.)
		<jsp:useBean>: 메모리 할당 (new를 대체한다.)
		<jsp:setProperty>: 요청값을 받아서 처리
	7) EL, JSTL
	8) MVC
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>안녕하세요 jsp</h1>
  <%
  	int a=10/0;
  %>
  <%= a %>
</body>
</html>