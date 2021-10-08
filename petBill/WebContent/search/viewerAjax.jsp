<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>viewerAjax</title>
	
	<%-- 
		jquery를 사용하고 싶을때에는 
		jquery페이지 > download > bower install란의 
		'https://code.jquery.com/jquery-3.6.0.min.js' 복사여 붙혀넣기. (CDM 방식) 
		==> 인터넷이 상시 가능할때엔 위처럼 사용.
		
		하지만, 인터넷이 불안한 곳에서는 해당 쿼리문을 프로젝트에 파일로 넣어 사용
		
	 --%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <%-- jquery,ajax 사용시 라이브러리 추가, cdn 방식 --%>

	<script>
		// jquery 
		/*
		$(document).ready(function(){ // 문서가 준비되면 실행해라~ 
			// jquery, ajax, javascript 
			// 버튼 이벤트 등록 
			$("#btn").click(function(){
				alert("button clicked!!!");
			});
		});*/
		
			/*
			$.ajax({
		        url: "/board/write", // 요청할 주소 
		        type: "post", // 요청 방식 
		        dataType: "json", // 응답으로 돌려받는 데이터의 타입  
		        contentType: "application/json", // 요청할때 보내는 데이터의 타입 
		        data: JSON.stringify(requestData), // 요청할때 보내는 데이터명시 
		        success: function(resultData) { // 요청이 성공하면 실행할 명령을 function안에 작성 
		            // TODO : 결과로 받은 resultData로 작업 !
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		            // 에러 로그는 아래처럼 확인해볼 수 있다. 
		            alert("업로드 에러\ncode : " + jqXHR.status + "\nerror message : " + jqXHR.responseText);
		        }
			}); */
		
		
		/* $(document).ready(function(){ // 문서가 준비되면 실행해라~ 
			
			// 셀렉트태그에 변경이 있으면, 디비에 해당 구를 주면서 그 구에 평균들을 받아와야된다. 
			// 이벤트 등록 : 셀렉트 태그가 변경이 있을때, 에이작스 요청 
			// 에이작스 요청할때 필요한것 : 디비에서 처리를 해서 결과 가져올 프로페이지에 해당하는 jsp 페이지 필요 
			// 				 데이터 보낼거 : 구 (강남구, 종로구)
			//				 데이터 돌려받을거 : 평균 값들 
			$("#sel").change(function(){
				// 어떤 옵션을 선택했는지 (선택한 구)값을 스크립트로 가져오기 
				var guValue = $("#sel").val();
				console.log("selected gu : " + guValue);
				$.ajax({
					url : "getGuAvg.jsp",
					type : "POST", 
					data : "guValue="+guValue,
					success : function(result){
						console.log("Result : " + result); // 결과 그대로 출력 
						var reSplited = result.trim().split(","); // 결과를 , 구분으로 분할해서 다시 저장 
						console.log(reSplited); // 분할한 결과 출력 -> 배열에 순서대로 담겨있는것 확인됨 
						// 아래 뿌려줘야되는 화면상 태그에 각각 데이터 적용 
						$("#basic").text(reSplited[0]);
						$("#man").text(reSplited[1]);
						$("#woman").text(reSplited[2]);
						$("#heart").text(reSplited[3]);
					},
					error : function(e){
						console.log(e);
					}
				});
			});
			
		}); // ready
		 */
		
	</script>
</head>
<body>
	<table>
		<tr>
			<td><span id="basic"></span>원</td>
			<td><span id="man"></span>원</td>
			<td><span id="woman"></span>원</td>
			<td><span id="heart"></span>원</td>
		</tr>
	</table>
	<br />
	
	<select name="guSel" id="sel">
		<option value="강남구" selected> 강남구 </option>
		<option value="강동구"> 강동구 </option>
		<option value="강서구"> 강서구 </option>
		<option value="강북구"> 강북구 </option>
		<option value="관악구"> 관악구 </option>
		<option value="광진구"> 광진구 </option>
		<option value="구로구"> 구로구 </option>
		<option value="금천구"> 금천구 </option>
		<option value="노원구"> 노원구 </option>
		<option value="동대문구"> 동대문구 </option>
		<option value="도봉구"> 도봉구 </option>
		<option value="동작구"> 동작구 </option>
		<option value="마포구"> 마포구 </option>
		<option value="서대문구"> 서대문구 </option>
		<option value="성동구"> 성동구 </option>
		<option value="성북구"> 성북구 </option>
		<option value="서초구"> 서초구 </option>
		<option value="송파구"> 송파구 </option>
		<option value="영등포구"> 영등포구 </option>
		<option value="용산구"> 용산구 </option>
		<option value="양천구"> 양천구 </option>
		<option value="은평구"> 은평구 </option>
		<option value="종로구"> 종로구 </option>
		<option value="중구"> 중구 </option>
		<option value="중랑구"> 중랑구 </option>
	</select>

</body>
</html>