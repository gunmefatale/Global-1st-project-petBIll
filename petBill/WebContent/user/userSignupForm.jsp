<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<script>
	function check(){//체크 메서드
		var inputs = document.inputForm;
	
		if(!inputs.userId.value){//id 값이 없을때
			alert("아이디를 입력하세요.")
			return false;
		}
		if(!inputs.userPw.value){
			alert("비밀번호를 입력하세요")
			return false;
		}
		if(!inputs.userPwch.value){
			alert("비밀번호확인란을 입력하세요")
			return false;
		}
		if(!inputs.userName.value){
			alert("이름을 입력하세요")
			return false;
		}
		if(!inputs.userMobile.value){
			alert("휴대폰 번호를 입력하세요")
			return false;
		}
		if(!inputs.userNick.value){
			alert("닉네임을 입력하세요")
			return false;
		}
		
		//비밀번호와 비밀번호 확인란 작성값 동일 체크
		if(inputs.userPw.value != inputs.userPwch,value){
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
	}
<%--
	function userMobile(p) {
		var inputs = document.inputForm;

		p = p.split('-').join('');

		var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;

		return regPhone.test(p);

		}
		
--%>
		//아이디 중복체크
		
		function confirmId(inputForm){
			if(inputForm.userId.value == "" || !inputForm.userId.value){//유저id값이 빈칸이거나 값이 없을때
				alert("아이디를 입력하세요.");
				return; //강제종료
			}
			//팝업으로 띄우기
			var url = "confirmId.jsp?userId=" + inputForm.userId.value;//ex)confirmId.jsp?userId=java
			open(url, "conformId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizeable=no, width=500, height=300");
		}
		
		function confirmNick(inputForm){
			if(inputForm.userNick.value == "" || !inputForm.userNick.value){
				alert("닉네임을 입력하세요.");
				return;
			}
			//팝업으로 띄우기
			var url = "confirmNick.jsp?userNick=" + inputForm.userNick.value;
			open(url, "conformNick", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizeable=no, width=500, height=300");
		}
		


</script>



<body>
	<div align="right">
		<button onclick = "window.location = 'loginForm.jsp'">로그인</button>
		<button onclick = "window.location = 'signupMain.jsp'">회원가입</button>
	</div>
	
	<div style="text-align : center;">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
	</div>
	
	
	<br/>
	<h1 align = "center">일반 회원가입</h1>
	
	<form action="userSignupPro.jsp" method="post" name="inputForm" onsubmit = "return check()">
	<br/>
		<table align="center">
			<tr>
				<td>아이디*<br/>
				<input type="text" name="userId"/>&nbsp;<input type="button" value="중복 체크" onclick="confirmId(this.form)"/></td>
			</tr>
			<tr>
				<td>비밀번호*<br/>
				<input type="password" name="userPw"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인*<br/>
				<input type="password" name="userPwch" /></td>
			</tr>
			<tr>
				<td>이름*<br/>
				<input type="text" name="userName"/></td>
			</tr>
			<tr>
				<td>휴대폰*<br/>
				<input type="text" name="userMobile" placeholder="010-0000-0000" maxlength="13" onclick = ""/></td>
			</tr>
			<tr>
				<td>닉네임*<br/>
				<input type="text" name="userNick"/>&nbsp;<input type="button" value="중복 체크" onclick="confirmNick(this.form)"/></td>
			</tr>
			<tr>
				<td>주소<br/>
					<select name="userSiAddress">
						<option value="서울특별시">서울특별시</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<select name="userSelectAddress">
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
						<option value="강동구">강동구</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="userDetailAddress"/>
				</td>
			</tr>
			
			<tr>	
				<td>
					<input type="submit" value="가입"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="취소" onclick= "window.location='/petBill/search/main.jsp'"/>
				</td>
			</tr>
			
		</table>
	</form>



</body>
</html>