<%@page import="pet.cat.model.CatLDTO"%>
<%@page import="java.util.List"%>
<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	
	<% 
	
	// 게시글 수
	int pageSize = 4;

	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum"); // pageNum이 넘어오면 담기
	if(pageNum == null){ // pageNum이 안넘어오면 1
		pageNum = "1";
	}
	
	// 게시글 시작과 끝
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	int number = 1;
	
	// DB에서 대분류 정보 다 가져와서 밑에 화면에 뿌려주기 
	CatDAO dao = new CatDAO(); 
	List catLarge = dao.getCatLarge(startRow, endRow); 
	
	%>
	
<body>
	<div style="text-align : center;">
    	  <a href = "search//main.jsp"><img src="imgs/petbill.img.png" width="100"/></a>
	</div>
	<div align="right">	
		<table>
		<tr>
			<td> 
				<button onclick="window.location='logoutPro.jsp'"> 로그아웃 </button>
				<button onclick="window.location='userMypage.jsp'"> 마이페이지 </button>
			</td>
		</tr>	
		</table>
	</div>	

	<div align="center">
	<h1 align="center">  질병 수정(대분류) </h1>
	<table>
		<tr>
			<td>No.</td>
			<td>Name</td>
		</tr>
		<% for(int i = 0; i < catLarge.size(); i++){ 
			  CatLDTO dto = (CatLDTO)catLarge.get(i);
		%>
		<tr>
			<td><%=number++ %></td>
			<td>
				<form action="adminDisLModiPro.jsp" method="post" >
					<input type="hidden" name="lptNo" value="<%=dto.getLptNo()%>" />
					<input type="text" name="lptName" value="<%=dto.getLptName() %>" /> 
					<input type="submit" value="수정"  />
					<input type="button" value="삭제" onclick="window.location='adminDisLDelPro.jsp?lptNo=<%=dto.getLptNo()%>'"/>
				</form>
			</td>
		</tr>		
		<%} %>
		<tr>
			<td>
				<form action="adminDisLAddPro.jsp" method="post">
					<input type="text" name="lptName" />
					<input type="submit" value="추가" />
				</form>
			</td>
		</tr>
	</table>
	</div>

</body>
</html>