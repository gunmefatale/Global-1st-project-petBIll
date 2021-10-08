<%@page import="pet.hos.model.HosDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hosList</title>
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
<% 
	// ** 게시글 페이지 관련 정보 세팅 **
	// 한페이지에 보여줄 게시글의 수 
	int pageSize = 10;
	
	// 현재 페이지 보여주기 
	String pageNum = request.getParameter("pageNum"); // 페이지번호가 넘어오면 꺼내서 담기.ex) 2번페이지 보여줘~
	if(pageNum == null){ // hosList.jsp 라고만 요청시, 즉 pageNum 파라미터 안넘어왔을 때.
		pageNum = "1"; // 우선 문자열로 주고받기.
	}
	
	// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅 
	int currentPage = Integer.parseInt(pageNum); // 계산을 위해 현재페이지 숫자로 변환하여 저장 
	int startRow = (currentPage - 1) * pageSize +1;// 첫번째 글 번호 계산 : 페이지 시작글 번호. 10단위로 늘어남 
	int endRow = currentPage * pageSize; // 페이지의 마지막 글번호 
	int number = 0; // 게시판 목록에 뿌려줄 가상의 글 번호 
	
	// 게시판 글 가져오기 
	HosDAO dao = HosDAO.getInstance();
	// 전체 글의 개수 가져오기
	int count = dao.getHosArticleCount(); //DB에 저장되어있는 전체 갯수 
	System.out.println("count :" + count);
	
 	// 글이 하나라도 있으면 글 다시 가져오기 
	List articleList = null; //밖에서 사용가능하게 if문 시작 전 미리선언 
	if(count > 0){
		articleList = dao.getHosArticles(startRow, endRow);
	}
	number = count - (currentPage-1)*pageSize; // 게시판 목록에 뿌려줄 가상의 글 번호  

%>
	<div align="right">
		<ul>
			<li><button onclick = "window.location = '/petBill/hospital/hosList.jsp'">병원목록</button>
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
	<div align="center">
	<br/>
	<h1 align="center"> 병원목록 </h1>
	<table border='1'>
		<tr>
			<td> No. </td>
			<td> 병원명 </td>
			<td> 지역 시 </td>
			<td> 지역 구 </td>
			<td> 도로명 주소 </td>
			<td> 평 가</td>
		</tr>
		<%for(int i = 0; i < articleList.size(); i++){
			HosDTO article = (HosDTO)articleList.get(i);
		%>
		<tr>
			<td> <%=number-- %></td>
				
			<%-- &pageNum=<%=pageNum%> 직전페이지 이동을 위해서!--%>
			<td> <a href="hosContent.jsp?hosNo=<%=article.getHosNo()%>&pageNum=<%=pageNum%>"> <%=article.getHosName() %> </a></td>
			<td> <%=article.getHosSiAddress() %> </td>
			<td> <%=article.getHosGuAddress() %> </td>
			<td> <%=article.getHosNewAddress() %> </td>
			<td> 좋아요- 그저그래요- 나빠요-</td>
		</tr>
	<% } %>
	</table>
	</div>
	
</body>
</html>