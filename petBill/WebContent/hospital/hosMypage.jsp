<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hospital Mypage</title>
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
	<jsp:useBean id="Dto" class="pet.hos.model.HosDTO"/>
	<jsp:setProperty property="*" name="Dto"/>

<body>
	<!-- 비로그인시 접근불가 -->
<%	
	// 세션id값 없으면 로그인페이지로 이동 
	String hosId = (String)session.getAttribute("hosId");
	if(hosId == null){ %>
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
	
	<h1 >회원정보</h1>
	<div >
	<form action="hosModifyForm.jsp" method="post">
		<table>
			<tr>
				<td>아이디*<br />
					<p><%=hosDto.getHosId()%></p>
				</td>
			</tr>
			<tr>
				<td>병원명*<br />
					<p><%=hosDto.getHosName()%></p>
				</td>
			</tr>
			<tr>
				<td>병원 전화번호*<br />
					<p><%=hosDto.getHosTel()%></p>
				</td>
			</tr>
			<tr>
				<td>병원 주소*<br />
					<p><%=hosDto.getHosSiAddress()%> <%=hosDto.getHosGuAddress()%><br /><br />
					   도로명 주소 : <%=hosDto.getHosNewAddress()%><br />
					   
					   지번 주소 : 
				   <% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				  	 if(hosDto.getHosOldAddress() == null) {%>
						(등록된 정보가 없습니다.)
				   <%}else{ %> 
						<%=hosDto.getHosOldAddress()%>
				   <%}%>	
				</td>
			</tr>
			<tr>
				<td>사업자등록번호<br />
					<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				  	 if(hosDto.getHosNum() == null) {%>
						(등록된 정보가 없습니다.)
				   <%}else{ %> 
						<p><%=hosDto.getHosNum()%></p>
				   <%}%>	
				</td>
			</tr>
			<tr>
				<td>영업시간<br />
					<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				  	 if(hosDto.getHosTime() == null) {%>
						(등록된 정보가 없습니다.)
				   <%}else{ %> 
						<p><%=hosDto.getHosTime()%></p>
				   <%}%>	
				</td>
			</tr>
			<tr>
				<td>병원 대표자 명<br />
					<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				  	 if(hosDto.getHosUserName() == null) {%>
						(등록된 정보가 없습니다.)
				   <%}else{ %> 
						<p><%=hosDto.getHosUserName()%></p>
				   <%}%>	
				</td>
			</tr>
			<tr>
				<td>대표자 휴대폰번호<br />
					<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				  	 if(hosDto.getHosMobile() == null) {%>
						(등록된 정보가 없습니다.)
				   <%}else{ %> 
						<p><%=hosDto.getHosMobile()%></p>
				   <%}%>	
				</td>
			</tr>
			<tr>
				<td>대표자 사진<br />
					<% if(hosDto.getHosProfile() != null) { //사진 저장된 게 있을경우 %>
						<img src="/petBill/photo/<%=hosDto.getHosProfile()%>" width="200"/><br/>
					<% }else{ //사진 저장된 게 없다! %>
						<img src="/petBill/review/imgs/default.png" width="200"/><br/>
					<% }%>
				</td>
			</tr>
			<tr>
				<td>사업자등록증 사진<br />
					<% if(hosDto.getHosNumPhoto() != null) { //사진 저장된 게 있을경우 %>
						<img src="/petBill/photo/<%=hosDto.getHosNumPhoto()%>" width="200"/><br/>
					<% }else{ //사진 저장된 게 없다! %>
						<img src="/petBill/review/imgs/default.png" width="200"/><br/>
					<% }%>
				</td>
			</tr>
			<tr>
				<td>병원장 약력<br />
					<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				  	 if(hosDto.getHosBio() == null) {%>
						(등록된 정보가 없습니다.)
				   <%}else{ %> 
						<p><%=hosDto.getHosBio()%></p>
				   <%}%>	
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정하기"> 
				</td>
			</tr>
		</table>
	</form>
	</div>
<%	} //else %>
</body>
</html>