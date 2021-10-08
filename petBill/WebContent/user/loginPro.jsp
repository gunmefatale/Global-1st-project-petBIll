<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	//일반 로그인 / 병원 로그인 넘어오는값 확인
	
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String auto = request.getParameter("auto");
	String login = request.getParameter("login");

	
	//넘어오는값 한번 체크
	System.out.println("userId : " + userId);
	System.out.println("userPw : "+ userPw);
	System.out.println("auto : "+ auto);
	System.out.println("login : "+ login);
	
	
	Cookie[] coos = request.getCookies();
	if(coos != null){
		for(Cookie c : coos){
			if(c.getName().equals("autoId")) userId = c.getValue();
			if(c.getName().equals("autoPw")) userPw = c.getValue();
			if(c.getName().equals("autoAuto")) auto = c.getValue();
			if(c.getName().equals("autologin")) login = c.getValue();
		}
	}

	//넘어오는값 한번 체크
	System.out.println("userId : " + userId);
	System.out.println("userPw : "+ userPw);
	System.out.println("auto : "+ auto);
	System.out.println("login : "+ login);
	
	
	UserDAO dao = UserDAO.getInstance();
	int res = dao.IdPwcheck(userId,userPw,login);
	
	 
if(login.equals("0")){//만약 일반로그인 했을경우
	if(res == 0){//값이 ture 일때
		if(auto != null){ // 자동로그인 체크를 하고 로그인 했을때 쿠키생성
			Cookie c1 = new Cookie("autoId", userId);
			Cookie c2 = new Cookie("autoPw", userPw);
			Cookie c3 = new Cookie("autoAuto", auto);
			Cookie c4 = new Cookie("autologin", login);
			
			c1.setDomain("localhost");
			c1.setPath("/petBill");
			c2.setDomain("localhost");
			c2.setPath("/petBill");
			c3.setDomain("localhost");
			c3.setPath("/petBill");
			c4.setDomain("localhost");
			c4.setPath("/petBill");
			
			c1.setMaxAge(60*60*24);
			c2.setMaxAge(60*60*24); 
			c3.setMaxAge(60*60*24);
			c4.setMaxAge(60*60*24);
			
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
			response.addCookie(c4);
		}//쿠키 
		session.setAttribute("userId", userId);//세션 생성

		%><script>
			alert("로그인 되었습니다.")
			window.location ="/petBill/search/main.jsp";
		</script>		
				
	<%}else if(res == 2){// admin 로그인
		session.setAttribute("admin", userId);//세션 생성 
		response.sendRedirect("/petBill/search/main.jsp"); %>
	<%}else {%> 
		<script>
			alert("아이디 또는 비밀번호가 일치하지 않습니다.")
			history.go(-1);
		</script>

	<%}//else
		}else{//병원 로그인 했을때
			if(res == 1){  
				if(auto != null){ 
					Cookie c1 = new Cookie("autoId", userId);
					Cookie c2 = new Cookie("autoPw", userPw); 
					Cookie c3 = new Cookie("autoAuto", auto);
					Cookie c4 = new Cookie("autologin", login);
						
					c1.setDomain("localhost");
					c1.setPath("/petBill");
					c2.setDomain("localhost");
					c2.setPath("/petBill");
					c3.setDomain("localhost");
					c3.setPath("/petBill");
					c4.setDomain("localhost");
					c4.setPath("/petBill");
						
					c1.setMaxAge(60*60*24);
					c2.setMaxAge(60*60*24);
					c3.setMaxAge(60*60*24);
					c4.setMaxAge(60*60*24);
						
					response.addCookie(c1);
					response.addCookie(c2);
					response.addCookie(c3);
					response.addCookie(c4);
				}//쿠키	
				session.setAttribute("hosId", userId);
					
				%><script>
					alert("로그인 되었습니다.")
					window.location="/petBill/search/main.jsp";
				</script>
			<%}else{//res가 false 일때%>
				<script>
					alert("아이디 또는 비밀번호가 일치하지 않습니다.")
					history.go(-1);
				</script>
			<%}
	}%>


<body>

</body>
</html>