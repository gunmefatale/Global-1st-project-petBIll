<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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


	
<body>
	<div align="right">
		<button onclick = "window.location = 'petBill/user/logoutPro.jsp'">로그아웃</button>
		<button onclick = "window.location = 'adminUserList.jsp'">마이페이지</button>
	</div>

	<div style="text-align : center;">
			<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	
	<div class="left"  style="font-size:3.5em;">
		<table>
			<tr bgcolor="lightgray">
				<td><a href = "/petBill/admin/adminUserList.jsp">회원정보</a></td>
			</tr>
			<tr>
				<td><a href = "/petBill/admin/adminHosList.jsp">병원정보</a></td>
			</tr>
			<tr>
				<td><a href = "/petBill/admin/adminDisModify.jsp">질병정보 게시판</a></td>
			</tr>
		</table>
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
						<a href="adminDisLModiForm.jsp">
							대분류 수정
						</a>
						&nbsp;
					</td>
					<td>
						&nbsp;
						<a href="adminDisSModify.jsp">
							소분류 수정
						</a>
						&nbsp;
					</td>
				</tr>
				
			</table>
		</div>
	
</body>
</html>