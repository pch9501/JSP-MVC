<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="스크립트 요소"%>
   <%--
   		1. 스크립트릿: <% %> 일반 자바코드 코딩할때 (메소드 안에 코딩되는 내용)
   		2. 표현식: <%= %> (=out.println()) // 출력하는것이기때문에 ;을 사용하면 안된다.
   		3. 선언식: <%! %> 메소드(함수)를 만들 때 // 사용금지, 권장되지않음. / 자바파일을 만들어 호출하는게 더 편하기때문
    --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <%
  	int a=100;
  %>
  <h1><%= a %></h1>
</body>
</html>