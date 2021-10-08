<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.rev.model.RevDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
//	HosDAO dao = HosDAO.getInstance();	 
//	HosDTO Hos = dao.getHos(hosId); // 

String userId = (String)session.getAttribute("userId");
String hosId = (String)session.getAttribute("hosId");
String admin = (String)session.getAttribute("admin");
String hosNo = request.getParameter("hosNo");
String hosGu = request.getParameter("hosGuAddress");
UserDTO dto = new UserDTO();
dto.setUserId(userId);
RevDTO rev = new RevDTO();



	   
%>
<body>
	<table>
		<div align="right">
			<ul>
				<li>
					<div align="right">
						
						<% if(session.getAttribute("hosId")!= null){%>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'">마이페이지</button>
						<%}else if(session.getAttribute("userId")!= null){ %>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/user/userMypage.jsp'">마이페이지</button>
						<%System.out.println("admin : " + session.getAttribute("admin")); %> 
						<%}else if(session.getAttribute("admin") != null){%> 
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button> 
						<button onclick = "window.location = '/petBill/admin/adminUserList.jsp'">마이페이지</button> 
						<%}else{ %>
						<button onclick = "window.location = '/petBill/user/loginForm.jsp'">로그인</button>
						<button onclick = "window.location = '/petBill/user/signupMain.jsp'">회원가입</button>
						<%} %>
					</div>
				</li>
			</ul> 
		</div>  
	</table>
		<br/><br/>
	<table>
		<div style="text-align : center;">
			<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
		</div>
	</table>
	<h1 align="center"> 게시글 작성 </h1>
	<form action="reviewWritePro.jsp?reviewPhoto=multipart" method="post" enctype="multipart/form-data">  
	<table> 
		<tr>
			<td><input type="hidden" name = "reviewId" value = "<%=dto.getUserId()%>"/></td>
			<td><input type="hidden" name = "reviewHosNo" value = "<%=hosNo%>"/></td>
			<td><input type="hidden" name = "reviewGu" value = "<%=hosGu%>"/></td> 
		</tr>
		<tr>
		<td>제목 *</td>
		<td>
			<input type="text" name="reviewSubject"/>
		</td>
		</tr>
		<tr>
			<td>품종*</td>
				<td align="left">
					<input type="text" name="reviewPetKind" />
				</td>
		</tr>
		<tr>
			<td>성별*</td>
			<td align="left">
				<input type="radio" name="reviewGender" value="남"/> 남
				<input type="radio" name="reviewGender" value="여"/> 여
			</td>
		</tr>
		<tr>
			<td>나이 </td>
			<td align="left"><input type="text" name="reviewAge" /></td>
		</tr>
		<tr>
			<td>몸무게</td>
			<td><input type="text" name="reviewWeight" /></td>
		</tr>
		<tr>
			<td>*</td>
			<td align="left">
			<input type="radio" name="reviewPetType" value="dog"/> 강아지
			<input type="radio" name="reviewPetType" value="cat"/> 고양이
			</td>	
		</tr>
		<tr>
			<td>영수증 사진 첨부
			<input type="file" name="reviewPhoto" onchange="this.value"/>
				
			<td>
		</tr>
		<tr>
			<td> 진료항목</td>
			<td>
			<select name="reviewArticle">
				<option value="기초접종">기초접종</option>
				<option value="중성화 수술">중성화 수술</option>
				<option value="심장사상충">심장사상충</option>
				<option value="기타">기타</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>금액 *</td>
			<td> <input type="text" name="reviewPrice" /> 원 
			</td>
		</tr>
		<tr>
			<td>후기</td>
			
				<td><textarea rows="20" cols="40" name="reviewContent" placeholder="진료항목 '기타'선택시 작성자가 병명 기술"></textarea>
				</td>
		</tr>
		<tr>
			<td> 평가 *</td>
			<td>
			<input type="radio" name="reviewJudge" value="좋아요" /> 좋아요
			<input type="radio" name="reviewJudge" value="보통이에요" /> 보통이에요
			<input type="radio" name="reviewJudge" value="나빠요" /> 나빠요
			</td>
		</tr>
		<tr>		
			<td>
				<input type="submit" value="저장" />
				<input type="reset" value="재작성" />
				<input type="button" value="리스트보기" onclick="window.location='list.jsp'" />
				<input type="button" value="content" onclick="window.location='reviewContent.jsp'" />
			</td>
		</tr> 
	</table> 
	</form>
</body> 
</html>