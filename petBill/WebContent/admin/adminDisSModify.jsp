<%@page import="pet.cat.model.CatSDTO"%>
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
	//게시글 수
	int pageSize = 20;

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
	List catSmall = dao.getCatSmall(startRow, endRow);  
	System.out.println("catSmall : "+catSmall);
 
%>


<body>
	<div style="text-align : center;">
    	  <a href = "/petBill/search//main.jsp"><img src="/petBill/save/로고.png" width="100"/></a>
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
	<h1 align="center">  질병 수정(소분류) </h1>
	<table>
		<tr>
			<td>대분류</td>
			<td>소분류</td>
		</tr>
				<% 
					CatSDTO dto = null;
					for(int i = 0; i < catSmall.size(); i++){ 
			 		dto = (CatSDTO)catSmall.get(i); 
				%>
		<tr>
			<td><%=number++ %></td>
			<td>
				<form action="adminDisSModiForm.jsp" method="post" >
					<input type="hidden" name="subNo" value= "<%=dto.getSubNo()%>"/>
					<input type="text" name="subLptNo" value="<%=dto.getSubLptNo() %>" /> 
					<input type="text" name="subName" value="<%=dto.getSubName() %>" /> 
					<input type="submit" value="수정"  />
					<input type="button" value="삭제" onclick="window.location='adminDisSDelPro.jsp?subNo=<%=dto.getSubNo()%>'"/>
				</form>
			</td>
		</tr>
				
	<%} %>
		<tr>
			<td><input type="button" value="등록" onclick="window.location='adminDisSAddForm.jsp'"/></td>
		</tr>
		<tr>
			<td><input type="button" onclick = "window.location='adminDisModify.jsp'" value="뒤로가기"></button>
		</tr>
	</table>
	</div>
	
	
</body>
</html>