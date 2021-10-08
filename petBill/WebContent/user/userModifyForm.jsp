<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<%
	String id = (String)session.getAttribute("userId");
	
	UserDAO dao = UserDAO.getInstance();
	UserDTO user = dao.getUser(id); 
	
%>


<body>
	<div align="right">
		<button onclick = "window.location = 'logoutPro.jsp'">로그아웃</button>
		<button onclick = "window.location = 'userMypage.jsp'">마이페이지</button>
	</div>
	
	
	<div style="text-align : center;">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	 
	
	<br/>
		<h1 align = "center">정보 수정</h1>
		<form action="userModifyPro.jsp" method="post">
			<br/>
			<table align="center">
				<tr>
					<td>아이디<br/>
						<%=user.getUserId()%>
					</td>
				</tr>
				<tr>
					<td><br/>
						비밀번호 : <input type="button" onclick = "window.location='pwModifyForm.jsp'"value="수정"/>
					</td>
				</tr>
				<tr>
					<td><br/>이름<br/>
						<%=user.getUserName()%>
					</td>
				</tr>
				<tr>
					<td><br/>휴대폰<br/>
						<input type="text" name="userMobile" value = "<%=user.getUserMobile()%>" placeholder="010-0000-0000" maxlength="13"/>
					</td>
				</tr>
				<tr>
					<td><br/>닉네임<br/>
						<input type="text" name="userNick" value = "<%=user.getUserNick()%>"/>&nbsp;<input type="button" value="중복 체크"/>
					</td>
				</tr>
				<tr>
					<td><br/>주소<br/>
						<select name="userSiAddress">
							<option value="서울특별시">서울특별시</option>	
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<select name="userSelectAddress"> 
						 	<option value="종로구"<%=user.getUserSelectAddress().equals("종로구")?" selected":""%>>종로구</OPTION>
						 	<option value="중구"<%=user.getUserSelectAddress().equals("중구")?" selected":""%>>중구</OPTION>
						 	<option value="용산구"<%=user.getUserSelectAddress().equals("용산구")?" selected":""%>>용산구</OPTION>
						 	<option value="성동구"<%=user.getUserSelectAddress().equals("성동구")?" selected":""%>>성동구</OPTION>
						 	<option value="광진구"<%=user.getUserSelectAddress().equals("광진구")?" selected":""%>>광진구</OPTION>
						 	<option value="동대문구"<%=user.getUserSelectAddress().equals("동대문구")?" selected":""%>>동대문구</OPTION>
						 	<option value="중랑구"<%=user.getUserSelectAddress().equals("중랑구")?" selected":""%>>중랑구</OPTION>
						 	<option value="성북구"<%=user.getUserSelectAddress().equals("성북구")?" selected":""%>>성북구</OPTION>
						 	<option value="강북구"<%=user.getUserSelectAddress().equals("강북구")?" selected":""%>>강북구</OPTION>
						 	<option value="도봉구"<%=user.getUserSelectAddress().equals("도봉구")?" selected":""%>>도봉구</OPTION>
						 	<option value="노원구"<%=user.getUserSelectAddress().equals("노원구")?" selected":""%>>노원구</OPTION>
						 	<option value="은평구"<%=user.getUserSelectAddress().equals("은평구")?" selected":""%>>은평구</OPTION>
						 	<option value="서대문구"<%=user.getUserSelectAddress().equals("서대문구")?" selected":""%>>서대문구</OPTION>
						 	<option value="마포구"<%=user.getUserSelectAddress().equals("마포구")?" selected":""%>>마포구</OPTION>
						 	<option value="양천구"<%=user.getUserSelectAddress().equals("양천구")?" selected":""%>>양천구</OPTION>
						 	<option value="강서구"<%=user.getUserSelectAddress().equals("강서구")?" selected":""%>>강서구</OPTION>
						 	<option value="구로구"<%=user.getUserSelectAddress().equals("구로구")?" selected":""%>>구로구</OPTION>
						 	<option value="금천구"<%=user.getUserSelectAddress().equals("금천구")?" selected":""%>>금천구</OPTION>
						 	<option value="영등포구"<%=user.getUserSelectAddress().equals("영등포구")?" selected":""%>>영등포구</OPTION>
						 	<option value="동작구"<%=user.getUserSelectAddress().equals("동작구")?" selected":""%>>동작구</OPTION>
						 	<option value="관악구"<%=user.getUserSelectAddress().equals("관악구")?" selected":""%>>관악구</OPTION>
						 	<option value="서초구"<%=user.getUserSelectAddress().equals("서초구")?" selected":""%>>서초구</OPTION>
						 	<option value="강남구"<%=user.getUserSelectAddress().equals("강남구")?" selected":""%>>강남구</OPTION>
						 	<option value="송파구"<%=user.getUserSelectAddress().equals("송파구")?" selected":""%>>송파구</OPTION>
						 	<option value="강동구"<%=user.getUserSelectAddress().equals("강동구")?" selected":""%>>강동구</OPTION>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="userDetailAddress" value="<%=user.getUserDetailAddress()%>"/>
					</td>
				</tr>
				
				<tr>	
					<td><br/>
						<input type="submit" value="수정하기"/>
						<input type="reset" value="재작성"/>
						<input type="button" value="취소" onclick= "window.location='userMypage.jsp'"/>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>