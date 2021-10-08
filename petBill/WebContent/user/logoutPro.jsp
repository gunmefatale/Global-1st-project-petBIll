<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<%
	//로그아웃
	session.invalidate(); //세션삭제
	
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
	
	response.sendRedirect("/petBill/search/main.jsp");
%>

<body>



</body>
</html>