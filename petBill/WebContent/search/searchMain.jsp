<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="pet.hos.model.HosDTO"%>
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <title>searchMain</title> 
	</head>
		
	<%
		// (21) searchMain 페이지 기능 설정해주기. 
		request.setCharacterEncoding("UTF-8");
	
		// (21-1) main -> searchMain으로 검색시 보여질 병원list의 갯수 설정해주기. 
		int mainPageSize = 10;
		
		// (21-2) 현제 페이지 번호 나타낼 파라미터 값 설정해주고 파라미터(값)이 없을때 설정해주기. 
		//		이유 : 파라미터 값이 있으면 파라미터 값을 들고 해당페이지가 보이게 페이징 처리 
		String pageNum = request.getParameter("pageNum");	// 요청시 페이지번호가 넘어왔으면 꺼내서 담기. 
		if (pageNum == null) {								// searchResult.jsp 라고만 요청했을때, 즉 pageNum 파라미터 안넘어왔을때. 
			pageNum = "1";									// pageNum에 파라미터값 1 설정해주기.
		}
		System.out.println("[searchMain](21-2) pageNum : " + pageNum);
		System.out.println("");
		
		// (21-3) 현제 페이지에 보여줄 게시글시작과 끝 등 정보 셋팅
		int mainCurrentPage = Integer.parseInt(pageNum);		// 계산을 위해 현재 페이지 String  타입에서 -> integer 로 형변환하여 숫자로 변환하여 저장.
		//		1      =	        		 "1"
		System.out.println("[searchMain](21-3) mainCurrentPage : " + mainCurrentPage);
		
		
		int mainStartRow = (mainCurrentPage - 1) * mainPageSize + 1;	// 페이지 시작글 번호
		//		1	=	((1-1=0)*pageSize(10)=0)+1
		System.out.println("[searchMain](21-3) mainStartRow : " + mainStartRow);
		
		
		int mainEndRow = mainCurrentPage * mainPageSize;				// 페이지 마지막 글번호
		//		10	=	(1*pageSize(10)=10)
		// 즉, startRow(1) , endRow(10) 값 int 타입으로 가지고 있음.
		System.out.println("[searchMain](21-3) mainEndRow : " + mainEndRow);
		
		// (21-4) 병원 list 가져올 메서드 만들기 위한 HosDAO 객체생성 싱글턴으로 가져오기. 
		//		검색창에 병원명 검색시 병원list 화면에 뿌려줄 hosSearch 변수에 파라미터가 들어갈 변수 만들어 주기
		HosDAO dao = HosDAO.getInstance();
		
		// (21-5) 검색창에 검색어 장성해서 병원list 요청했다면, 아래 hosSearch 변수에 파라미터가 들어갈것음. 
		String mainHosSearch = request.getParameter("mainHosSearch");
		System.out.println("[searchMain](21-5) mainHosSearch : " + mainHosSearch);
		System.out.println("");
		
		// (21-6) 아래 지역변수 사용시 에러 안뜨게 밖에 필요한 변수 만들어 주기. List의 경우 검색 되었을때 또는 안되었을때 병원 리스트로 보여질 정보 배열로 담기위한.
		// 밖에서 상용 가능하게 if문 시작 전에 미리 선언
		List searchMainHospitalList = null;		// 전체(검색된) 병원list '배열'로 담아줄 변수
		int hosMainCount = 0;						// 병원 전체(검색된) 또는 병원 전체 병원들의 '갯수'
		int hosMainNumber = 0;						// 브라우저 화면에 뿌려 줄 '가상의 병원list 번호'
			
		// (21-7) 검색한 경우 
		if (mainHosSearch != null) {		// hosSearch가 "문자열"이기 때문에 null 로 사용함.
			// (21-8) DB에 저장되어있는 병원의 갯수(count(*)) 가져오기.
			//		이유 : 아래 if문으로 병원리스트가 있는지 없는지 분리하여 페이징 처리 위함.
			//		(22) igetSearchMainHosListCount(hosSearch) 메서드 만들러 가
			//			(22-13) 리턴받은 변수 타입으로 담아주기.
			hosMainCount = dao.getSearchMainHosListCount(mainHosSearch); // 검색된 병원list의 총개수 가져오기
			System.out.println("[searchMain](22-13) 검색된 hosMainCount : " + hosMainCount);
			System.out.println("");
			// (23) 검색한 병원리스트가 하나라도 있으면 검색한 병원 정보 가져오기 
			if (hosMainCount > 0) {				// hospital table에 병원list가 0개 보다 많으면 실행. 
				// (24) hospital DB에 병원이 하나라도 있으면 병원list 모두 가져오기 (List import 해주기)
				//		검색창에 병원명 검색시 병원list 화면에 뿌려줄 hosSearch 변수에 파라미터가 들어갈 변수 만들어 주기
				//     'HosDAO > getSearchHospitals(int start, int end, hosSearch) 메서드 생성 후 리턴값 가져오기'
				//			(24-1) 메서드 만들어주기 -> getSearchHospital(startRow, endRow, hosName, hosSearch); 메서드 생성한거 위 List 변수 생성한 변수명에 변수에 담아주기.
				//					(23) 리턴값 갖고온 메서드 List타입의 변수로 담아주기.
				searchMainHospitalList = dao.getSearchMainHospitals(mainStartRow, mainEndRow, mainHosSearch);
			}
			
		// (24) 검색 안되었을 경우. 전체 게시판 요청.	
		} else {
			// (24) 전체 글 가져오기를 위한 check 위한 총 병원list count(*) 로 가져와 변수에 담기.
			//		(24-1) 리턴값 가져온 메서드 확인 후 변수에 저장하기.
			//			(25-2) 
			hosMainCount = dao.getHosTotalListCount();	// DB에 저장되어있는 병원의 총list 의 개수 가져와 담기.
			System.out.println("[searchMain](25-2) : 전체 병원list : " + hosMainCount);
			System.out.println("");
			
			// (26) 검색안되었을경우 전체 병원 list 나와야 하므로 
			if (hosMainCount > 0) {
				// (27) 병원 전체 리스트 가져오는 메서드 확인 후 리턴 변수에 담아주기. -> DAO
				//		
				searchMainHospitalList = dao.getTotalHospitals(mainStartRow, mainEndRow);
				// (27) 아래 병원list가 많을시 '페이지 번호' 만들어 주기.
			}
		}
		
		// (28-1) 게시판 목록에 뿌려줄 가상의 글 번호 설정 하기. 
		//	  이유 : 클라이언트에게는 정렬되어 진 글들에 순차적인 가상의 번호를 보여주면 더 깔끔해 보이기 때문에.
		hosMainNumber = hosMainCount - (mainCurrentPage - 1) * mainPageSize;
		//		 병원 총(검색/총) 리스트 수 - (현재페이지(1) - 1) * pageSize(5);
		//	 ex)		24 - ((1 - 1)= 0) * 10 = 24 ==> No. 에 최상위가 35 로 됨. 
		System.out.println("[searchMain](28-1) : " + hosMainNumber);
		System.out.println("");
		
		String userId = (String)session.getAttribute("userId");
		String hosId = (String)session.getAttribute("hosId");
		String admin = (String)session.getAttribute("admin");
		
	%>
		
	 
	<body>
		<%-- (3) main Form 틀 만들기  --%>
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
		
		<%-- (3-2) search(검색)form 만들기. --%>
		<div align="center">
			<section>
				<form action="/petBill/hospital/hosContent.jsp">
					<input type="text" name="mainHosSearch" placeholder="병원명 검색" />
					<input type="submit" value="검색" /> 
				</form>
			</section>
		</div>
		<%-- (4) searchResult.jsp 폼 만들어주기. --%>
		
		<%-- (29) if문으로 DB에 저장되어있는 병원 있을시/없을시 나누어 페이징 처리해주기. --%>
		<br />
		<br />
<%
	//(30-1) 아래 if문으로 병원 리스트가 없을때와 있을때 분류하여 보여주는 틀 만들기.
	//		DB에 병원 list가 없으면 보여주는 form
	if (hosMainCount == 0) {
%>	
		<div align="center">
			<table border="1" bgcolor="yellow" width=70%>
				<tr>
					<td>No</td>
					<td>병원이름</td>
					<td>주소</td>
					<td>리뷰평(병원번화(임시))</td>
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
	// (30-2) DB에 병원list가 있다면 보여주는 form 
	} else { // close of the 'if' (30-1)
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
				// (30-3) for문을 이용하여 조건식에 해당되면 반복해주기. 
				//    이유 : 클라이언트가 페이지를 어떻게 왔다 갔다 할지 모르니 이동 할때마다 화면에 뿌려주기 위해.
				//			즉, 사용자가 다른 페이지 갔다가 다시 올아올 경우 게시글 목록들을 개발자가 일일이 작성하여,
				//			뿌려주기 어려움으로 중간에 for문을 이용하여 조건에 맞으면 계속 브라우저에 화면 띄워주기. 
				for (int i = 0; i < searchMainHospitalList.size(); i++) {	// searchHospitalList DB에 데이터의 크기 만큼 반복하겠다. 
					
					// searchHospitalList 경우 HosDAO 파일에서 보면 'ArrayList();' 객체생성 되어 '배열'로 값들이 저장되어 있다. 
					// 여기서 for문 i=0 부터 시작하니 0번째 배열 index번호 부터 꺼내어 가져와 (get(i(0,1,2,....searchHospitalList의 값이 있는 만큼)))
					// searchHospitalList 담는데, 문제는 searchHospitalList 'Object' 타입이라 'HosDTO'로 형변환 하여 객체생성 해야 한다.
					// 그리하여, HosDTO의 get/set메서드를 사용할수 있다.
					HosDTO mainDto = (HosDTO)searchMainHospitalList.get(i);
			%>
					<%-- (30-4) 웹 브라우저에 보여질 게시판의 글들 form 만들어주기 --%>
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
					<%-- (30-5) --%>
					<td><%=hosMainNumber-- %></td>
					<td><a href="/petBill/hospital/hosContent.jsp?hosNo=<%=mainDto.getHosNo()%>&pageNum=<%=pageNum%>"><%=mainDto.getHosName() %></a></td>
					<td><a><%=mainDto.getHosNewAddress() %></a></td>
					<td><a><%=mainDto.getHosTel() %></a></td>
				</tr>	
			<% 
				} // close of the 'for' (5-20)
			%>
				
			</table>
		</div>
<% 
	} // close of the 'else' (30-2)
%>

	<%-- (31) 조건문으로 병원list가 0개 이상이면 하단에 병원list 페이지 설정 해주기. ex) < 1 2 3 4 5 > --%>
		<br />
		<br />
		<div align="center">
	<%
		// (32) 조건문으로 병원list가 0개 이상이면 하단에 병원list 페이지 설정 해주기. ex) < 1 2 3 4 5 >
		if (hosMainCount > 0) {
			// (32-1) 페이지 번호를 몇개까지 보여줄것인지 지정
			int mainPageBlock = 5;
			// (32-2) 총 몇페이지가 나오는지 계산
			int mainPageCount = hosMainCount / mainPageSize + (hosMainCount % mainPageSize == 0 ? 0 : 1);
			// hosCount(병원(총/검색) 리스트 수) / pageSize(10) + (hosCount(병원(총/검색)리스트 수) % pageSize(10) == 0 ? 0 : 1)
			//   (hosSearchCount)
			// ex)	hosCount(50) / pageSize(10) + (hosCount(50) % pageSize(10) == 0 ? 0 : 1)
			//					50 / 5 + (10 % 5 == 0) == > 5 페이지 나옴.
			//					813 / 5 + (813 % 10 == 1) ==> 22.9 페이지 나옴. (int)기 때문에 뒤 소수점 없에고 22 나옴 
			//					34 / 5 + (34 % 10 == 1) ==> 4.6 페이지 나옴. (int)기 때문에 뒤 소수점 없에고 4 나옴 
			
			// (33-3) 현재 페이지에서 보여줄 첫번째 페이지번호 
			int mainStartPage = (int)((mainCurrentPage - 1) / mainPageBlock) * mainPageBlock + 1;
			//				(정수)((currentPage(1) - 1) / pageBlock(5) * pageBlock(5) + 1)
			// ex)	3인 경우 :	((1-1)0 / 3) * 3 + 1	==> 1 startPage
			//							((0/3=0)*3=0)+1
			// ex)	5인 경우 :	((1-1)0 / 5) * 5 + 1 ==> 1 startPage
			//							((0/5=0)*5=0)+1
			// ex)	11인 경우 :	((11-1=10) / 5=2) * 5 + 1 ==> 11 startPage
			//							((10/5=2)*5=10)+1 = 11
			
			
			// (34-4) 현재 페이지에서 보여줄 마지막 페이지 번호 (~10, ~20, ~30, ...)
			int mainEndPage = mainStartPage + mainPageBlock - 1; 
			// ex) 3인 경우 = startPage(1) + pageBlock(3) - 1 = 3	// 사용자에게 '< 1 2 3 >' 이렇게 보여짐  
			// ex) 5인 경우 = startPage(1) + pageBlock(5) - 1 = 5	// 사용자에게 '< 1 2 3 4 5 >' 이렇게 보여짐 
			// ex) 11인 경우 = startPage(11) + pageBlock(5) - 1 = 15	// 사용자에게 '< 11 12 13 14 15 >' 이렇게 보여짐 
			
			// (34-5) 마지막에 보여줄 페이지 번호는, 전체 페이지 수에 따라 달라질 수 있다. 
			// 		  전체 페이지 수 (pageCount)가 위에서 계산한 endPage(3단위씩)보다 작으면 
			// 		  전체 페이지 수가 endPage가 된다. 
			if (mainEndPage > mainPageCount) {
			// ex)  3(endPage) > 4(pageCount) --> false
			// 	    5(endPage) > 4(pageCount) --> true > if 문 실행 
				mainEndPage = mainPageCount;
			//	4(pageCount)를 endPage에 담겠다. => endPage는 4가 됨.
			} // close of the 'if' (34-5)
			
			// (34-6) 검색시, 페이지 번호 처리해주기 
			if (mainHosSearch != null) {
				
				// (34-7) 왼쪽 '<' 꺽쇄 만들기 : startPage 가 pageBlock(5)보다 크면 '왼쪽' 꺽쇄 만들어주기.  
				//		이유 : 사용자 및 개발자에게 편의를 위함과 페이지의 깔끔함을 위해.
				if (mainStartPage > mainPageBlock) {
				// ex) 	  1	> 5 이면 맞지 않아 false 즉, 지금 페이지가 1 2 3 4 5 (pageBlock) 중 1~5페이지면 해당 사항 없음.
				// ex)  6(이상) > 5 이면 true여서 아래 조건문 실행. --> '<' 보여주며 클릭시 해당 페이지로 이동하기 
	%>
				<%-- 
					(34-8) jsp 문법으로 왼쪽 꺽쇄 '<' 보여주기. '&lt;'(< 왼쪽 꺽쇄) '&nbsp'(1칸 띄어쓰기) 및 'startPage-pageBlock' 추가 해주기 
							즉, 클릭시 '< ' 형태로 웹에 보여고, startPage-pageBlock 하여 해당 값의 맞는 page로 넘어가기.  
							ex) 		startPage(31)-pageBlock(3)
				--%>
					<a href="searchMain.jsp?pageNum=<%=mainStartPage-mainPageBlock%>&mainHosSearch=<%=mainHosSearch%>"> &lt; &nbsp; </a>
		<%
				} // close of the 'if' (34-7)
				
				// (34-9) 페이지 번호 웹 화면에 띄우기 
				//	ex)		i = 6; i <= 11; ==> '6 7 8 9 10 11'
				for (int i = mainStartPage; i <= mainEndPage; i++) {
		%>
				<%-- 
					(34-10) 페이지 번호를 클릭하면 맨위로 올라가 다시 실행하여 해당 페이지 요청하게 된다.(해당 페이지 재활용) 
					 ------------------------------- &nbsp; ==> '띄어쓰기 한 칸' 
					 <<a> 태그를 누르면 <i> 번쨔 리스트 페이지로 이동>, &nbsp;(한칸 띄우기) <%=i%>(int 웹에 숫자 보여지기) &nbsp;(한칸 띄우기) 
					및 pageNum 대입하여 해당 pageNum 값 입력해주기.
				--%>
					<a href="searchMain.jsp?pageNum=<%=i%>&mainHosSearch=<%=mainHosSearch%>"> &nbsp; <%=i%> &nbsp; </a>
		<%
				System.out.println("[searchMain](34-10) mainPageNum(i) : " + i);
				System.out.println("[searchMain](34-10) mainHosSearch : " + mainHosSearch);
				System.out.println("");
				} // close of the 'for' (34-9)
				
				// (34-11) 오른쪽 '>' 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면 
				//		이유 : 사용자 및 개발자에게 편의를 위함과 페이지의 깔끔함을 위해.
				if (mainEndPage < mainPageCount) {
				// ex) 6(이상) <	5 이면 if 문 실행 X 즉, DB에서 조건문에 해당하는 list들이 가져올것이 많으면 해당 조건은 26개 이상이면 아래 조건문 실행.
				//		즉, 위 (34-5) endPage 덮어 씌운게 (19-2)기존 pageCount 보다 작으면,
				//		즉, endPage(4) 보다 게시글이 더 많으면 '< '오른쪽 꺽쇄 보여지기. 
		%>
				<%-- 
					(34-12) 위 조건식이 맞아 사용자가 <a>태그를 클릭하면 '>' searchResult.jsp 페이지로 이동  
						&nbsp;(띄어쓰기) ' >(a태그 속성)' 웹상에 보여짐. '?pageNum=<%=startPage+pageBlock %>" 추가해주기'  
				--%>
					&nbsp; <a href="searchMain.jsp?pageNum=<%=mainStartPage+mainPageBlock%>&mainHosSearch=<%=mainHosSearch%>"> &gt; </a>
				<%-- 
						ex) startPage(6)+pageBlock(6)=(11) ==> '>'클릭시 (11) 페이지로 이동.
					해석 : ex) endPage(끝 페이지(10) < pageCount(총 페이지 수(21)) 조건문이 맞다면 <%=startPage(1)+pageBlock(11) ==> 즉 11페이지가 startPage에 담겨서 
					  		'>' pageNum으로 담겨 넘어가 사용자에게 11 12 13 ... 20 > 이런식으로 보여주며, 그에 맞는 병원리스트도 같이 보여줌. 
				--%>	
	<% 		
				} // close of the 'if' (34-11) 
			
			// (35) 검색 안됬을때
			} else { // close of the 'if' (34-6)
				// (35-1) 왼쪽 꺽쇄 '<'' : startPage 가 pageBlock(5)보다 크면 
		        if (mainStartPage > mainPageBlock) { 
	%>
					<a href="searchMain.jsp?pageNum=<%=mainStartPage-mainPageBlock%>"> &lt; &nbsp;</a>
		<%  
				} // close of the 'if' (35-1)
		         
		        // (35-2) 페이지 번호 뿌리기 ex) < 1 2 3 4 5 >
		        for (int i = mainStartPage; i <= mainEndPage; i++) { 
		%>
		            <a href="searchMain.jsp?pageNum=<%=i%>"> &nbsp; <%=i%> &nbsp; </a>
		<%   
		      	} // close of the 'for' (35-2)
		         
		        // (35-3) 오른쪽 꺽쇄 '>' : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
		        if (mainEndPage < mainPageCount) { 
		%>
		            &nbsp; <a href="searchMain.jsp?pageNum=<%=mainStartPage+mainPageBlock%>"> &gt; </a>
			<%-- (36) searchResult -> jquery로 '구' select box 선택시 선택된 값 변경되게 화면에 뿌려주기 위한 작업하기. --%>		
		<%   	
				} // close of the 'if' (35-3)
			} // close of the 'else' (35)
		} // close of the 'if' (32)
	%>
		</div>
		
	</body>
</html>