<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>	

<jsp:useBean id="dto" class = "pet.user.model.UserDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	
	String userName = request.getParameter("userName");
	String userMobile = request.getParameter("userMobile");
	
	
	
	
	UserDAO dao = UserDAO.getInstance();
	String dbid = dao.findid(userName,userMobile);

	
	if(dbid != null){%>
		<script>
			alert("아이디는 <%=dbid%> 입니다");
			window.location = "loginForm.jsp";
		</script>
			<%--response.sendRedirect("loginForm.jsp");--%>
	<%}else{%>
		<script>
			alert("아이디/비밀번호가 틀립니다");
			history.go(-1);
		</script>
	<%}

%>

<body>

</body>
</html>