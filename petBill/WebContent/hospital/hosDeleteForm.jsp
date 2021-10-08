<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hosDeleteForm</title>
		<style>
			ul {list-style: none;}	
			li {width: 1000px; display: inline; margin: 10px;}			
			a {text-decoration: none; font-size: 24px; padding: 5px;}
			<%-- 링크 값을 변경하기 --%>
			a:link {color: black;}			
			<%-- 방문 후 값을 변경 되게하는 것. --%>
			a:visited {color: turquoise;}			
			<%-- 마우스를 올리면 값을 변경 되게 하는 것. --%>
			a:hover {background-color: yellow;}			
			<%-- 마우스로 꾹 누르면 값의 효과 생기는 것 --%>
			a:active {color: magenta;}
			a:focus {background-color: lightblue;}			
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
			div.left{width:40%; float:left;}		
			div.right{width:60%; float:right;}			
		</style>
</head>
<% 
	request.setCharacterEncoding("UTF-8"); 
%>
	<!-- 비로그인시 접근불가 -->
<%	
	// 세션id값 없으면 로그인페이지로 이동 
	String hosId = (String)session.getAttribute("hosId");
	if(session.getAttribute("hosId") == null && session.getAttribute("userId") == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>
<% 	}else{ 	
		HosDAO dao = HosDAO.getInstance();
		//회원정보 꺼내오기
		HosDTO hosDto = dao.getHosMember(hosId);
%>
	<div align="right">
		<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
		<button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'">마이페이지</button>
	</div>
	<div align="center" class="logo">
		<a href="/petBill/search/main.jsp">
		<img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	<br />
<body>
	
<!-- ======================================상단메뉴 구분선========================================= -->
	
	<div class="left"  style="font-size:3.5em;">
		<table>
			<tr>
				<td><a href ="../hospital/hosMypage.jsp">병원회원정보</a></td>
			</tr>
			<tr>
				<td><a>1:1문의</a></td>
			</tr>
			<tr>
				<td><a>병원공지사항</a></td>
			</tr>
			<tr>
				<td><a>병원이벤트</a></td>
			</tr>
			<tr>
				<td> <a href = "../hospital/hosDeleteForm.jsp">회원탈퇴</a></td>
			</tr>
		</table>
	</div>
	
		<h1 >회원탈퇴</h1>
		<div class="right">
		<form action="hosDeletePro.jsp" method="post">
			<!-- 고유번호 보내기 -->
			<input type="hidden" name="hosNo" value="<%= hosDto.getHosNo()%>"/>
			
			<table>
				<tr>
					<td>아이디<br/>
						<p><%= hosDto.getHosId()%></p>
					</td>
				</tr>
				<tr>
					<td>병원명<br/>
						<p><%= hosDto.getHosName() %></p>
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인<br/>
					<input type="password" name="hosPw"/></td>
				</tr>
				
				<tr>	
					<td><br/>
						<input type="submit" value = "탈퇴하기"/>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
<%}//else %>
</body>
</html>