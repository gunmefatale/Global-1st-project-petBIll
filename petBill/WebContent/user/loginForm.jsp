<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div align="right">
		<button onclick = "window.location = 'loginForm.jsp'">로그인</button>
		<button onclick = "window.location = 'signupMain.jsp'">회원가입</button>
	</div>
	<div style="text-align : center;">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	<br/>
	<h1 align = "center">로그인</h1>
	
	
	
	<div align="center">
	<form action = "loginPro.jsp" method = "post">
		<table>
			<tr>
				<td>
					<input type="radio" name = "login" value = "0" checked="checked"/>회원 로그인
					<input type="radio" name = "login" value = "1"/>병원 로그인
				</td>
			</tr>
			<tr>
				<td> 아이디  <br/>
					<input type = "text" name = "userId"/>
				</td>
			</tr>
			<tr>
				<td><br/>비밀번호 <br/>
					<input type = "password" name = "userPw"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type = "checkbox" name = "auto" value="1"/>자동로그인
				</td>
			</tr>
			<tr>
				<td>
					<input type = "submit" value="로그인"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type = "button" onclick = "window.location='signupMain.jsp'" value = "회원가입">
				</td>
			</tr>
			<tr>
				<td>
					<input type = "button" onclick = "window.location='findIdForm.jsp'" value = "아이디 / 비번찾기"> <%-- 기본 보여주는건 아이디 찾기 --%>
				</td>
			</tr>
		</table>
	
	
	
	
	
	</form>
	</div>
	
	
	
</body>
</html>