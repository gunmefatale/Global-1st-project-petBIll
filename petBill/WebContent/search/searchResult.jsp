<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.hos.model.HosDTO"%>
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="pet.hos.model.AvgPriceDTO"%>

    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"> 
		<title>searchResult</title>
		
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<%-- 	
		<style>
			table {
				width: 600px;
				height: 300px;
			}
		</style>
	--%>
		<%-- (36) 아래 jquery 사용하기 위한 --%>	
		
	</head>
		
	<%
		// (7) 
		request.setCharacterEncoding("UTF-8");	
	
		// (7) main -> searchResult 검색시 병원 list 설정해주기.---------
		int pageSize = 5;
		
		// (7-1) 현제 페이지 번호 나타낼 파라미터 값 설정해주고 파라미터(값)이 없을때 설정해주기. 
		//		이유 : 파라미터 값이 있으면 파라미터 값을 들고 해당페이지가 보이게 페이징 처리 
		String pageNum = request.getParameter("pageNum");	// 요청시 페이지번호가 넘어왔으면 꺼내서 담기. 
		if (pageNum == null) {								// searchResult.jsp 라고만 요청했을때, 즉 pageNum 파라미터 안넘어왔을때. 
			pageNum = "1";									// pageNum에 파라미터값 1 설정해주기.
		}
		System.out.println("[searchResult](7-1) pageNum : " + pageNum);
		System.out.println("");
		
		// (7-1) 현제 페이지에 보여줄 게시글시작과 끝 등 정보 셋팅
		int currentPage = Integer.parseInt(pageNum);		// 계산을 위해 현재 페이지 String  타입에서 -> integer 로 형변환하여 숫자로 변환하여 저장.
		//		1      =	        		 "1"
		System.out.println("[searchResult](7-1) currentPage : " + currentPage);
		
		
		int startRow = (currentPage - 1) * pageSize + 1;	// 페이지 시작글 번호
		//		1	=	((1-1=0)*pageSize(5)=0)+1
		System.out.println("[searchResult](7-1) startRow : " + startRow);
		
		
		int endRow = currentPage * pageSize;				// 페이지 마지막 글번호
		//		5	=	(1*pageSize(5)=5)
		// 즉, startRow(1) , endRow(5) 값 int 타입으로 가지고 있음.
		System.out.println("[searchResult](7-1) endRow : " + endRow);
		
		
		// (8) 병원 list 가져올 메서드 만들기 위한 HosDAO 객체생성 싱글턴으로 가져오기. 
		//		검색창에 병원명 검색시 병원list 화면에 뿌려줄 hosSearch 변수에 파라미터가 들어갈 변수 만들어 주기
		HosDAO dao = HosDAO.getInstance();
		
		// (8-1) 검색창에 검색어 장성해서 병원list 요청했다면, 아래 hosSearch 변수에 파라미터가 들어갈것음. 
		//		(38-1) String 'guSel' 변수 만들어주어 해당 페이지에서 사용자가 구 클릭하면 해당 페이지 에 보여질 파라미터 만들어주기.
		String hosSearch = request.getParameter("hosSearch");
		System.out.println("[searchResult](8-1) hosSearch : " + hosSearch);
		System.out.println("");
		
		String guSel = request.getParameter("guSel");
		System.out.println("[searchResult](38-1) guSel : " + guSel);
		System.out.println("");
		
		
		// (9) 아래 지역변수 사용시 에러 안뜨게 밖에 필요한 변수 만들어 주기. List의 경우 검색 되었을때 또는 안되었을때 병원 리스트로 보여질 정보 배열로 담기위한.
		// 밖에서 상용 가능하게 if문 시작 전에 미리 선언
		List searchHospitalList = null;		// 전체(검색된) 병원list '배열'로 담아줄 변수
		int hosCount = 0;				// 병원 전체(검색된) 또는 병원 전체 병원들의 '갯수'
		int hosNumber = 0;					// 브라우저 화면에 뿌려 줄 '가상의 병원list 번호'
		
		
		// (11) 검색한 경우 
		if (hosSearch != null) {		// hosSearch가 "문자열"이기 때문에 null 로 사용함.
			// (11-1) getSearchHosListCount(String hosSearch) 메서드 만들러 가기.
			//		(11-9)
			hosCount = dao.getSearchHosListCount(hosSearch); // 검색된 병원list의 총개수 가져오기
			System.out.println("[searchResult](11-9) 검색된 hosCount : " + hosCount);
			System.out.println("");
			// (10) 검색한 병원리스트가 하나라도 있으면 검색한 병원 정보 가져오기 
			if (hosCount > 0) {				// hospital table에 병원list가 0개 보다 많으면 실행. 
				// (10) hospital DB에 병원이 하나라도 있으면 병원list 모두 가져오기 (List import 해주기)
				//		검색창에 병원명 검색시 병원list 화면에 뿌려줄 hosSearch 변수에 파라미터가 들어갈 변수 만들어 주기
				// (12) 'HosDAO > getSearchHospitals(int start, int end, hosSearch) 메서드 생성 후 리턴값 가져오기'
				//			(12-18) getSearchHospital(startRow, endRow, hosName, hosSearch); 메서드 생성한거 위 List 변수 생성한 변수명에 변수에 담아주기.
				searchHospitalList = dao.getSearchHospitals(startRow, endRow, hosSearch);
			}
			
		// (18-19) 검색 안되었을 경우. 전체 게시판 요청.	
		} else {
			hosCount = dao.getHosTotalListCount();	// DB에 저장되어있는 병원의 총list 의 개수 가져와 담기.
			System.out.println("[searchResult](18-19) : 전체 병원list : " + hosCount);
			System.out.println("");
			
			// (18-20) 검색안되었을경우 전체 병원 list 나와야 하므로 
			if (hosCount > 0) {
				searchHospitalList = dao.getTotalHospitals(startRow, endRow);
				// (19) 아래 병원list가 많을시 '페이지 번호' 만들어 주기.
			}
		}
		
		// (10-20) 게시판 목록에 뿌려줄 가상의 글 번호 설정 하기. 
		//	  이유 : 클라이언트에게는 정렬되어 진 글들에 순차적인 가상의 번호를 보여주면 더 깔끔해 보이기 때문에.
		hosNumber = hosCount - (currentPage - 1) * pageSize;
		//		 병원 총(검색/총) 리스트 수 - (현재페이지(1) - 1) * pageSize(5);
		//	 ex)		24 - ((1 - 1)= 0) * 10 = 24 ==> No. 에 최상위가 35 로 됨. 
		System.out.println("[searchResult](10-20) hosNumber : " + hosNumber);
		System.out.println("");
		
		
		// (38) searchResult페이지에서 사용자가 '구' 선택시 병원이 0개 이상일때 해당 진료비 평균 나타내기.
		//		불러올 변수값 미리 생성해주기.
		int countAvg = 0;
		
		// (39) 평균 값 가져올 메서드 만들러 가기 > HosDAO 
		//		(40) 리턴 받은 AvgPriceDTO 메서드에 담아주기.
		AvgPriceDTO avgDto = dao.getAvgPriceInfo(guSel);
		// 			(41) subMain 페이지에서 'guSel' 초기값 지정해주기. 
		//			이유 : subMain -> searchResult로 넘어올때 기본적으로 '강남구'가 선택되어있게끔 하기 위함. subMain로 이동 
		
		String userId = (String)session.getAttribute("userId");
		String hosId = (String)session.getAttribute("hosId");
		String admin = (String)session.getAttribute("admin");
		
	%>	
			
	<body>
		<%-- (36) jquery로 '구' select box 선택시 선택된 값 변경되게 화면에 뿌려주기 위한 작업하기. --%>
		
		<script>
		
		<%-- (36-2) jQuery 및 ajax 선언 해주기. --%>
			$(document).ready(function(){
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
							var reSplited = result.trim().split(" "); // 결과를 , 구분으로 분할해서 다시 저장 
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
					});	// close of the 'ajax' 
				});	// close of the 'change(function)' --%>
			}); // close of the 'ready(function)'
			<%-- (37) getGuAvg.jsp 파일 만들어 'Pro'페이지 기능 만들어 주기. --%>
			
		</script> 
		<%-- (36) 아래 select option태그 값 지정해주기. ------------------------------------------------------------- --%>
	
		<div align="right">
			<ul>
				<li>
					<div align="right">
						<% if(hosId != null){%>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'">마이페이지</button>
						<%}else if(userId != null){ %>
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button>
						<button onclick = "window.location = '/petBill/user/userMypage.jsp'">마이페이지</button>
						<%}else if(admin != null){%> 
						<button onclick = "window.location = '/petBill/user/logoutPro.jsp'">로그아웃</button> 
						<button onclick = "window.location = '/petBill/review/reivewContent.jsp'">마이페이지</button> 
						<%}else{ %>
						<button onclick = "window.location = '/petBill/user/loginForm.jsp'">로그인</button>
						<button onclick = "window.location = '/petBill/user/signupMain.jsp'">회원가입</button>
						<%} %> 
					</div>
				</li>
			</ul> 
		</div>
		
		
		<h1 align="center">
			<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고.png" width="200"/></a>
		</h1>
		<br />
		<br />
		<%-- (4-1) search(검색)form 만들기. --%>
		<div align="center">
			<section>
				<form action="searchResult.jsp">
					<input type="text" name="hosSearch" placeholder="병원명 검색(OO동물병원)" />
					<input type="submit" value="검색" /> 
				</form>
			</section>
		</div>
		
		<br />
		<br />
		
		<%-- (4-2) main -> searchResult 에 구 평균 form 만들어주기. --%>
		<br />
		<br />
		<div align="center">
			<form> 
				<h2>지역평균 진료비</h2>
				
				<table border="1" bgcolor="lightblue" width=70%>
					<tr align="center">
						<td>
							<select name="hosSiAddress">
								<option value="서울특별시" selected> 서울특별시 </option>
							</select>
						</td>
						<td>기초접종</td>
						<td>중성화(남)</td>
						<td>중성화(여)</td>
						<td>심장사상충</td>
					</tr>
					<%-- (37) 위 (36) jQuery 값지정해준거 select option태그에 담아주기. --%>
					<tr>
						<th>
							<select name="guSel" id="sel">
								<option value="notSelect" selected> 구 선택 </option>
								<option value="강남구"> 강남구 </option>
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
						</th>
						<th><span id="basic"></span>원</th>
						<th><span id="man"></span>원</th>
						<th><span id="woman"></span>원</th>
						<th><span id="heart"></span>원</th>
				
					</tr>
			
					<%-- (38) 위 자바 구간에 화면에 '구'평균 뿌려질 정보 만들러 가기. --%>
				</table>
			</form>
		</div>
		
		<br />
		<br />
		
		
		<%-- (4-3) searchResult(검색) 게시판 결과 form 만들기. --%>
		<h2 align="center"> 병원 리스트 </h2>
		
<% 
	// (5-18) 아래 if문으로 병원 리스트가 없을때와 있을때 분류하여 보여주는 틀 만들기.
	//		DB에 병원 list가 없으면 보여주는 form
	if (hosCount == 0) {
%>
		<div align="center">
			<table border="1" bgcolor="lightblue" width=70%>
				<tr>
					<td>No</td>
					<td>병원이름</td>
					<td>주소</td>
					<td>리뷰평</td>
				</tr>
				<tr>
					<th colspan="4" align="center">
						병원 정보 없습니다.
					</th>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<button onclick="window.location='main.jsp'">
							메인으로
						</button>
					</td>
				</tr>
			</table>
		</div>
			
<%
	// (5-19) DB에 병원list가 있다면 보여주는 form 
	} else {
%>	
		<div align="center">
			<table border="1" bgcolor="lightblue" width=70%>
				<tr>
					<td>No</td>
					<td>병원이름</td>
					<td>주소</td>
					<td>리뷰평(병원전화)</td>
				</tr>
			<%
				// (5-20) for문을 이용하여 조건식에 해당되면 반복해주기. 
				//    이유 : 클라이언트가 페이지를 어떻게 왔다 갔다 할지 모르니 이동 할때마다 화면에 뿌려주기 위해.
				//			즉, 사용자가 다른 페이지 갔다가 다시 올아올 경우 게시글 목록들을 개발자가 일일이 작성하여,
				//			뿌려주기 어려움으로 중간에 for문을 이용하여 조건에 맞으면 계속 브라우저에 화면 띄워주기. 
				for (int i = 0; i < searchHospitalList.size(); i++) {	// searchHospitalList DB에 데이터의 크기 만큼 반복하겠다. 
					
					// searchHospitalList 경우 HosDAO 파일에서 보면 'ArrayList();' 객체생성 되어 '배열'로 값들이 저장되어 있다. 
					// 여기서 for문 i=0 부터 시작하니 0번째 배열 index번호 부터 꺼내어 가져와 (get(i(0,1,2,....searchHospitalList의 값이 있는 만큼)))
					// searchHospitalList 담는데, 문제는 searchHospitalList 'Object' 타입이라 'HosDTO'로 형변환 하여 객체생성 해야 한다.
					// 그리하여, HosDTO의 get/set메서드를 사용할수 있다.
					HosDTO dto = (HosDTO)searchHospitalList.get(i);
			%>
					<%-- (5-21) 웹 브라우저에 보여질 게시판의 글들 form 만들어주기 --%>
				<tr>
					<%-- hosNumber-- 해주는 이유는 반복하여 보여질텐데 No.의 hosNumber가 계속 같은번호면 안되므로,
						 최대의 No. 번호가 맨위로 가고 No. '-1'씩 반복하여 No.에 적용되어 보여짐.
						 |No|병원이름|주소|리뷰평| *(리뷰평은 임시로 hosTel로 함)
						 |35|__x___|xx_|_x__|
						 |34|__x___|xx_|_x__|
						 |33|__x___|xx_|_x__|
						 |32|__x___|xx_|_x__|
						
						 즉, No 라인의 가상의 번호가 사용자에게 -1씩되어 리스트 형식으로 보여줘야 하기 때문에 
					--%>
					<%-- (5-20) --%>
					<td><%=hosNumber-- %></td>
					<td><a href="/petBill/hospital/hosContent.jsp?hosNo=<%=dto.getHosNo()%>&pageNum=<%=pageNum%>"><%=dto.getHosName() %></a></td>
					<td><a><%=dto.getHosNewAddress() %></a></td>
					<td><a><%=dto.getHosTel() %></a></td>
				</tr>	
			<% 
				} // close of the 'for' (5-20)
			%>
				
			</table>
		</div>
<%
	} // close of the 'else' (5-19)
%>
			<%-- (5) HosDTO get/set 메서드 만들고, (6) HosDAO 싱클턴 및 getConnection() 메서드 만들기. --%>
			
			<%-- (19) 조건문으로 병원list가 0개 이상이면 하단에 병원list 페이지 설정 해주기. ex) < 1 2 3 4 5 > --%>
		<br />
		<br />
		
		<div align="center">
			
		<%
			// (19) 조건문으로 병원list가 0개 이상이면 하단에 병원list 페이지 설정 해주기. ex) < 1 2 3 4 5 >
			if (hosCount > 0) {
				// (19-1) 페이지 번호를 몇개까지 보여줄것인지 지정
				int pageBlock = 5;
				// (19-2) 총 몇페이지가 나오는지 계산
				int pageCount = hosCount / pageSize + (hosCount % pageSize == 0 ? 0 : 1);
				// hosCount(병원(총/검색) 리스트 수) / pageSize(5) + (hosCount(병원(총/검색)리스트 수) % pageSize(10) == 0 ? 0 : 1)
				//   (hosSearchCount)
				// ex)	hosCount(50) / pageSize(10) + (hosCount(50) % pageSize(10) == 0 ? 0 : 1)
				//					50 / 5 + (10 % 5 == 0) == > 5 페이지 나옴.
				//					813 / 5 + (813 % 10 == 1) ==> 22.9 페이지 나옴. (int)기 때문에 뒤 소수점 없에고 22 나옴 
				//					34 / 5 + (34 % 10 == 1) ==> 4.6 페이지 나옴. (int)기 때문에 뒤 소수점 없에고 4 나옴 
				
				// (19-3) 현재 페이지에서 보여줄 첫번째 페이지번호 
				int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
				//				(정수)((currentPage(1) - 1) / pageBlock(5) * pageBlock(5) + 1)
				// ex)	3인 경우 :	((1-1)0 / 3) * 3 + 1	==> 1 startPage
				//							((0/3=0)*3=0)+1
				// ex)	5인 경우 :	((1-1)0 / 5) * 5 + 1 ==> 1 startPage
				//							((0/5=0)*5=0)+1
				// ex)	11인 경우 :	((11-1=10) / 5=2) * 5 + 1 ==> 11 startPage
				//							((10/5=2)*5=10)+1 = 11
				
				
				// (19-4) 현재 페이지에서 보여줄 마지막 페이지 번호 (~10, ~20, ~30, ...)
				int endPage = startPage + pageBlock - 1; 
				// ex) 3인 경우 = startPage(1) + pageBlock(3) - 1 = 3	// 사용자에게 '< 1 2 3 >' 이렇게 보여짐  
				// ex) 5인 경우 = startPage(1) + pageBlock(5) - 1 = 5	// 사용자에게 '< 1 2 3 4 5 >' 이렇게 보여짐 
				// ex) 11인 경우 = startPage(11) + pageBlock(5) - 1 = 15	// 사용자에게 '< 11 12 13 14 15 >' 이렇게 보여짐 
				
				// (19-5) 마지막에 보여줄 페이지 번호는, 전체 페이지 수에 따라 달라질 수 있다. 
				// 		  전체 페이지 수 (pageCount)가 위에서 계산한 endPage(3단위씩)보다 작으면 
				// 		  전체 페이지 수가 endPage가 된다. 
				if (endPage > pageCount) {
				// ex)  3(endPage) > 4(pageCount) --> false
				// 	    5(endPage) > 4(pageCount) --> true > if 문 실행 
					endPage = pageCount;
				//	4(pageCount)를 endPage에 담겠다. => endPage는 4가 됨.
				} // close of the 'if' (19-4)
				
				// (19-6) 검색시, 페이지 번호 처리해주기 
				if (hosSearch != null) {
					
					// (19-7) 왼쪽 '<' 꺽쇄 만들기 : startPage 가 pageBlock(5)보다 크면 '왼쪽' 꺽쇄 만들어주기.  
					//		이유 : 사용자 및 개발자에게 편의를 위함과 페이지의 깔끔함을 위해.
					if (startPage > pageBlock) {
					// ex) 	  1	> 5 이면 맞지 않아 false 즉, 지금 페이지가 1 2 3 4 5 (pageBlock) 중 1~5페이지면 해당 사항 없음.
					// ex)  6(이상) > 5 이면 true여서 아래 조건문 실행. --> '<' 보여주며 클릭시 해당 페이지로 이동하기 
		%>
					<%-- 
						(19-8) jsp 문법으로 왼쪽 꺽쇄 '<' 보여주기. '&lt;'(< 왼쪽 꺽쇄) '&nbsp'(1칸 띄어쓰기) 및 'startPage-pageBlock' 추가 해주기 
								즉, 클릭시 '< ' 형태로 웹에 보여고, startPage-pageBlock 하여 해당 값의 맞는 page로 넘어가기.  
								ex) 		startPage(31)-pageBlock(3)
					--%>
						<a href="searchResult.jsp?pageNum=<%=startPage-pageBlock%>&guSel=<%=guSel%>&hosSearch=<%=hosSearch%>"> &lt; &nbsp; </a>
			<%
					} // close of the 'if' (19-7)
					
					// (19-9) 페이지 번호 웹 화면에 띄우기 
					//	ex)		i = 6; i <= 11; ==> '6 7 8 9 10 11'
					for (int i = startPage; i <= endPage; i++) {
			%>
					<%-- 
						(19-10) 페이지 번호를 클릭하면 맨위로 올라가 다시 실행하여 해당 페이지 요청하게 된다.(해당 페이지 재활용) 
						 ------------------------------- &nbsp; ==> '띄어쓰기 한 칸' 
						 <<a> 태그를 누르면 <i> 번쨔 리스트 페이지로 이동>, &nbsp;(한칸 띄우기) <%=i%>(int 웹에 숫자 보여지기) &nbsp;(한칸 띄우기) 
						및 pageNum 대입하여 해당 pageNum 값 입력해주기.
					--%>
						<a href="searchResult.jsp?pageNum=<%=i%>&guSel=<%=guSel%>&hosSearch=<%=hosSearch%>"> &nbsp; <%=i%> &nbsp; </a>
			<%
					System.out.println("[searchResult](19-10) pageNum(i) : " + i);
					System.out.println("[searchResult](19-10) hosSearch : " + hosSearch);
					System.out.println("");
					} // close of the 'for' (19-9)
					
					// (19-11) 오른쪽 '>' 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면 
					//		이유 : 사용자 및 개발자에게 편의를 위함과 페이지의 깔끔함을 위해.
					if (endPage < pageCount) {
					// ex) 6(이상) <	5 이면 if 문 실행 X 즉, DB에서 조건문에 해당하는 list들이 가져올것이 많으면 해당 조건은 26개 이상이면 아래 조건문 실행.
					//		즉, 위 (19-5) endPage 덮어 씌운게 (19-2)기존 pageCount 보다 작으면,
					//		즉, endPage(4) 보다 게시글이 더 많으면 '< '오른쪽 꺽쇄 보여지기. 
			%>
					<%-- 
						(19-12) 위 조건식이 맞아 사용자가 <a>태그를 클릭하면 '>' searchResult.jsp 페이지로 이동  
							&nbsp;(띄어쓰기) ' >(a태그 속성)' 웹상에 보여짐. '?pageNum=<%=startPage+pageBlock %>" 추가해주기'  
					--%>
						&nbsp; <a href="searchResult.jsp?pageNum=<%=startPage+pageBlock%>&guSel=<%=guSel%>&hosSearch=<%=hosSearch%>"> &gt; </a>
					<%-- 
															ex) startPage(6)+pageBlock(6)=(11) ==> '>'클릭시 (11) 페이지로 이동.
						해석 : ex) endPage(끝 페이지(10) < pageCount(총 페이지 수(21)) 조건문이 맞다면 <%=startPage(1)+pageBlock(11) ==> 즉 11페이지가 startPage에 담겨서 
						  			'>' pageNum으로 담겨 넘어가 사용자에게 11 12 13 ... 20 > 이런식으로 보여주며, 그에 맞는 병원리스트도 같이 보여줌. 
					--%>	
		<% 		
					} // close of the 'if' (19-11) 
				
				// (20) 검색 안됬을때
				} else { // close of the 'if' (19-6)
					// (20-1) 왼쪽 꺽쇄 '<'' : startPage 가 pageBlock(5)보다 크면 
			        if (startPage > pageBlock) { 
		%>
						<a href="searchResult.jsp?pageNum=<%=startPage-pageBlock%>"> &lt; &nbsp;</a>
			<%  
					} // close of the 'if' (20-1)
			         
			        // (20-2)페이지 번호 뿌리기 ex) < 1 2 3 4 5 >
			        for (int i = startPage; i <= endPage; i++) { 
			%>
			            <a href="searchResult.jsp?pageNum=<%=i%>"> &nbsp; <%=i%> &nbsp; </a>
			<%   
			      	} // close of the 'for' (20-2)
			         
			        // (20-3) 오른쪽 꺽쇄 '>' : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
			        if (endPage < pageCount) { 
			%>
			            &nbsp; <a href="searchResult.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
			<%   	
					} // close of the 'if' (20-3)
				} // close of the 'else' (20)
			} // close of the 'if' (19)
		%>
		<%-- (21) searchMain 페이지 기능 만들어 주기. --%>
		</div>
		
	</body>
</html>