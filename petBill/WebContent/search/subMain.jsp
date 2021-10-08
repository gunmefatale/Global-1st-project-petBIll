<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <title>subMain</title>
	</head>
	
	<%
		// (41) subMain -> searchResult 클릭시 구 평균 뿌려줄 초기값인 '강남구' 뿌려주기 위한 페이징 처리 해주기
		String guSel = request.getParameter("guSel");
		if (guSel == null) {
			guSel = "notSelect";
		}
	%>
	<%
		String userId = (String)session.getAttribute("userId");
		System.out.println("서브 유저 아이디 : " + userId);
		String hosId = (String)session.getAttribute("hosId");
		System.out.println("서브 병원 : " + hosId);
		String admin = (String)session.getAttribute("admin");
		System.out.println("서브 관리자: " + admin);
	%>
	
	
	
	<body>

		<%-- (2) subMain Form 틀 만들기  --%>
		<div align="right">
			<ul>
				<li>
					<div align="right">
						<% if(hosId != null){%>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'">마이페이지</button>
						<%}else if(userId != null){ %>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/user/userMypage.jsp'">마이페이지</button>
						<%}else if(admin != null){%> 
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button> 
						<button onclick = "window.location = '/petBill/review/reivewContent.jsp'">마이페이지</button> 
						<%}else{ %>
						<button onclick = "window.location = '/petBill/user/loginForm.jsp'">로그인</button>
						<button onclick = "window.location = '/petBill/user/signupMain.jsp'">회원가입</button>
						<%} %> 
					</div>
				</li>
			</ul> 
		</div>
		
		
		<h1 align="center">
			<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
		</h1>
		
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
		
		<%-- (2-1) 질병정보 게시판 / 병원 진료비 게시판 / 사이트 공지사항 게시판(추후) 만들어주기. --%>
		<div align="center">
			<table>
				<tr>
					<td>
						&nbsp;
						<a href="disLargeCate.jsp">
							질병 정보
						</a>
						&nbsp;
					</td>
					<td>
						&nbsp;
						<a href="searchResult.jsp?guSel=<%=guSel%>">
							병원 진료비 정보
						</a>
						&nbsp;
					</td>
					<td>
						&nbsp;
						<a>
							사이트 공지사항(추후)
						</a>
						&nbsp;
					</td>
				</tr>
				
			</table>
		</div>
		<%-- (3) searchMain.jsp 가서 searchMain 틀 만들어주기. --%>
		
	</body>
</html>