<%@page import="pet.rev.model.RevDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
%>
<jsp:useBean id="article" class="pet.rev.model.RevDTO" />
<% 
	// 리뷰 저장
	System.out.println(article.getReviewId());

 
	
 	// 사진 저장
	String path = request.getRealPath("photo");
 	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String revp = request.getParameter("reviewPhoto"); 
	System.out.println("사진 " + revp);
	
 		if(revp != null){  // 이미지일 경우 
		// 파일 컨텐트 타입만 먼저 뽑아서 image 타입인지 확인 
		String contentType = mr.getContentType("reviewPhoto");
		System.out.println(contentType);
		
		String[] type = contentType.split("/");
		if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
		File f = mr.getFile("upload");
		f.delete();
		System.out.println("파일삭제 완료");
		%>
		<script>
			alert("이미지 파일만 업로드 가능합니다.");
			history.go(-1);
		</script> 
		<%}
		// 나머지 넘어온 데이터 뽑아서 dto에 저장하고  
		article.setReviewId(mr.getParameter("reviewId"));
		article.setReviewSubject(mr.getParameter("reviewSubject"));
		article.setReviewPetKind(mr.getParameter("reviewPetKind"));
		article.setReviewGender(mr.getParameter("reviewGender"));
		article.setReviewAge(mr.getParameter("reviewAge"));
		article.setReviewWeight(mr.getParameter("reviewWeight"));
		article.setReviewPetType(mr.getParameter("reviewPetType"));
		article.setReviewPhoto(mr.getFilesystemName("reviewPhoto"));
		article.setReviewArticle(mr.getParameter("reviewArticle"));
		article.setReviewPrice(mr.getParameter("reviewPrice"));
		article.setReviewContent(mr.getParameter("reviewContent"));
		article.setReviewJudge(mr.getParameter("reviewJudge"));		
		article.setReviewHosNo(mr.getParameter("reviewHosNo"));
		article.setReviewGu(mr.getParameter("reviewGu")); 
		
		//저장처리
		RevDAO dao = RevDAO.getInstance();
		dao.RevinsertArticle(article); %>
		<script>
		alert("업로드 완료!");
		window.location="reviewContent.jsp";
		</script>
			
<%}else{ 
		article.setReviewId(mr.getParameter("reviewId"));
		article.setReviewSubject(mr.getParameter("reviewSubject"));
		article.setReviewPetKind(mr.getParameter("reviewPetKind"));
		article.setReviewGender(mr.getParameter("reviewGender"));
		article.setReviewAge(mr.getParameter("reviewAge"));
		article.setReviewWeight(mr.getParameter("reviewWeight"));
		article.setReviewPetType(mr.getParameter("reviewPetType"));
		article.setReviewArticle(mr.getParameter("reviewArticle"));
		article.setReviewPrice(mr.getParameter("reviewPrice"));
		article.setReviewContent(mr.getParameter("reviewContent"));
		article.setReviewJudge(mr.getParameter("reviewJudge"));	
		article.setReviewHosNo(mr.getParameter("reviewHosNo"));
		article.setReviewGu(mr.getParameter("reviewGu")); 
		
		//저장처리
		RevDAO dao = RevDAO.getInstance();
		dao.RevinsertArticle(article);
%>

<script>
	alert("사진 빼고 업로드 ");
	window.location="reviewContent.jsp";
</script>
	<%}%>
<body>

	


</body>
</html>