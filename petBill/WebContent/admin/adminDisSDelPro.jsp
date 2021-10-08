<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소분류 목록 삭제 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head> 
<%
	// 고유번호 꺼내기
	int subNo = Integer.parseInt(request.getParameter("subNo"));
	System.out.println("프로 탔는지 ? : " + subNo);

	// 소분류 DB에 넘겨서, 삭제시키기
	CatDAO dao = new CatDAO();
	int result = dao.deleteCatS(subNo);
	System.out.println("삭제됐음? : " + result);
%>
<%
	if(result == 1){ %>
	<script>
		alert("삭제되었습니다.");
		window.location="adminDisSModify.jsp";
	</script>
	<% }else{ %>
	
	<script>
		alert("삭제 실패!");
		history.go(-1);
	</script>
	<%}%>
<body>
</body>
</html>