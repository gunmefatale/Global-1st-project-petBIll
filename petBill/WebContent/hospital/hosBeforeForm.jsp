<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Before Form</title>
	<style>
			ul {list-style: none;}
			li {width: 1000px; display: inline; margin: 10px;}
			a {text-decoration: none; font-size: 24px; padding: 5px;}
			<%-- 링크 값을 변경하기 --%>
			a:link {color: black;}
			<%-- 방문 후 값을 변경 되게하는 것. --%>
			a:visited {color: turquoise;}
	</style>
</head>

		<div align="right">
			<ul>
				<li>
					<a href="/petBill/user/loginForm.jsp">
						로그인
					</a>
					&nbsp;
					&nbsp;
					<a href="/petBill/user/signupMain.jsp">
						회원가입
					</a>
				</li>
			</ul>
		</div>
		
		<div align="center" class="logo">
			<!-- 메인 로고 -->
			<a href="/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
		</div>

<body>

	<h1 align="center">병원검색</h1>
	<div align="center">
	<form action="hosBeforePro.jsp" method="post" name="hosBeforeInputForm">
		<table>
		<tr>
			<td>병원 전화번호 입력<br />
			<input type="text" name="hosTel" placeholder="02-1234-1234"/>
			<input type="submit" value="검색"/>
			</td>
		</tr>
		</table>
	</form>
	</div>

</body>
</html>