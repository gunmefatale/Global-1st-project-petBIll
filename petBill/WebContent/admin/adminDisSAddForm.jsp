<%@page import="pet.cat.model.CatLDTO"%>
<%@page import="java.util.List"%>
<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대분류 소분류 추가</title>
</head>
<%
CatDAO dao = new CatDAO();
List articleList = dao.Lptdata();
%> 

<!-- 파일 업로드! -->
<form action="adminDisSAddPro.jsp" method="post" name="adminInputDisForm" enctype="multipart/form-data">

		<table>
			<tr>
				<td>대분류 명*<br />
					<select>
					<%for(int i = 0; i<articleList.size(); i++){
						CatLDTO article = (CatLDTO)articleList.get(i); %>
						<option value="<%=article.getLptNo()%>"><%=article.getLptName()%></option>
					<%}%>
					</select>
				</td>
			</tr>
			<tr>
				<td>소분류 내용*<br />
					<input type="text" name="subName" />
				</td>
			</tr>
			<tr>
				<td>이미지 변경*<br />
					<input type="file" name="subImg" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="추가하기" />
				</td>
			</tr>
		</table>
	</form>
<body>

</body>
</html>