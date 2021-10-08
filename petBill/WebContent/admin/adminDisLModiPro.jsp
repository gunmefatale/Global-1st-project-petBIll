<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대분류 수정 Pro 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="pet.cat.model.CatLDTO" />
<jsp:setProperty property="*" name="article" />
<%	
	// 넘어온 고유번호 꺼내서
	int lptNo = Integer.parseInt(request.getParameter("lptNo"));	
	// System.out.println("pro lptno: " +lptNo);	

	// DB에 article 던져주며, 업데이트 시키기
	CatDAO dao = new CatDAO();
	int result = dao.updateCatL(article);
%>
</head>
<body>
	<%
		if(result == 1){%>
			<script>
				alert("수정 되었습니다");
				window.location="adminDisLModiForm.jsp";
			</script>
		<%}else{%>
			<script>
				alert("다시 시도해 주세요!");
				history.go(-1);
			</script>
	<%}%>

</body>
</html>