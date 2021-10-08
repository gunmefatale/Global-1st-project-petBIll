<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hosDeletePro</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>

	<jsp:useBean id="hosDto" class="pet.hos.model.HosDTO"/>
	<jsp:setProperty property="*" name="hosDto"/>

<% 
	//세션삭제 
	session.invalidate();
	
	//쿠키삭제
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

	HosDAO dao = HosDAO.getInstance();
	int hosNo = Integer.parseInt(request.getParameter("hosNo"));
	String hosPw = request.getParameter("hosPw");
	int result = dao.deleteHosMember(hosNo, hosPw); 
	System.out.println("회원탈퇴 완료");
%>

<body>

	<%if(result == 1){%>
		<script>
			alert("그동안 감사했습니다. 회원탈퇴가 정상처리되었습니다.");
			window.location.href = "/petBill/search/main.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("비밀번호가 일치하지 않습니다. 다시 시도해 주세요.");
			history.go(-1);
		</script>
	<%} %>
</body>
</html>