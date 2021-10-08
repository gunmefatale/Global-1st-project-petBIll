<%@page import="pet.user.model.UserDAO"%>
<%@page import="pet.user.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<%
	request.setCharacterEncoding("UTF-8");

	String userPw = request.getParameter("userPw");
	String useruserPwModify = request.getParameter("userPwModify");
	String userPwch = request.getParameter("userPwModifych");
	
	String userId = (String)session.getAttribute("userId");//윶
	//String hosid = (String)session.getAttribute("hosId");
	UserDTO dto = new UserDTO();
	
	 
	UserDAO dao = UserDAO.getInstance();
	int result = dao.pwupdateUser(userId, userPw, useruserPwModify);
	
	if(result == 1){%>
		<script>
			alert("성공");
			<%session.invalidate();
			
			Cookie[] coos = request.getCookies();
			if(coos != null){
				for(Cookie c : coos){
					if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoAuto") || c.getName().equals("autologin")){
						c.setDomain("localhost");
						c.setPath("/petBill");
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}
			%>
			window.location="/petBill/search/main.jsp";
		</script>
	
	<%}else{%>
		<script>
			alert("비밀번호가 틀렸습니다.");
			history.go(-1);
		</script>
	
	<%}%>
	


</head>
<body>

</body>
</html>