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
	String userNick = request.getParameter("userNick");
	
	boolean result = false;
	if(!userNick.equals("")){
	
	
	//DB에 해당 id가 존재하는지 체크
	UserDAO dao = UserDAO.getInstance();
	result = dao.confirmNick(userNick); 
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
			<td><%=userNick%>, 이미 사용중인 아이디 입니다.</td>
		</tr>
	</table>
<form action = "confirmNick.jsp" method = "post">
	<table>
		<tr>
			<td>다른 아이디를 선택하세요.<br/>
				<input type="text" name ="userNick"/>
				<input type="submit" value ="닉네임 중복확인"/>
			</td>
		</tr>
	</table>
</form>	
	<%}else{%>
	<table>
			<tr>
				<td>입력하신 <%=userNick %>는 사용가능한 아이디 입니다.<br/>
					<input type="button" value = "닫기" onclick="setUserNick()"/>
				</td>
			</tr>
	</table>
<%} %>
	<script>
		function setUserNick(){//opener는 자신을 open시킨 홈페이지
			//signupForm 페이지의 id태그에 값 변경해주기
			opener.document.inputForm.userNick.value="<%=userNick%>";	
			self.close(); //팝업창 닫기
		}
	</script>
</body>
</html>