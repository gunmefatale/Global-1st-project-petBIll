<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신규 병원회원가입</title>
	
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

	<div align="center" class="logo">
		<!-- 메인 로고 -->
		<a href="/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	
<!-- ======================================상단메뉴 구분선========================================= -->
	
	<h1 align="center">신규 병원회원가입</h1>
	<div align="center">
	
	<!-- enctype="multipart/form-data" 파일 업로드위해 추가 -->
	<form action="hosSignupPro.jsp" method="post" name="hosInputForm" enctype="multipart/form-data" >
		<table>
			<tr>
				<td>아이디*<br />
				<input type="text" name="hosId" placeholder="영문+숫자조합" />
				<input type="button" value="중복체크" onclick="confirmHosId(this.form)"/></td>
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
				<td>병원명*<br />
				<input type="text" name="hosName"/>
				</td>
			</tr>
			<tr>
				<td>전화번호*<br />
				<input type="text" name="hosTel" placeholder="'-'포함해서 입력"/>
				<input type="button" value="중복체크" onclick="confirmHosTel(this.form)"/>
				</td>
			</tr>
			<tr>
			<td>도로명 주소*<br />
				<select name="hosSiAddress" >
					<option value="서울특별시">서울특별시</option>
				</select>
			<select name="hosGuAddress">
					<option value="종로구" selected>종로구</option>
					<option value="중구">중구</option>
					<option value="용산구">용산구</option>
					<option value="성동구">성동구</option>
					<option value="광진구">광진구</option>
					<option value="동대문구">동대문구</option>
					<option value="중랑구">중랑구</option>
					<option value="성북구">성북구</option>
					<option value="강북구">강북구</option>
					<option value="도봉구">도봉구</option>
					<option value="노원구">노원구</option>
					<option value="은평구">은평구</option>
					<option value="서대문구">서대문구</option>
					<option value="마포구">마포구</option>
					<option value="양천구">양천구</option>
					<option value="강서구">강서구</option>
					<option value="구로구">구로구</option>
					<option value="금천구">금천구</option>
					<option value="영등포구">영등포구</option>
					<option value="동작구">동작구</option>
					<option value="관악구">관악구</option>
					<option value="서초구">서초구</option>
					<option value="강남구">강남구</option>
					<option value="송파구">송파구</option>
					<option value="강동구">강동구</option> </select> 
					
					<input type="text" name="hosNewAddress" placeholder="상세주소 입력"/>
				</td>
			</tr>
			<tr>
				<td>지번 주소<br />
				<input type="text" name="hosOldAddress"/>
				</td>
			</tr>
			<tr>
				<td>영업시간<br />
				<input type="text" name="hosTime" placeholder="ex) 09:00~18:00"/>
				</td>
			</tr>
			<tr>
				<td>사업자 등록번호<br />
				<input type="text" name="hosNum" placeholder="'-'포함해서 입력"/>
				</td>
			</tr>
			<tr>
				<td>사업자등록증 사진(N/N)<br />
				<input type="file" name="hosNumPhoto" />
				</td>
			</tr>
			<tr>
				<td>대표자 사진(N/N)<br />
				<input type="file" name="hosProfile" />
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

<body>

</body>
</html>