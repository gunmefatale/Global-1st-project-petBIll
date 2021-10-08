<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>hosContent</title>
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
		</style>
</head>

<%-- <%
	// 세션 hosId값 없으면 로그인페이지로 이동 
	if(session.getAttribute("userId") == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>	
<% 	}else if(session.getAttribute("hosId") == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>	

<%	// 세션 hosId값 있을경우 보이기 
	}else{   --%>
<%
		request.setCharacterEncoding("UTF-8");
		//String replaceAll(".0", ""); 문자열에서 .0 지우기
		
	
		int hosNo = Integer.parseInt(request.getParameter("hosNo"));
		System.out.println("hosNo = "+ hosNo);
		String pageNum = request.getParameter("pageNum");
		System.out.println("pageNum ="+ pageNum);
	
		// 글 고유번호 주고 해당글에대한 내용 DB에서 가져오기 
		HosDAO dao = HosDAO.getInstance();
		HosDTO article = dao.getHosArticle(hosNo);
		
		//세션
		String userId = (String)session.getAttribute("userId");
		String hosId = (String)session.getAttribute("hosId");
		String admin = (String)session.getAttribute("admin");
%>

<body>
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
		
	<div align="center" class="logo">
		<!-- 메인 로고 -->
		<a href="/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	
<!-- ======================================상단메뉴 구분선========================================= -->
	
	<br />
	<h1 align="center"> <%=article.getHosName() %> </h1>
	<div align="center">
	<table border="1">
		<tr>
			<td > 대표자 사진 <br />
			<%if(article.getHosProfile() == null || article.getHosProfile().equals("none")){%>
				<img src="/petBill/review/imgs/default.png" width="200"/><br/>
			<%}else{%>
				<img src="/petBill/photo/<%=article.getHosProfile()%>" width="200"/><br/>
		  	<%}%>
		  	</td>
		</tr>
		<tr>
			<td > 병원장 약력 <br />
			<b><%=article.getHosBio() %> </b> </td>
		</tr>
		<tr>
			<td > 병원주소 <br />
			<b> 지역 : <%=article.getHosSiAddress() %> <%=article.getHosGuAddress() %> <br />
				<%=article.getHosNewAddress() %>	</b></td>
		</tr>
		<tr>
			<td > 전화번호 <br />
			<b><%=article.getHosTel()  %> </b> </td>
		</tr>
		<tr>
			<td > 운영시간 <br />
			<b><%=article.getHosTime() %> </b> </td>
		</tr>
	</table>
	</div>
	
	<br />
	<h1 align="center"> 진료비 평균 </h1>
	<div align="center">
		<table border="1">
			<tr>
				<td>기초접종</td>
				<td>중성화 (남)</td>
				<td>중성화 (여)</td>
				<td>심장사상충</td>
			</tr>
			<tr>
				<td><%=article.getHosBasicVaccin()%> 원 </td>
				<td><%=article.getHosNeuteringMan()%> 원 </td>
				<td><%=article.getHosNeuteringWoman()%> 원 </td>
				<td><%=article.getHosHeartWorm()%>원 </td>
			</tr>
		</table>
	</div>
	
	
	<br/>
	<h1 align="center"> 후기목록 </h1>
	<div align="center">
	<table border="1">
		<tr>
			<td>번호</td>	
			<td>제목</td>
			<td>닉네임</td>
			<td>품  종</td>
			<td>평  가</td>
		</tr>
		<tr>
			<td>1</td>
			<td><a href="/petBill/review/reviewContent.jsp?hosNo=?">만족합니다.</a></td>
			<td>라니</td>
			<td>코리안숏헤어</td>
			<td>좋아요</td>
		</tr>
		<tr >
			<td colspan="5" align="right">
			<%if(session.getAttribute("userId") != null){ %>
				<button onclick="window.location='/petBill/review/reviewWriteForm.jsp?hosNo='">후기등록</button>
			<%}else if(session.getAttribute("admin")!=null){%>
				<button onclick="window.location='/petBill/review/reviewDeleteForm.jsp?hosNo=?'">삭제</button>
			<%} %>
			</td>
		</tr>
	</table>
	
	
	</div>
</body>
</html>