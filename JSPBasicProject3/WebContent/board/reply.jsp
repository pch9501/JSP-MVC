<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no=request.getParameter("no");
	String strPage=request.getParameter("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<style type="text/css">
.row{
	margin: 0px auto;
	width: 600px;
}
h2{
	text-align: center;
}
</style>
</head>
<body>
  <div class="container">
  	<h2>답변하기</h2>
  	<div class="row">
  	  <form method=post action="reply_ok.jsp">
  	  <table class="table table-hover">
  	  	<tr>
  	  	  <th width=20% class="text-right success">이름</th>
  	  	  <td width=80%>
  	  	  	<input type=text name=name size=15 required>
  	  	  	<input type=hidden name=pno value="<%=no%>">
  	  	  	<input type=hidden name=page value="<%=strPage%>">
  	  	  </td>
  	  	</tr>
  	  	<tr>
  	  	  <th width=20% class="text-right success">제목</th>
  	  	  <td width=80%>
  	  	  	<input type=text name=subject size=50 required>
  	  	  </td>
  	  	</tr>
  	  	<tr>
  	  	  <th width=20% class="text-right success">내용</th>
  	  	  <td width=80%>
  	  	  	<textarea rows="8" cols="55" name=content required></textarea>
  	  	  </td>
  	  	</tr>
  	  	<tr>
  	  	  <th width=20% class="text-right success">비밀번호</th>
  	  	  <td width=80%>
  	  	  	<input type="password" name=pwd size=10 required>
  	  	  </td>
  	  	</tr>
  	  	<tr>
  	  	  <td class="text-center" colspan="2">
  	  	  	<input type="submit" value="답변" class="btn btn-sm btn-primary">
  	  	  	<input type="button" value="취소" class="btn btn-sm btn-danger" 
  	  	  	onclick="javascript:history.back()"
  	  	  	>
  	  	  </td>
  	  	</tr>
  	  </table>
  	  </form>
  	</div>
  </div>
</body>
</html>