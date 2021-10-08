<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 중복확인</title>
</head>
<% 
	//사용자가 작성한 hosId값을 받아서 DB에 존재여부 체크
	String hosId = request.getParameter("hosId");
	HosDAO dao = HosDAO.getInstance();
	boolean result = dao.confirmHosId(hosId);
	System.out.println(result);

%>
<body>
<% 	//아이디 존재시 처리
	if(result == true){ %>
	<div align="center">
	<table>
		<tr>
			<td>'<%= hosId %>' 는 이미 사용중인 아이디입니다.</td>
		</tr>
	</table>
	<br />
	<form action="confirmHosId.jsp" method="post">
	<table>
		<tr>
			<td>다른 아이디를 입력해주세요.<br />
				<input type="text" name="hosId"/>
				<input type="submit" value="중복확인"/>
			</td>
		</tr>
	</table>
	</form>
	</div>
		
<% 	}else {//아이디 없음. 사용가능 처리 %>
		<div align="center">
		<h3>입력하신 '<%=hosId%>' 는 사용가능한 아이디 입니다.</h3>
		<input type="button" value="닫기" onclick="setHosId()" />
		</div>
<%	} %>

	<script>
		function setHosId(){
			//opener : 지금 페이지를 오픈해준 페이지(hosSignupForm.jsp)의 hosId태그값 변경해줌.
			opener.document.hosInputForm.hosId.value = "<%= hosId %>";
			self.close();
		}
	</script>


</body>
</html>