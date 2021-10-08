<%@page import="pet.rev.model.RevDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	//int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	//System.out.println("reviewNo : " + reviewNo);
%>
<jsp:useBean id="article" class="pet.rev.model.RevDTO" />
<jsp:setProperty property="*" name="article"/>
<%
					

	RevDAO dao = RevDAO.getInstance();
	dao.HosRef(article);
 
	response.sendRedirect("reviewContent.jsp");
%>
	
<body>
 
</body>
</html> 