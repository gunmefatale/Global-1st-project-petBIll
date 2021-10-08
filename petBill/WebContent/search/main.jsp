<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
   
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
		
		<style>
			ul {
				list-style: none;
			}
			
			li {
				width: 1000px;
				display: inline;
				margin: 10px;
			}
			
			a {
				text-decoration: none;
				font-size: 24px;
				padding: 5px;
			}
			<%-- 링크 값을 변경하기 --%>
			a:link {
				color: black;
			}
			
			<%-- 방문 후 값을 변경 되게하는 것. --%>
			a:visited {
				color: turquoise;
			}
			
			<%-- 마우스를 올리면 값을 변경 되게 하는 것. --%>
			a:hover {
				background-color: yellow;
			}
			
			<%-- 마우스로 꾹 누르면 값의 효과 생기는 것 --%>
			a:active {
				color: magenta;
			}
			a:focus {
				background-color: lightblue;
			}
			
			<%-- <section> 태그 꾸며주기 --%>
			section {
				align: center;
				margin: 20;
				width: 640;
				height: 50px;
				padding: 15 px;
				background-color: floralwhite;
			}
			<%-- 
				<input> 태그 꾸며주기 
			input {
				width: 300px;
				height: 30px;
				font-size: 20px;
			}
			--%>
		</style>
   
	<%
		request.setCharacterEncoding("UTF-8");
		
		if(session.getAttribute("userId") == null && session.getAttribute("hosId") == null){
			
			String userId = null, userPw = null, auto = null, login = null;
			Cookie [] coos = request.getCookies();
			if(coos != null){
				for(Cookie c : coos){
					if(c.getName().equals("autoId")) { userId = c.getValue();}
					if(c.getName().equals("autoPw")) { userPw = c.getValue();}
					if(c.getName().equals("autoAuto")) { auto = c.getValue();}
					if(c.getName().equals("autologin")) { login = c.getValue();}
				}
			}
			if(auto != null && userId != null && userPw != null && login != null){
				response.sendRedirect("/petBill/user/loginPro.jsp");
			}
		}
	%>
		
<body>

		<%-- (1) main Form 틀 만들기  --%>
		<div align="right">
			<ul>
				<li>
					<div align="right">
						
						<% if(session.getAttribute("hosId")!= null){%>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'">마이페이지</button>
						<%}else if(session.getAttribute("userId")!= null){ %>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/user/userMypage.jsp'">마이페이지</button>
						<%System.out.println("admin : " + session.getAttribute("admin")); %> 
						<%}else if(session.getAttribute("admin") != null){%> 
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button> 
						<button onclick = "window.location = '/petBill/admin/adminUserList.jsp'">마이페이지</button> 
						<%}else{ %>
						<button onclick = "window.location = '/petBill/user/loginForm.jsp'">로그인</button>
						<button onclick = "window.location = '/petBill/user/signupMain.jsp'">회원가입</button>
						<%} %>
					</div>
				</li>
			</ul> 
		</div>  
		
		
		<div style="text-align : center;">
			<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
		</div>
		
		</h1>
		<br />
		<br />
		<%-- (1-1) search(검색)form 만들기. --%>
		<div align="center">
			<section>
				<form action="searchMain.jsp" method="post">
					<input type="text" name="mainHosSearch" placeholder="병원명 / 지역 구 검색" />
					<input type="submit" value="검색" /> 
				</form>
			</section>
		</div>
		
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		
		<%-- (1-2) 강아지 / 고양이 게시판 만들기. --%>
		<div align="center">
			<table>
				<tr>
					<td>
						&nbsp;
						<a href="subMain.jsp">
							고양이(1)
						</a>
						&nbsp;
					</td>
					<td>
						&nbsp;
						<a>
							강아지(0)
						</a>
						&nbsp;
					</td>
				</tr>
				
			</table>
		</div>
		<%-- (2) subMain.jsp 가서 subMain 폼 만들어 주기. --%>
		
	</body>

</html>