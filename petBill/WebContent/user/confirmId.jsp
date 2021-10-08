<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 

	//주소 뒤에 붙어온 파라미터 꺼내기
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
	System.out.println("userId :" + userId);
	
	boolean result = false;
	if(!userId.equals("")){
	
	//DB에 해당 id가 존재하는지 체크
	UserDAO dao = UserDAO.getInstance();
	result = dao.confirmId(userId);
	}else{%>
		<script>
			alert("다시 입력하세요");
			history.go(-1);
		</script>
	<%}
%>

<body>
	<br/>
<%
	if(result){//id가 존재하면%>
	<table>
		<tr>
			<td><%=userId%>, 이미 사용중인 아이디 입니다.</td>
		</tr>
	</table>
<form action = "confirmId.jsp" method = "post">
	<table>
		<tr>
			<td>다른 아이디를 선택하세요.<br/>
				<input type="text" name ="userId"/>
				<input type="submit" value ="아이디 중복확인"/>
			</td>
		</tr>
	</table>
</form>	
	<%}else{%>
	<table>
			<tr>
				<td>입력하신 <%=userId %>는 사용가능한 아이디 입니다.<br/>
					<input type="button" value = "닫기" onclick="setUserId()"/>
				</td>
			</tr>
	</table>
<%} %>
	<script>
		function setUserId(){//opener는 자신을 open시킨 홈페이지
			//signupForm 페이지의 id태그에 값 변경해주기
			opener.document.inputForm.userId.value="<%=userId%>";	
			self.close(); //팝업창 닫기
		}
	</script>
</body>
</html>