<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<div align="right">
		<button onclick = "window.location = 'loginForm.jsp'">로그인</button>
		<button onclick = "window.location = 'signupMain.jsp'">회원가입</button>
	</div>
	
	<div style="text-align : center;">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>

	<form action="findPwPro.jsp" method="post">
		<br/>
			<table align="center">
				<tr>
					<td>회원 아이디<br/>
						<input type="text" name="userId"/>
					</td>
				</tr>
				<tr>
					<td>회원 이름<br/>
						<input type="text" name="userName"/>
					</td>
				</tr>
				<tr>
					<td>휴대폰<br/>
					<input type="text" name="userMobile" placeholder="010-0000-0000" maxlength="13"/></td>
				</tr>
				<tr>	
					<td><br/>
						<input type="submit" value="비밀번호 찾기"/>
						<input type="button" value="취소" onclick= "window.location='loginForm.jsp'"/>
					</td>
				</tr>
			</table>
	</form>
</body>
</html>