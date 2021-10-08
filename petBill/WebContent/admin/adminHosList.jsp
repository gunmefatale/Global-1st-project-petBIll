<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.hos.model.HosDTO"%>
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			ul { list-style: none; }
			
			li { width: 1000px; display: inline; margin: 10px; }
			
			a { text-decoration: none; font-size: 28px; padding: 5px; }
			
			<%-- 링크 값을 변경하기 --%>
			a:link { color: black; }
			
			<%-- 방문 후 값을 변경 되게하는 것. --%>
			a:visited { color: turquoise; }
			
			<%-- 마우스를 올리면 값을 변경 되게 하는 것. --%>
			a:hover { background-color: yellow; }
			
			<%-- 마우스로 꾹 누르면 값의 효과 생기는 것 --%>
			a:active { color: magenta; }
			
			a:focus { background-color: lightblue; }
			
			<%-- <section> 태그 꾸며주기 --%>
			section { align: center; margin: 20; width: 640; height: 50px; padding: 15 px; background-color: floralwhite; }
			
			div.left{ width:40%; float:left; }
			div.right{ width:60%; float:right; }
			
		</style>
		
	</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 병원 전체 리스트 불러오는 메서드
	String pageNum = request.getParameter("pageNum");	
	if (pageNum == null) {								
		pageNum = "1";									
	}
	
	int hosWaitingPageSize = 3;
	int hosWaitingCurrentPage = Integer.parseInt(pageNum);
	int waitingStartRow = (hosWaitingCurrentPage - 1) * hosWaitingPageSize + 1;
	int waitingEndRow = hosWaitingCurrentPage * hosWaitingPageSize;
	
	int pageSize = 10;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	
	HosDAO dao = HosDAO.getInstance();
	HosDTO hosDto = new HosDTO();

	
	int waitingCount = dao.getHosJoinWaitingCount();
	System.out.println("병원 가입대기 수 : " + waitingCount);
	
	List hosJoinNumberList = null;
	if (waitingCount > 0) {
		hosJoinNumberList = dao.getHosJoinWaitingList(waitingStartRow, waitingEndRow);
	}
	
	int waitNumber = waitingCount - (hosWaitingCurrentPage - 1) * hosWaitingPageSize;
		
		
	int count = dao.getHosArticleCount();
	System.out.println("병원 수 count : " + count);
	
	List articleList = null;
	if (count > 0) {
		articleList = dao.getHosArticles(startRow, endRow);
	}
	
	int number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
%>
	<body>
	
		<div align="right">
	    	<ul>
	        	<li>
	            	<div align="right">
	                  
	             <% 
	             	if (session.getAttribute("hosId") != null) { 
	             %>
		                <button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
		                <button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'">마이페이지</button>
	             <%
	             	} else if (session.getAttribute("userId") != null) { 
	             %>
		                <button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
		                <button onclick = "window.location = '/petBill/user/userMypage.jsp'">마이페이지</button>
	             <% 
	             	System.out.println("admin : " + session.getAttribute("admin")); 
	             	} else if (session.getAttribute("admin") != null) { 
	             %> 
			            <button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button> 
			            <button onclick = "window.location = '/petBill/review/reivewContent.jsp'">마이페이지</button> 
	             <% 
	             	} else { 
	             %>
		                <button onclick = "window.location = '/petBill/user/loginForm.jsp'">로그인</button>
		                <button onclick = "window.location = '/petBill/user/signupMain.jsp'">회원가입</button>
	             <%
	             	} 
	             %>
	             
	           		</div>
	        	</li>
	    	</ul> 
		</div>
		
		<div style="text-align : center;">
		   <a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
      
    <br />
    <br />
    <div align="center">
    	<section>
        	<form action="adminHosResult" method="post">
            	<input type="text" name="adminHosSearch" placeholder="병원명 검색" />
            	<input type="submit" value="검색" /> 
            </form>
      	</section>
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
	<br />
	<h2 align="left">병원가입 대기 목록</h2>
	<br />
	
<%
	if (waitingCount == 0) {
%>
	<div class="right" >
		<table>
			<tr>
				<td>No.</td>
				<td>병원명</td>
				<td>시 주소</td>
				<td>구 주소</td>
				<td>가입날짜</td>
				<td>활동상태</td>
			</tr>
			<tr>
				<td colspan="3">가입대기 중인 병원회원이 없습니다.</td>
			</tr>
		</table>
	</div>
<%		
	} else {
%>		
	<div class="right" >
		<table>
			<tr>
				<td>No.</td>
				<td>병원명</td>
				<td>시 주소</td>
				<td>구 주소</td>
				<td>가입날짜</td>
				<td>활동상태</td>
			</tr>
			<tr>
				<td><%=waitingCount--%></td>
				<td><%=hosDto.getHosName()%></td>
				<td><%=hosDto.getHosSiAddress()%></td>
				<td><%=hosDto.getHosGuAddress()%></td>
				<td><%=hosDto.getHosReg()%></td>
				<td><%=hosDto.getHosActiveNum()%></td>
			</tr>
		</table>
		<br />
		<br />
	<%
		if (waitingCount > 0) {
			int waitPageBlock = 3;
			int waitPageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int waitStartPage = (int)((currentPage - 1) / waitPageBlock) * waitPageBlock + 1;
			int waitEndPage = waitStartPage + waitPageBlock - 1; 
			if (waitEndPage > waitPageCount) {
				waitEndPage = waitPageCount;
			}
			if (waitStartPage > waitPageBlock) {
	%>
				<a href="adminHosList.jsp?pageNum=<%=waitStartPage-waitPageBlock%>">&lt; &nbsp;</a>
	<%			
			}
			for (int i = waitStartPage; i <= waitEndPage; i++) {
	%>			
				<a href="adminHosList.jsp?pageNum=<%= i %>"> &nbsp; <%= i %> &nbsp; </a>			
	<%			
			}
			if (waitEndPage < waitPageCount) {
	%>
				&nbsp; <a href="adminHosList.jsp?pageNum=<%=waitStartPage+waitPageBlock %>"> &gt; </a>
	<%
			}
		}
	%>			
		
	</div>		
<%		
	}
%>	

	<br />
	<br />
	<br />
	<br />
	<h2 align="left">병원가입 전체 목록</h2>
	<br />
<%
	if (count == 0) {
%>
	<div class="right" >
		<table>
			<tr>
				<td>No.</td>
				<td>병원명</td>
				<td>시 주소</td>
				<td>구 주소</td>
				<td>전화번호</td>
				<td>활동상태</td>
			</tr>
			<tr>
				<td colspan="3">가입한 병원회원이 없습니다.</td>
			</tr>
		</table>
	</div>
<%		
	} else {
%>
	<div class="right" >
		<table>
			<tr>
				<td>No.</td>
				<td>병원명</td>
				<td>시 주소</td>
				<td>구 주소</td>
				<td>전화번호</td>
				<td>활동상태</td>
			</tr>
			<tr>
				<td><%=number--%></td>
				<td><a href="/petBill/hospital/hosContent.jsp"><%=hosDto.getHosName()%></a></td>
				<td><%=hosDto.getHosSiAddress()%></td>
				<td><%=hosDto.getHosGuAddress()%></td>
				<td><%=hosDto.getHosTel()%></td>
				<td><%=hosDto.getHosActiveNum()%></td>
			</tr>
		</table>
	</div>
<%		
	}
%>	
	<br />
	<br />
	<div align="center">
	<%
		if (count > 0) {
			int pageBlock = 5;
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1; 
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			if (startPage > pageBlock) {
	%>
				<a href="adminHosList.jsp?pageNum=<%=startPage-pageBlock%>">&lt; &nbsp;</a>			
	<%			
			}
			for (int i = startPage; i <= endPage; i++) {
	%>
				<a href="adminHosList.jsp?pageNum=<%= i %>"> &nbsp; <%= i %> &nbsp; </a>
	<%			
			}
			if (endPage < pageCount) {
	%>
				&nbsp; <a href="adminHosList.jsp?pageNum=<%=startPage+pageBlock %>"> &gt; </a>
	<%			
			}
		}
	%>
	</div>
	
	
	</body>
</html>