<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대분류 추가하기</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="pet.cat.model.CatLDTO" />
<jsp:setProperty property="*" name="article" />
<%	
	//System.out.println("넘어오냐 ? :" + article.getLptNo());
	// String lptName = request.getParameter("lptName");
	
	
	CatDAO dao = new CatDAO();
	int result = dao.insertCatL(article);
	//System.out.println("숫자 1 :"+result);
	
	
	
%>
<body>
	<%if(result == 1){%>
	<script>
		alert("추가 되었습니다.");
		window.location="adminDisLModiForm.jsp";
	</script>
	<%}else{%>
	<script>
		alert("추가 실패!");
		history.go(-1);
	</script>
	<%}%>
	
</body>
</html>