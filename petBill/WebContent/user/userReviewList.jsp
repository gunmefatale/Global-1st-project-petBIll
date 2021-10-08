<%@page import="pet.rev.model.RevDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>회원 리뷰 리스트</title>
	<style>
			
			div.left{
				width:40%; 
				float:left;
			}
			div.right{
				width:60%;
				float:right;
			}
	</style>
</head>
<%
request.setCharacterEncoding("UTF-8");
String userId = (String)session.getAttribute("userId");

int pageSize = 5; //보여줄 게시글 수

//현재 페이지 번호
String pageNum = request.getParameter("pageNum"); //사용자 요청 페이지 번호
if(pageNum == null){//사용자가 요청하지 않았을때 (기본 시작페이지)
	pageNum = "1"; //기본 1페이지를 보여준다.
}

//시작번호와 끝번호 세팅
int currentPage = Integer.parseInt(pageNum); // 형변환
System.out.println("currentPage : " + currentPage);
int startRow = (currentPage -1)* pageSize +1; //시작번호 세팅
System.out.println("startRow : " + startRow);
int endRow = currentPage * pageSize;//페이지 끝번호
System.out.println("endRow : " + endRow);

//게시판 글 가져오기
UserDAO dao = UserDAO.getInstance(); //리뷰 dao 객체 생성
int count = 0;
int number = 0;
List articleList = null;

count = dao.getUserArticleCount(userId); 
System.out.println("게시글 전체수 count : " + count);
if(count > 0){//글이 하나라도 있다면
	articleList = dao.getArticles(startRow,endRow,userId);
}

//게시판 목록에 뿌려줄 가상의 글번호
number = count - (currentPage-1)*pageSize;
System.out.println("number : " + number);

//날짜 출력 형태 패턴생성 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
 


%>
<body>
<div align="right">
		<button onclick = "window.location = 'logoutPro.jsp'">로그아웃</button>
		<button onclick = "window.location = 'userMypage.jsp'">마이페이지</button>
	</div>
	
	<div style="text-align : center;">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
		<br/>
		<br/>
	</div>
	
	<div class="left"  style="font-size:3.5em;">
		<table>
			<tr bgcolor="lightgray">
				<td><a href = "/petBill/user/userMypage.jsp">회원정보</a></td>
			</tr>
			<tr>
				<td><a href = "/petBill/user/userReviewList.jsp">후기관리</a>
				</td>
			</tr>
			<tr>
				<td>QnA</td>
			</tr>
			<tr>
				<td> <a href = "/petBill/user/userDeleteForm.jsp">회원탈퇴<a></td>
			</tr>
		</table>
		</div>
	<div class="right">
	<%
		if(count == 0){//게시글이 없으면%>
		
		<tr>
	 	   <td><h1>게시글이 없습니다.</h1></td>
	    </tr>
		<%}else{//게시글이 있으면%>
			<table>
				<tr>
	         		<td>No.</td>
	        		<td>병원명</td>
	        		<td>등록날짜</td>
	       		  	<td>제목</td>
	      			<td>평가</td>
     			</tr>
     		<%
     			for(int i = 0; i < articleList.size(); i++){
     				RevDTO article = (RevDTO)articleList.get(i);
     		%>

 
     			<tr>    
     				<td><%= number-- %></td>
			      	<td><%//article.getRe%>병원명</td><%--병원명 --%>
			        <td><%= sdf.format(article.getReviewDate()) %></td> <%-- 리뷰 등록날짜 무조건 만들어야 함 --%>
     				<td><a href="/petBill/review/reviewContent.jsp?reviewNo=<%=article.getReviewNo()%>&reviewHosNo=<%=article.getReviewHosNo() %>&pageNum=<%=pageNum%>"> <%=article.getReviewSubject() %><%-- 리뷰 --%> </a></td>
     				<%-- article.getReviewArticle() --> article.getReviewSubject() 로 수정하기 --%>																												
		 	        <td><%= article.getReviewJudge() %></td>
     			</tr>  
     			<%} %>
     			<tr> 
     			</tr>   
     			<%}%> 
     			
     			
     			
     			
			</table>
		<%
	
	%>
		
	
	
	
	
	</div>



</body>
</html>