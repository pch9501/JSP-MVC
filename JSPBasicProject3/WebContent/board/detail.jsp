<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*"%>
<%
	String no=request.getParameter("no");
	String strPage=request.getParameter("page");
	// 받은 no값을 dao로 전송하자!
	BoardDAO dao=new BoardDAO();
	// dao에서 요청한 vo를 받기.
	BoardVO vo=dao.boardDetailData(Integer.parseInt(no), 0);
	// vo에 저장된 데이터를 html를 이용해서 출력하기 (body태그 안에서 출력한다)
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
	width: 600px;
}
h2{
	text-align: center;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
var i=0;
$(function(){
	$('#delBtn').click(function(){
		if(i==0)
		{
			$('#delBtn').val("취소")
			$('#del').show();
			i=1;
		}
		else
		{
			$('#delBtn').val("삭제")
			$('#del').hide();
			i=0;
		}
	});
	
	$('#sendBtn').click(function(){
		var pwd=$('#pwd').val();
		var no=$('#no').val();
		var page=$('#page').val();
		if(pwd=="")
		{
			$("#pwd").focus();
			return;
		}
		
		$.ajax({
			type:'POST',
			url:'delete.jsp',
			data:{"no":no,"pwd":pwd},
			success:function(res)
			{
				var result=res.trim();
				if(result==0)
				{
					alert("비밀번호 틀렸음");
					$('#pwd').val("");
					$('#pwd').focus();
				}
				else
				{
					location.href="list.jsp?page="+page;
				}
			}
		});
	});
});
</script>
</head>
<body>
  <div class="container">
  	<h2>내용보기</h2>
  	<div class="row">
  	  <table class="table table-hover">
  	  	<tr>
  	  	  <th width=20% class="text-center success">번호</th>
  	  	  <td width=30% class="text-center"><%=vo.getNo() %></td>
  	  	  <th width=20% class="text-center success">작성일</th>
  	  	  <td width=30% class="text-center"><%=vo.getRegdate() %></td>
  	  	</tr>
  	  	<tr>
  	  	  <th width=20% class="text-center success">이름</th>
  	  	  <td width=30% class="text-center"><%=vo.getName() %></td>
  	  	  <th width=20% class="text-center success">조회수</th>
  	  	  <td width=30% class="text-center"><%=vo.getHit() %></td>
  	  	</tr>
  	  	<tr>
  	  	  <th width=20% class="text-center success">제목</th>
  	  	  <td colspan="3" class="text-left"><%=vo.getSubject() %></td>
  	  	</tr>
  	  	<tr>
  	  	  <td colspan="4" class="text-left" valign="top" height="200">
  	  	  	<pre style="white-space: pre-wrap; background-color: white; border: none"><%=vo.getContent() %></pre>
  	  	  </td>
  	  	</tr>
  	  	<tr>
  	  	  <td colspan="4" class="text-right">
  	  	  	<a href="reply.jsp?no=<%=vo.getNo() %>&page=<%=strPage %>" class="btn btn-xs btn-success">답변</a>
  	  	  	<a href="update.jsp?no=<%=vo.getNo() %>&page=<%=strPage %>" class="btn btn-xs btn-success">수정</a>
  	  	  	<input type=button class="btn btn-xs btn-success" id="delBtn" value="삭제">
  	  	  	<a href="list.jsp?page=<%=strPage %>" class="btn btn-xs btn-info">목록</a>
  	  	  </td>
  	  	</tr>
  	  	<tr id="del" style="display:none">
  	  	  <td colspan="4" class="text-right">
  	  	    비밀번호:<input type=password id="pwd" size=10 class="input-sm">
  	  	    	<input type=hidden id="no" value="<%=no%>">
  	  	    	<input type=hidden id="page" value="<%=strPage%>">
  	  	    	<input type="submit" value="삭제" id="sendBtn" class="btn btn-sm btn-danger">
  	  	  </td>
  	  	</tr>
  	  </table>
  	</div>
  </div>
</body>
</html>