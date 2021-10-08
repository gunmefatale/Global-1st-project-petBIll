<%@page import="pet.user.model.UserDAO"%>
<%@page import="pet.user.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userPw = request.getParameter("userPw");
	String userId = (String)session.getAttribute("userId");
%>

	  
<%
	//세션 아이디 불러오기
	UserDAO dao = UserDAO.getInstance();
	int result = dao.userDeletepw(userId, userPw);
%>	
<body>
<% if(result > 0){
	session.invalidate();
%>
	<script>
		alert("탈퇴성공");
		window.location="/petBill/search/main.jsp";
	</script>
<%}else{%>
	<script>
		alert("비밀번호가 일치하지 않습니다");
		history.go(-1);
	</script>
<%}%>


</body>
</html>