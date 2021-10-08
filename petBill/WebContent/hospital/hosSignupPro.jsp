<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hosSignupPro</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="hosDto" class="pet.hos.model.HosDTO"/>
<%

	//사진 저장
	String path = request.getRealPath("photo");
	System.out.println(path); 
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	//***** 파일은 getFilesystemName 으로만 꺼낼수있따! ㅠ
	String hosProfile = mr.getFilesystemName("hosProfile"); 
	String hosNumPhoto = mr.getFilesystemName("hosNumPhoto"); 
	System.out.println("프로필 사진명 : " + hosProfile);
	System.out.println("사업자등록증 사진명 : " + hosNumPhoto);
	
	if(hosProfile != null){  // 이미지일 경우 
		// 파일 컨텐트 타입만 먼저 뽑아서 image 타입인지 확인 
		String contentType = mr.getContentType("hosProfile");
		System.out.println("파일타입 = " + contentType);
		String[] type = contentType.split("/");
		
		if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
			File f = mr.getFile("hosProfile");
			f.delete();
			System.out.println("파일삭제 완료");
%>
			<script>
				alert("이미지 파일만 업로드 가능합니다.");
				history.go(-1);
			</script> 
	  <%}
		//넘어온 데이터들 일일이빼서 hosDto저장 
		hosDto.setHosId(mr.getParameter("hosId"));
		hosDto.setHosPw(mr.getParameter("hosPw"));
		hosDto.setHosUserName(mr.getParameter("hosUserName"));
		hosDto.setHosProfile(mr.getFilesystemName("hosProfile"));
		hosDto.setHosMobile(mr.getParameter("hosMobile"));
		hosDto.setHosName(mr.getParameter("hosName"));
		hosDto.setHosTel(mr.getParameter("hosTel"));
		hosDto.setHosTime(mr.getParameter("hosTime"));
		hosDto.setHosSiAddress(mr.getParameter("hosSiAddress"));
		hosDto.setHosGuAddress(mr.getParameter("hosGuAddress"));
		hosDto.setHosNewAddress(mr.getParameter("hosNewAddress"));
		hosDto.setHosOldAddress(mr.getParameter("hosOldAddress"));
		hosDto.setHosNum(mr.getParameter("hosNum"));
		hosDto.setHosNumPhoto(mr.getFilesystemName("hosNumPhoto"));
		hosDto.setHosBio(mr.getParameter("hosBio"));

		
		HosDAO hosDao = HosDAO.getInstance();
		//2. 공공데이터 없음 -> 신규로 insert
		hosDao.insertHosMember(hosDto);
		
%>
	<script>
		//페이지처리
		alert("회원가입이 정상 처리 되었습니다.");
		window.location.href = "../search/main.jsp"; // 메인으로 이동
	</script> 
	
<% 	}else if(hosNumPhoto != null){
		// 파일 컨텐트 타입만 먼저 뽑아서 image 타입인지 확인 
		String contentType = mr.getContentType("hosNumPhoto");
		System.out.println("파일타입 = " + contentType);
		String[] type = contentType.split("/");
			
		if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
			File f = mr.getFile("hosNumPhoto");
			f.delete();
			System.out.println("파일삭제 완료");
%>
			<script>
				alert("이미지 파일만 업로드 가능합니다.");
				history.go(-1);
			</script> 
	  <%}
		//넘어온 데이터들 일일이빼서 hosDto저장 
		hosDto.setHosId(mr.getParameter("hosId"));
		hosDto.setHosPw(mr.getParameter("hosPw"));
		hosDto.setHosUserName(mr.getParameter("hosUserName"));
		hosDto.setHosProfile(mr.getFilesystemName("hosProfile"));
		hosDto.setHosMobile(mr.getParameter("hosMobile"));
		hosDto.setHosName(mr.getParameter("hosName"));
		hosDto.setHosTel(mr.getParameter("hosTel"));
		hosDto.setHosTime(mr.getParameter("hosTime"));
		hosDto.setHosSiAddress(mr.getParameter("hosSiAddress"));
		hosDto.setHosGuAddress(mr.getParameter("hosGuAddress"));
		hosDto.setHosNewAddress(mr.getParameter("hosNewAddress"));
		hosDto.setHosOldAddress(mr.getParameter("hosOldAddress"));
		hosDto.setHosNum(mr.getParameter("hosNum"));
		hosDto.setHosNumPhoto(mr.getFilesystemName("hosNumPhoto"));
		hosDto.setHosBio(mr.getParameter("hosBio"));			
			
			
		HosDAO hosDao = HosDAO.getInstance();
		//2. 공공데이터 없음 -> 신규로 insert
		hosDao.insertHosMember(hosDto);
		
		%>
		<script>
			//페이지처리
			alert("회원가입이 정상 처리 되었습니다.");
			window.location.href = "../search/main.jsp"; // 메인으로 이동
		</script> 
	
<%	}else{ //이미지타입 아니라도 우선 저장하자 ㅋㅋㅋ 
		hosDto.setHosId(mr.getParameter("hosId"));
		hosDto.setHosPw(mr.getParameter("hosPw"));
		hosDto.setHosUserName(mr.getParameter("hosUserName"));
		hosDto.setHosProfile(mr.getFilesystemName("hosProfile"));
		hosDto.setHosMobile(mr.getParameter("hosMobile"));
		hosDto.setHosName(mr.getParameter("hosName"));
		hosDto.setHosTel(mr.getParameter("hosTel"));
		hosDto.setHosTime(mr.getParameter("hosTime"));
		hosDto.setHosSiAddress(mr.getParameter("hosSiAddress"));
		hosDto.setHosGuAddress(mr.getParameter("hosGuAddress"));
		hosDto.setHosNewAddress(mr.getParameter("hosNewAddress"));
		hosDto.setHosOldAddress(mr.getParameter("hosOldAddress"));
		hosDto.setHosNum(mr.getParameter("hosNum"));
		hosDto.setHosNumPhoto(mr.getFilesystemName("hosNumPhoto"));
		hosDto.setHosBio(mr.getParameter("hosBio"));
		
		HosDAO hosDao = HosDAO.getInstance();
		//2. 공공데이터 없음 -> 신규로 insert
		hosDao.insertHosMember(hosDto);
		
		%>
		<script>
			//페이지처리
			alert("회원가입이 정상 처리 되었습니다.");
			window.location.href = "../search/main.jsp"; // 메인으로 이동
		</script> 
	
<% 	}%>	
<body>
</body>
</html>