<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	System.out.println("userId :" + userId);
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	System.out.println("reviewNo :" + reviewNo);
%>
<jsp:useBean id="dto" class="pet.rev.model.RevDTO"/>
<% 
//사진 저장

	String path = request.getRealPath("photo");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	// 파일 컨텐트 타입만 먼저 뽑아서 image 타입인지 확인 
/*
	String contentType = mr.getContentType("reviewPhoto");
	System.out.println(contentType);
	String[] type = contentType.split("/");
	if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
		File f = mr.getFile("upload");
		f.delete();
		System.out.println("파일삭제 완료"); */%>
	<%-- 	<script>
			alert("수정불가");
			history.go(-1);
		</script> --%>
	
	<% //}else{  // 이미지일 경우 

		// 나머지 넘어온 데이터 뽑아서 dto에 저장하고 
		dto.setReviewNo(reviewNo);
		dto.setReviewId(userId);
		dto.setReviewSubject(mr.getParameter("reviewSubject"));
		dto.setReviewPetKind(mr.getParameter("reviewPetKind"));
		dto.setReviewGender(mr.getParameter("reviewGender"));
		dto.setReviewAge(mr.getParameter("reviewAge"));
		dto.setReviewWeight(mr.getParameter("reviewWeight"));
		dto.setReviewPetType(mr.getParameter("reviewPetType"));
		if(mr.getFilesystemName("reviewPhoto") != null){ //reviewPhoto에 담겨서 들어왔으면
			System.out.println("사진 있을 때 :" + (mr.getFilesystemName("reviewPhoto")));
			dto.setReviewPhoto(mr.getFilesystemName("reviewPhoto")); //reviewphoto dto에 담고 기존데이터 삭제
		}else{ //사진 업데이트 안할경우
			System.out.println("사진 없을 때 :" + (mr.getFilesystemName("exreviewPhoto")));
			// 수정시 db에 값이 없으면, form에 null 값 전달 -> null이 문자열로 나옴
			dto.setReviewPhoto(mr.getParameter("exreviewPhoto"));
		}
		//dto.setReviewPhoto(mr.getFilesystemName("reviewPhoto"));
		dto.setReviewArticle(mr.getParameter("reviewArticle"));
		dto.setReviewPrice(mr.getParameter("reviewPrice"));
		dto.setReviewContent(mr.getParameter("reviewContent"));
		dto.setReviewJudge(mr.getParameter("reviewJudge"));		
		
		//저장처리
		RevDAO dao = RevDAO.getInstance();
		int result = dao.ReviewUpdate(dto, userId);
	
		if(result == 1){ %>
			<script>
			alert("수정 완료");
			window.location="/petBill/search/main.jsp"; 
			</script> 
	<% 	}else{ %>
		<script>
			alert("수정불가")
			history.go(-1);
		</script>
	<%}
	%>
	<%-- 	<script>
			alert("업로드 완료!");
			window.location="reviewWriteForm.jsp";
		</script> --%>
		
	<%//} %>

<body>

<body>

</body>
</html>