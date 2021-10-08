<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보수정</title>
	<style>
			ul {list-style: none;}
			li {width: 1000px; display: inline; margin: 10px;}
			a {text-decoration: none; font-size: 24px; padding: 5px;}
			<%-- 링크 값을 변경하기 --%>
			a:link {color: black;}
			<%-- 방문 후 값을 변경 되게하는 것. --%>
			a:visited {color: turquoise;}
			aa{color: red;}
			div.left{width:40%; float:left;}
			div.right{width:60%; float:right;}
	</style>

</head>
<%
	// 세션 hosId값 없으면 로그인페이지로 이동 
	String hosId = (String)session.getAttribute("hosId");
	if(session.getAttribute("hosId") == null && session.getAttribute("userId") == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>	
<% 	

	// 세션 hosId값 있을경우 보이기 
	}else{ 	
		HosDAO dao = HosDAO.getInstance();
		//회원정보 꺼내오기
		HosDTO hosDto = dao.getHosMember(hosId); %>
		
		<script>
		//전화번호 중복 체크 확인
		function confirmHosTel(hosInputForm){ // <-- this.form 객체 받음 
			if(hosInputForm.hosTel.value == "" || !hosInputForm.hosTel.value){ // 비었거나, hosTel가 같지않다. 
				alert("전화번호를 입력하세요.");
				return;
			}
			//팝업 
			var url ="confirmHosTel.jsp?hosTel="+ hosInputForm.hosTel.value;
			open(url, "confirmHosTel", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=500, height=500"); // 새창이 열리는 open!
		
		}
		</script>


	<div align="right">
			<ul>
				<li>
					<a href="../user/logoutPro.jsp">
						로그아웃
					</a>
					&nbsp;
					&nbsp;
					<a href="../hospital/hosMypage.jsp">
						병원마이페이지
					</a>
				</li>
			</ul>
		</div>
		
	<div align="center" class="logo">
		<!-- 메인 로고 -->
		<a href="/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	
<!-- ======================================상단메뉴 구분선========================================= -->
	
	<div class="left"  style="font-size:3.5em;">
		<table>
			<tr>
				<td><a href ="../hospital/hosMypage.jsp">병원회원정보</a></td>
			</tr>
			<tr>
				<td><a>1:1문의</a></td>
			</tr>
			<tr>
				<td><a>병원공지사항</a></td>
			</tr>
			<tr>
				<td><a>병원이벤트</a></td>
			</tr>
			<tr>
				<td> <a href = "../hospital/hosDeleteForm.jsp">회원탈퇴</a></td>
			</tr>
		</table>
	</div>
	
	<h1 >회원정보수정</h1>
	<div >

	<form action="hosModifyPro.jsp" method="post" name="hosInputForm" enctype="multipart/form-data">
		<!-- 고유번호넘기기 -->
		<input type="hidden" name="hosNo" value="<%=hosDto.getHosNo()%>"/>
		
		<table>
			<tr>
				<td>아이디*<br />
				<%=hosDto.getHosId()%>
			</tr>
			<tr>
				<!-- 유효성검사 -->
				<td>비밀번호* <input type="button" value="비밀번호변경" onclick="pwChange(this.form)"/><br />
				<!-- <input type="password" name="hosPw" placeholder="비밀번호를 입력해주세요."/> -->
				</td>
			</tr>
			<tr>
				<td>병원명*<br />
				<input type="text" name="hosName" value="<%=hosDto.getHosName()%>"/>
				</td>
			</tr>
			<tr>
				<td>병원 전화번호* ('-'포함해서 입력해주세요.)<br />	
				<input type="text" name="hosTel" value="<%=hosDto.getHosTel()%>"/>
				<input type="button" value="중복체크" onclick="confirmHosTel(this.form)"/>
				</td>
			</tr>
			<tr>
			<td>도로명 주소*<br />
				<select name="hosSiAddress">
					<option value="서울특별시"<%=hosDto.getHosSiAddress().equals("서울특별시")?" selected":""%>>서울특별시</option>
				</select>
					
				<select name="hosGuAddress">	
					<option value="종로구"<%=hosDto.getHosGuAddress().equals("종로구")?" selected":""%>>종로구</OPTION>
                      <option value="중구"<%=hosDto.getHosGuAddress().equals("중구")?" selected":""%>>중구</OPTION>
                      <option value="용산구"<%=hosDto.getHosGuAddress().equals("용산구")?" selected":""%>>용산구</OPTION>
                      <option value="성동구"<%=hosDto.getHosGuAddress().equals("성동구")?" selected":""%>>성동구</OPTION>
                      <option value="광진구"<%=hosDto.getHosGuAddress().equals("광진구")?" selected":""%>>광진구</OPTION>
                      <option value="동대문구"<%=hosDto.getHosGuAddress().equals("동대문구")?" selected":""%>>동대문구</OPTION>
                      <option value="중랑구"<%=hosDto.getHosGuAddress().equals("중랑구")?" selected":""%>>중랑구</OPTION>
                      <option value="성북구"<%=hosDto.getHosGuAddress().equals("성북구")?" selected":""%>>성북구</OPTION>
                      <option value="강북구"<%=hosDto.getHosGuAddress().equals("강북구")?" selected":""%>>강북구</OPTION>
                      <option value="도봉구"<%=hosDto.getHosGuAddress().equals("도봉구")?" selected":""%>>도봉구</OPTION>
                      <option value="노원구"<%=hosDto.getHosGuAddress().equals("노원구")?" selected":""%>>노원구</OPTION>
                      <option value="은평구"<%=hosDto.getHosGuAddress().equals("은평구")?" selected":""%>>은평구</OPTION>
                      <option value="서대문구"<%=hosDto.getHosGuAddress().equals("서대문구")?" selected":""%>>서대문구</OPTION>
                      <option value="마포구"<%=hosDto.getHosGuAddress().equals("마포구")?" selected":""%>>마포구</OPTION>
                      <option value="양천구"<%=hosDto.getHosGuAddress().equals("양천구")?" selected":""%>>양천구</OPTION>
                      <option value="강서구"<%=hosDto.getHosGuAddress().equals("강서구")?" selected":""%>>강서구</OPTION>
                      <option value="구로구"<%=hosDto.getHosGuAddress().equals("구로구")?" selected":""%>>구로구</OPTION>
                      <option value="금천구"<%=hosDto.getHosGuAddress().equals("금천구")?" selected":""%>>금천구</OPTION>
                      <option value="영등포구"<%=hosDto.getHosGuAddress().equals("영등포구")?" selected":""%>>영등포구</OPTION>
                      <option value="동작구"<%=hosDto.getHosGuAddress().equals("동작구")?" selected":""%>>동작구</OPTION>
                      <option value="관악구"<%=hosDto.getHosGuAddress().equals("관악구")?" selected":""%>>관악구</OPTION>
                      <option value="서초구"<%=hosDto.getHosGuAddress().equals("서초구")?" selected":""%>>서초구</OPTION>
                      <option value="강남구"<%=hosDto.getHosGuAddress().equals("강남구")?" selected":""%>>강남구</OPTION>
                      <option value="송파구"<%=hosDto.getHosGuAddress().equals("송파구")?" selected":""%>>송파구</OPTION>
                      <option value="강동구"<%=hosDto.getHosGuAddress().equals("강동구")?" selected":""%>>강동구</OPTION>
				</select>	
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				   if(hosDto.getHosNewAddress() == null) {%>
					<input type="text" name="hosNewAddress" placeholder="상세주소 입력"/>
				<% }else{ %> 
					<input type="text" name="hosNewAddress" value="<%=hosDto.getHosNewAddress()%>"/>
				<% }%>	
				</td>
			</tr>
			<tr>
				<td>지번 주소<br />
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				   if(hosDto.getHosOldAddress() == null) {%>
					<input type="text" name="hosOldAddress"/>
				<% }else{ %> 
					<input type="text" name="hosOldAddress" value="<%=hosDto.getHosOldAddress() %>"/>
				<% }%>
				</td>
			</tr>
			<tr>
				<td>영업시간<br />
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				   if(hosDto.getHosTime() == null) {%>
					<input type="text" name="hosTime" placeholder="ex) 09:00~18:00"/>
				<% }else{ %> 
					<input type="text" name="hosTime" value="<%=hosDto.getHosTime()%>"/>
				<% }%>
				
				</td>
			</tr>
			<tr>
				<td>사업자 등록번호<br />
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				   if(hosDto.getHosNum() == null) {%>
					<input type="text" name="hosNum" placeholder="'-'포함해서 입력"/>
				<% }else{ %> 
					<input type="text" name="hosNum" value="<%=hosDto.getHosNum()%>"/>
				<% }%>
	
				</td>
			</tr>
			<tr>
				<td>병원 대표자 명<br />
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				   if(hosDto.getHosUserName() == null) {%>
					<input type="text" name="hosUserName"/>
				<% }else{ %> 
					<input type="text" name="hosUserName" value="<%=hosDto.getHosUserName()%>"/>
				<% }%>
				
				</td>
			</tr>
			<tr>
				<td>대표자 휴대폰번호<br />
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지 
				   if(hosDto.getHosMobile() == null) {%>
					<input type="text" name="hosMobile" placeholder="'-'포함해서 입력"/>
				<% }else{ %> 
					<input type="text" name="hosMobile" value="<%=hosDto.getHosMobile()%>"/>
				<% }%>
				</td>
			</tr>
			<tr>
				<td>대표자 사진<br />
				<% //null로 비어있는 상태면 default.png 띄워주기 
				   if(hosDto.getHosProfile() == null) {%>
					<img src="/petBill/review/imgs/default.png" width="200" /><br />
				<% }else{ %> 
					<img src="/petBill/photo/<%=hosDto.getHosProfile()%>" width="200" /><br />
				<% }%>
					* 사진변경(N/N) : <input type="file" name="hosProfile"/><br />
				
				</td>
			</tr>
			<tr>
				<td>사업자등록증 사진<br />
				<% //null로 비어있는 상태면 default.png 띄워주기 
				   if(hosDto.getHosNumPhoto() == null) {%>
					<img src="/petBill/review/imgs/default.png" width="200" /><br />
				<% }else{ %> 
					<img src="/petBill/photo/<%=hosDto.getHosNumPhoto()%>" width="200" /><br />
				<% }%>
					* 사진변경(N/N) : <input type="file" name="hosNumPhoto"/><br />
				</td>
			</tr>
			<tr>
				<td>병원장 약력<br />
				<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
				   if(hosDto.getHosBio() == null) {%>
					<textarea name="hosBio" rows="10" cols="25" placeholder="2000자 내외"></textarea>
				<% }else{ %> 
					<textarea name="hosBio" rows="10" cols="25""><%=hosDto.getHosBio()%></textarea>
				<% }%>
			
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="저장하기"/>
					<input type="button" value="취소" onclick="window.location='../hospital/hosMypage.jsp'"/>
				</td>
			</tr>
		</table>
	</form>
	</div>
	
<%	}//else %>
<body>

</body>
</html>