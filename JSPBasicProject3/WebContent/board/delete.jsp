<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*"%>
<%
	String no=request.getParameter("no");
	String pwd=request.getParameter("pwd");
	// dao 연동
	BoardDAO dao=new BoardDAO();
	int res=dao.boardDelete(Integer.parseInt(no), pwd);
%>
<%=res %>