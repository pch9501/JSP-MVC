<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.sist.dao.*"%>
<%
	List<MusicVO> list=MusicDAO.musicAllData();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
   	 <h1 class="text-center">음악이다</h1>
   	 <div class="row">
   	 	<%
   	 		for(MusicVO vo:list)
   	 		{
   	 	%>
   	 			<div class="col-md-4">
      				<div class="thumbnail">
        				<a href="#" target="_blank">
         					<img src="<%=vo.getPoster() %>" alt="Nature" style="width:100%">
          					<div class="caption">
            					<p><%=vo.getTitle() %></p>
          					</div>
        				</a>
      				</div>
    			</div>
   	 	<%		
   	 		}
   	 	%>
   	 </div>
   </div>
</body>
</html>