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
		<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
		<button onclick = "window.location = '/petBill/user/userMypage.jsp'">마이페이지</button>
	</div>
	
	
	<div style="text-align : center;">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	
	
	<br/>
	<h1 align = "center">회원 비밀번호 수정</h1>
	
	<form action = "pwModiFyPro.jsp" method = "post">
	<div align = "center">
		<table>
			<tr>
				<td>기존 비밀번호<br/>
					<input type="text" name="userPw"/>
				</td>
			</tr>
			<tr>
				<td><br/>수정 비밀번호<br/>
					<input type="password" name="userPwModify"/>
				</td>
			</tr>
			<tr>
				<td><br/>수정 비밀번호 확인<br/>
					<input type="password" name="userPwModifych"/>
				</td>
			</tr>
			<tr>	
				<td><br/>
					<input type="submit" value="수정"/>
					<input type="button" value="취소" onclick= "window.location='/petBill/search/main.jsp'"/>
				</td>
			</tr>
		</table>
	</div>
	
	
	
	</form>
	
	
	

</body>
</html>