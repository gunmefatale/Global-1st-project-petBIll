<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대분류 삭제 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<%
	//넘어온 고유번호 꺼내기
	int lptNo = Integer.parseInt(request.getParameter("lptNo"));
	// System.out.println("deletePro lptNo : " + lptNo);
	
	// DB에 넘겨서, 삭제시키기
	CatDAO dao = new CatDAO();
	int result = dao.deleteCatL(lptNo);
	// System.out.println("result : " + result);
%>
<% 
	if(result == 1){ %>
	<script>
		alert("삭제되었습니다.");
		window.location="adminDisLModiForm.jsp";
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
