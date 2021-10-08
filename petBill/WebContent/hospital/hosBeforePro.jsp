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
	<title>공공데이터 병원검색결과</title>
	
	<style>
			ul {list-style: none;}
			li {width: 1000px; display: inline; margin: 10px;}
			a {text-decoration: none; font-size: 24px; padding: 5px;}
			<%-- 링크 값을 변경하기 --%>
			a:link {color: black;}
			<%-- 방문 후 값을 변경 되게하는 것. --%>
			a:visited {color: turquoise;}
	</style>
	
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="hosDto" class="pet.hos.model.HosDTO"/>
	<jsp:setProperty property="*" name="hosDto"/>
<%
	HosDAO hosDao = HosDAO.getInstance();
	//전화번호로 공공데이터 검색
	HosDTO searchDto = hosDao.getHospital(hosDto.getHosTel());
	//검색결과 searchDto가 null값일 때 꺼내려고하면 에러난다!!!! 몇시간걸려서 깨달은건지...하..
/* 	System.out.println("hosId = "+ searchDto.getHosId());
	System.out.println("hosTel = "+ searchDto.getHosTel());
	System.out.println("hosNo = "+ searchDto.getHosNo()); */
%>
	<script>
	//아이디 중복 체크 확인
	function confirmHosId(hosInputForm){ // <-- this.form 객체 받음 
		if(hosInputForm.hosId.value == "" || !hosInputForm.hosId.value){ // 비었거나, id가 같지않다. 
			alert("아이디를 입력하세요.");
			return;
		}
		//팝업 
		var url ="confirmHosId.jsp?hosId="+ hosInputForm.hosId.value; // confirmId.jsp?id=rani
		open(url, "confirmHosId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=500, height=500"); // 새창이 열리는 open!
	}
	</script>
	
<% 
	try{
		//1.검색결과 searchDto 데이터 값이 들어있는 경우
		if(searchDto != null){ 

			// 1) hosId 없음 : 공공데이터에 추가되는 회원가입
			if(searchDto.getHosId() == null || searchDto.getHosId().equals("none")){
				System.out.println("가입안된 공공데이터 병원임");%>
				<div align="right">
					<ul>
					<li>
						<a href="../user/loginForm.jsp">
							로그인
						</a>
						&nbsp;
						&nbsp;
						<a href="../user/signupMain.jsp">
							회원가입
						</a>
					</li>
					</ul>
				</div>

				<!-- 메인 로고 -->
				<div align="center" class="logo">
				<a href="/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
				</div>
		
<!-- ======================================상단메뉴 구분선========================================= -->	
		
				<h1 align="center">병원회원가입</h1>
				<p align="center"><%=searchDto.getHosName()%> 님, 환영합니다!</p>
				<div align="center">
				<form action="hosExistSignupPro.jsp" method="post" enctype="multipart/form-data" name="hosInputForm" >
	
				<!-- 글 고유번호 숨겨서 전송 -->
				<input type="hidden" name="hosNo" value="<%=searchDto.getHosNo()%>"/>	
			
				<table>
				<tr>
					<td>아이디*<br />
						<input type="text" name="hosId" placeholder="영문+숫자조합" />
						<input type="button" value="중복체크" onclick="confirmHosId(this.form)"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호*<br />
						<input type="password" name="hosPw"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인*<br />
						<input type="password" name="hosPwCk"/>
					</td>
				</tr>
				<tr>
					<td>병원명 <br />
						<p><%=searchDto.getHosName()%></p>
					</td>
				</tr>
				<tr>
					<td>전화번호 <br />
						<p><%=searchDto.getHosTel()%></p>
					</td>
				</tr>
				<tr>
					<td>도로명 주소<br />
						<p><%=searchDto.getHosNewAddress()%></p>
					</td>
				</tr>
				<tr>
					<td>지번 주소<br />
						<p><%=searchDto.getHosOldAddress()%></p>
					</td>
				</tr>
				<tr>
					<td>사업자 등록번호<br />
						<input type="text" name="hosNum" placeholder="'-'포함해서 입력"/>
					</td>
				</tr>
				<tr>
					<td>영업시간<br />
						<input type="text" name="hosTime" placeholder="ex) 09:00~18:00"/>
					</td>
				</tr>
				<tr>
					<td>사업자등록증 사진(N/N)<br />
						<input type="file" name="hosNumPhoto" />
					</td>
				</tr>
				<tr>
					<td>대표자 사진(N/N)<br />
						<input type="file" name="hosProfile"/>
					</td>
				</tr>
				<tr>
					<td>병원 대표자 명<br />
						<input type="text" name="hosUserName"/>
					</td>
				</tr>
				<tr>
					<td>대표자 휴대폰번호<br />
						<input type="text" name="hosMobile" placeholder="'-'포함해서 입력"/>
					</td>
				</tr>
				<tr>
					<td>병원장 약력<br />
						<textarea name="hosBio" rows="10" cols="25" placeholder="2000자 내외"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="신청하기"/>
						<input type="reset" value="다시작성"/>
						<input type="button" value="취소"/>
					</td>
				</tr>
				</table>
				</form>
				</div>
		
		  <%}else {
		  		System.out.println("hosId = " + searchDto.getHosId());
		  		System.out.println("hosPw = " + searchDto.getHosPw());%>
				<script>
					// 2) hosId 있음 = 가입내역있음 : 로그인페이지로 보냄
					alert("이미 등록된 회원입니다. 로그인 페이지로 이동합니다.");
					window.location.href = "../user/loginForm.jsp";
				</script>
		  <%} 
			
		//2. 공공데이터 없으면 신규회원가입 
		}else{//(searchDto == null)%>
			<script>
				alert("등록된 정보가 없습니다.");
				window.location.href = "hosSignupForm.jsp";
			</script>	
					
<%		}//if(searchDto != null

	}catch(Exception e){
		e.printStackTrace();
	}%>
		

<body>

</body>
</html>





