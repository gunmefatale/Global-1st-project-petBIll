<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class = "pet.user.model.UserDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	//넘어 오는 값 = 휴대폰, 닉네임, 주소
	
	//세션 id값 꺼내오기
	String id = (String)session.getAttribute("userId");
	dto.setUserId(id); // id값 꺼내서 dto에 따로 추가
	
	//DB 접근
	UserDAO dao = UserDAO.getInstance();
	int result = dao.updateUser(dto);
	System.out.println("result : " + result); //1이 잘 나오는지 출력
%>
 
</head>
<body>
	<%
		if(result == 1){%>
			<script>
				alert("수정 되었습니다");
				window.location="userMypage.jsp";
			</script>
		<%}else{%>
			<script>
				alert("다시 시도해 주세요");
				history.go(-1);
			</script>
		<%}
	
	%>



</body>
</html>