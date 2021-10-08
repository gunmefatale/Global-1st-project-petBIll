<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소분류 수정 pro 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="articles" class="pet.cat.model.CatSDTO" />
<jsp:setProperty property="*" name="articles" />
<% 
	// 넘어온 고유번호 꺼내서
	int subNo = Integer.parseInt(request.getParameter("subNo"));
	// System.out.println("pro subNo : " + subNo);
	
	// DB에 articles 던져주며, 업데이트 시키기
	CatDAO dao = new CatDAO();
	int results = dao.updateCatS(articles);
%>
</head>
<body>
	<%
		if(results == 1){%>
			<script>
				alert("수정 되었습니다.");
				window.location="adminDisSModify.jsp";
			</script>
		<%}else{%>
			<script>
				alert("다시 시도해 주세요!");
				history.go(-1);
			</script>
		<%}%>
</body>
</html>