<%@page import="pet.user.model.UserDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.List"%>
<%@page import="pet.rev.model.RevDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
</head>
<% 

	request.setCharacterEncoding("UTF-8");
	String reviewId = request.getParameter("reviewId");
	System.out.println("reviewId : " + reviewId);
	String userId = (String)session.getAttribute("userId");
	System.out.println("userId : " + userId);
	String hosId = (String)session.getAttribute("hosId");
	System.out.println("hosId : " + hosId);
	String reviewNo = request.getParameter("reviewNo");
	System.out.println("reviewNo : " + reviewNo);
	String reviewHosNo = (request.getParameter("reviewHosNo"));
	System.out.println("reviewHosNo : " + reviewHosNo);
	  
 
	RevDAO dao = RevDAO.getInstance();//싱글턴
	RevDTO dto = dao.getReview(userId, reviewHosNo);
 
%> 
  
<body>

    <form action="reviewModifyPro.jsp?reviewNo=<%=dto.getReviewNo() %>" method="post" enctype="multipart/form-data">
		<table> 
			<tr>
			<td><input type="hidden" name = "reviewNo" value = "<%=dto.getReviewNo()%>"/></td>
			</tr>
			<tr>
				<td align="left">제목<input type="text" name="reviewSubject" value="<%=dto.getReviewSubject()%>" size="13"/></td> 

			</tr>
			<tr>
				<td align="left">품종 <input type="text" name="reviewPetKind" value="<%= dto.getReviewPetKind() %>" size="13"/> </td>
	
			</tr>
			<tr>
				<td align="left">성별	<input type="text" name="reviewGender" value="<%= dto.getReviewGender() %>" size="13"/></td>
			</tr>
			<tr>
				<td align="left">나이	<input type="text" name="reviewAge" value="<%= dto.getReviewAge() %>" size="13"/> 살</td>
	
			</tr>
			<tr>
				<td align="left">몸무게<input type="text" name="reviewWeight" value="<%= dto.getReviewWeight() %>" size="13"/> kg</td>
	
			</tr>
			<tr>
				<td align="left">
				<input type="radio" name="reviewPetType" value="dog" /> 강아지
				<input type="radio" name="reviewPetType" value="cat" checked="checked"/> 고양이
				</td>	
			</tr>
			<tr>
			<td> 영수증 사진 </td>
			<td>
				<%if(dto.getReviewPhoto() != null){ // 사진 저장된게 있을 경우%>
							<img src="/petBill/photo/<%=dto.getReviewPhoto()%>" width="150" />
						<%}else{ %>
							<img src="/petBill/review/imgs/default.png" width="150" />
						<%} %>
						<input type="file" name="reviewPhoto" />
						<input type="hidden" name="exreviewPhoto" value="<%=dto.getReviewPhoto()%>"/> 	
				</td>
			</tr>
			<tr>
				<td align="left">진료항목</td>
				<td>
					<select name="reviewArticle">		
						<option value="기초접종"<%=dto.getReviewArticle().equals("기초접종")?" selected":""%>>기초접종</option>
						<option value="중성화 수술"<%=dto.getReviewArticle().equals("중성화 수술")?" selected":""%>>중성화 수술</option>
						<option value="심장사상충"<%=dto.getReviewArticle().equals("심장사상충")?" selected":""%>>심장사상충</option>
						<option value="기타"<%=dto.getReviewArticle().equals("기타")?" selected":""%>>기타</option>
					</select> 
				</td>
			</tr>
			<tr>
				<td align="left">금액<input type="text" name="reviewPrice" value="<%= dto.getReviewPrice() %>" size="13"/> 원 </td>
			</tr>
			<tr>
				<td align="left">후기</td> 
				<td><textarea rows="20" cols="40" name="reviewContent"><%= dto.getReviewContent() %></textarea></td>
			</tr>
			<tr>
				<td align="left"> 평가  </td>
				<td>
				<input type="radio" name="reviewJudge" value="좋아요" <% if("좋아요".equals(dto.getReviewJudge())){%>checked<%}%>/> 좋아요
				<input type="radio" name="reviewJudge" value="보통이에요" <% if("보통이에요".equals(dto.getReviewJudge())){%>checked<%}%>/> 보통이에요
				<input type="radio" name="reviewJudge" value="나빠요" <% if("나빠요".equals(dto.getReviewJudge())){%>checked<%}%>/> 나빠요
				</td>
	
			</tr>
			<tr>		
				<td>
					<input type="submit" value="수정"/>
					<input type="reset" value="재작성" />
					<input type="button" value="삭제" onclick="window.location='reviewDeleteForm.jsp?reviewNo=<%=dto.getReviewNo()%>&reviewHosNo=<%=dto.getReviewHosNo() %>'" />
				</td>
			</tr> 
		</table> 
	</form>
	<form action = "reviewHosPro.jsp">
		<table>
			<tr>
			<td><input type="hidden" name = "reviewNo" value = "<%=dto.getReviewNo()%>"/></td>
				<td align="left">병원 답변</td>
				<td>
				<%if(dto.getReviewRef() == null){ %>
					<textarea rows="20"cols="40" name = "reviewRef" >답변이 없습니다.</textarea>
					<%}else{ %>
					<textarea rows="20"cols="40" name = "reviewRef"><%=dto.getReviewRef() %></textarea>
					<%}%>
				</td>
			</tr> 
			<%if(hosId != null) {%>
			<tr>
				<td>
					<input type="submit" value = "답변등록"/>
					<input type="button" value = "뒤로가기" onclick="window.location='reviewContent.jsp'"/>
				
				</td> 
			</tr>
			<%} %>
		</table>
	</form>
			


</body>
</html>