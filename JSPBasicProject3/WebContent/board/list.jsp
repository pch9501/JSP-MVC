<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.sist.dao.*"%>
<%
	BoardDAO dao=new BoardDAO();
	// 사용자가 요청한 페이지를 받기 시작한다.
	String strPage=request.getParameter("page");
	if(strPage==null)
		strPage="1";
	
	int curPage=Integer.parseInt(strPage);
	
	List<BoardVO> list=dao.boardListData(curPage);
	
	int count=dao.boardRowCount();
	int totalPage=(int)(Math.ceil(count/10.0));
	
	count=count-((curPage*10)-10);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<style type="text/css">
.row{
	margin: 0px auto;
	width: 800px;
}
h2{
	text-align: center;
}
</style>
</head>
<body>
  <div class="container">
  	<h2>묻고 답하기!</h2>
  	<div class="row">
  	  <table class="table">
  	  	<tr>
  	  	  <td><a href="insert.jsp" class="btn btn-sm btn-default">새 글</a></td>
  	  	</tr>
  	  </table>
  	  <table class="table table-striped">
  	  	<tr>
  	  	  <th width=10% class="text-center">번호</th>
  	  	  <th width=45% class="text-center">제목</th>
  	  	  <th width=15% class="text-center">이름</th>
  	  	  <th width=20% class="text-center">작성일</th>
  	  	  <th width=10% class="text-center">조회수</th>
  	  	</tr>
  	  	<%
  	  		for(BoardVO vo:list)
  	  		{
  	  	%>
  	  		<tr>
	  	  	  <td width=10% class="text-center"><%=count-- %></td>
	  	  	  <td width=45% class="text-left">
	  	  	  <%
	  	  	  	if(vo.getGroup_tab()>0)
	  	  	  	{
	  	  	  		for(int i=0;i<vo.getGroup_tab();i++)
	  	  	  		{
	  	  	  			out.println("&nbsp;&nbsp;");
	  	  	  		}
	  	  	  %>
	  	  	  		<img src="icon_reply.gif">
	  	  	  <%		
	  	  	  	}
	  	  	  %>
	  	  	  <%
	  	  	  	String msg="관리자가 삭제한 게시물입니다.";
	  	  	  	if(msg.equals(vo.getSubject()))
	  	  	  	{
	  	  	  %>
	  	  	  		<span style="color:#999999"><%=vo.getSubject() %></span>
	  	  	  <%		
	  	  	  	}
	  	  	  	else
	  	  	  	{	  		
	  	  	  %>
	  	  	  		<a href="detail.jsp?no=<%=vo.getNo()%>&page=<%=curPage%>"><%=vo.getSubject() %></a>
	  	  	  <%
	  	  	  		String today=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	  	  	  		if(today.equals(vo.getRegdate().toString()))
	  	  	  		{
	  	  	  %>
	  	  	  			<sup><img src="new.gif"></sup>
	  	  	  <%
	  	  	  		}
	  	  	  	}
	  	  	  %>
	  	  	  </td>
	  	  	  <td width=15% class="text-center"><%=vo.getName() %></td>
	  	  	  <td width=20% class="text-center"><%=vo.getRegdate() %></td>
	  	  	  <td width=10% class="text-center"><%=vo.getHit() %></td>
	  	  	</tr>	
  	  	<%		
  	  		}
  	  	%>
  	  </table>
  	  <table class="table">
  	  	<tr>
  	  	  <td class="text-center">
  	  	  	<a href="list.jsp?page=<%=curPage>1?curPage-1:curPage %>" class="btn btn-sm btn-default">이전</a>
  	  	  	<%=curPage %> page / <%=totalPage %> pages
  	  	  	<a href="list.jsp?page=<%=curPage<totalPage?curPage+1:curPage %>" class="btn btn-sm btn-default">다음</a>
  	  	  </td>
  	  	</tr>
  	  </table>
  	</div>
  </div>
</body>
</html>