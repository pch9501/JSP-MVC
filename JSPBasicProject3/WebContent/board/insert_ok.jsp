<%@page import="com.sist.dao.BoardDAO"%>
<%@page import="com.sist.dao.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 데이터 받기
	try{
		request.setCharacterEncoding("UTF-8");
	} catch(Exception e){}

	String name=request.getParameter("name");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	String pwd=request.getParameter("pwd");
	
	BoardVO vo=new BoardVO();
	vo.setName(name);
	vo.setSubject(subject);
	vo.setContent(content);
	vo.setPwd(pwd);
	
	//dao연결
	BoardDAO dao=new BoardDAO();
	dao.boardInsert(vo);
	//목록(list.jsp)로 이동하기
	response.sendRedirect("list.jsp");
%>