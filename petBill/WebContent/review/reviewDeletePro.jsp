<%@page import="pet.rev.model.RevDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="dto" class = "pet.rev.model.RevDTO"/>


 
<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String userPw = request.getParameter("userPw");
	int reviewno = Integer.parseInt(request.getParameter("reviewno"));
	 System.out.println("reviewno" + reviewno);
	 System.out.println("userPw" + userPw);
	
	RevDAO dao = RevDAO.getInstance();
	
	int result = dao.deleteReview(userId, userPw, reviewno);
	 System.out.println("야"+result);
 	
	if(result == 1){ %>

		<script>
			alert("삭제완료"); 
			window.location = "/petBill/search/main.jsp";
		</script>
	<%}else{%>
		<script>
			alert("실패");
			history.go(-1);
		</script>
<%} %>
<body>

</body>
</html>