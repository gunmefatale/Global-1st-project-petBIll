<%@page import="pet.hos.model.HosDAO"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hosModifyPro</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>
	<!-- useBean 객체생성까지만 가능하고 자동맵핑은 불가(jsp:setProperty) X -->
	<jsp:useBean id="hosDto" class="pet.hos.model.HosDTO"/>
<%	

	//서버에 파일저장
	String path = request.getRealPath("photo");
	System.out.println(path);//저장경로 출력
	int max = 1024*1024*5; //최대크기 5M
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	//파일타입확인위해 꺼내놓기
	String hosProfile = mr.getFilesystemName("hosProfile"); 
	String hosNumPhoto = mr.getFilesystemName("hosNumPhoto"); 
	String hosName = mr.getParameter("hosName");
	System.out.println("병원명 : " + hosName);
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
		/* if(mr.getFilesystemName("hosProfile") != null){ //hosNumPhoto에 담겨서 들어왔으면
			System.out.println("프로필 사진 있음 :" + (mr.getFilesystemName("hosProfile")));
			hosDto.setHosNumPhoto(mr.getFilesystemName("hosProfile")); //hosNumPhoto dto에 담고 기존데이터 삭제
		 	}else{ //사진 업데이트 안할경우
			System.out.println("없음 :" + (mr.getFilesystemName("exHosProfile")));
			// 수정시 db에 값이 없으면, form에 null 값 전달 -> null이 문자열로 나옴
			hosDto.setHosNumPhoto(mr.getParameter("exHosProfile"));
		} */
		hosDto.setHosBio(mr.getParameter("hosBio"));
		hosDto.setHosId((String)session.getAttribute("hosId"));
		
		//업데이트
		HosDAO dao = HosDAO.getInstance();
		int result = dao.hosMemberUpdate(hosDto);
		System.out.println("수정결과 : " + result);
	%>	
		<script>
			alert("회원정보 수정완료!");
			window.location="../hospital/hosMypage.jsp";
		</script>
	<%
	}else if(hosNumPhoto != null){ //이미지일 경우
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
		/* if(mr.getFilesystemName("hosNumPhoto") != null){ //hosNumPhoto에 담겨서 들어왔으면
			System.out.println("사업자등록증 사진 있음 :" + (mr.getFilesystemName("hosNumPhoto")));
			hosDto.setHosNumPhoto(mr.getFilesystemName("hosNumPhoto")); //hosNumPhoto dto에 담고 기존데이터 삭제
		}else{ //사진 업데이트 안할경우
			System.out.println("없음 :" + (mr.getFilesystemName("exHosNumPhoto")));
			// 수정시 db에 값이 없으면, form에 null 값 전달 -> null이 문자열로 나옴
			hosDto.setHosNumPhoto(mr.getParameter("exHosNumPhoto"));
		} */
		hosDto.setHosBio(mr.getParameter("hosBio"));
		hosDto.setHosId((String)session.getAttribute("hosId"));
		
		//업데이트
		HosDAO dao = HosDAO.getInstance();
		int result = dao.hosMemberUpdate(hosDto);
		System.out.println("수정결과 : " + result);
			
		if(result == 1){ %>
		<script>
			alert("회원정보 수정완료!");
			window.location="../hospital/hosMypage.jsp";
		</script>
	<% 	}else{ %>
		<script>
			alert("수정에 실패했습니다..")
			history.go(-1);
		</script>
<%  	}
	}else{
		//넘어온 데이터들 일일이빼서 hosDto저장 
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
		hosDto.setHosId((String)session.getAttribute("hosId"));
		
		
		//업데이트
		HosDAO dao = HosDAO.getInstance();
		int result = dao.hosMemberUpdate(hosDto);
		System.out.println("수정결과 : " + result);
		
		if(result == 1){ %>
		<script>
			alert("회원정보 수정완료!");
			window.location="../hospital/hosMypage.jsp";
		</script>
<% 		}else{ %>
		<script>
			alert("수정에 실패했습니다..")
			history.go(-1);
		</script>

<%  		}
		
	}
	//else %>
<body>

</body>
</html>