<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	//사용자가 작성한 hosTel값을 받아서 DB에 존재여부 체크
	String hosTel = request.getParameter("hosTel");
	HosDAO dao = HosDAO.getInstance();
	boolean result = dao.confirmHosTel(hosTel);
	System.out.println(result);

%>
<body>
<% 	//hosTel 존재시 처리
	if(result == true){ %>
	<div align="center">
	<table>
		<tr>
			<td>'<%= hosTel %>' 는 이미 사용중인 전화번호입니다.</td>
		</tr>
	</table>
	<br />
	<form action="confirmHosTel.jsp" method="post">
	<table>
		<tr>
			<td>다른 전화번호를 입력해주세요.<br />
				<input type="text" name="hosTel" placeholder="'-'포함해서 입력해주세요"/>
				<input type="submit" value="중복확인"/>
			</td>
		</tr>
	</table>
	</form>
	</div>
		
<% 	}else {//전화번호 없음. 사용가능 처리 %>
		<div align="center">
		<h3>입력하신 '<%=hosTel%>' 는 등록가능한 전화번호 입니다.</h3>
		<input type="button" value="닫기" onclick="setHosTel()" />
		</div>
<%	} %>

	<script>
		function setHosTel(){
			//opener : 지금 페이지를 오픈해준 페이지(hosSignupForm.jsp)의 hosTel태그값 변경해줌.
			opener.document.hosInputForm.hosTel.value = "<%= hosTel %>";
			self.close();
		}
	</script>

</body>
</html>