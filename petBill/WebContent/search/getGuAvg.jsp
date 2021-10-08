<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="pet.hos.model.AvgPriceDTO"%>
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="java.text.DecimalFormat"%>

<%	
	// (37) searchResult.jsp 에서 넘어온 select (jQuery, ajax 기능 만들어주기.)
	// ajax 로 요청하는 페이지 
	// 구를 받아서 디비에 구를 주고 해당구의 평균값 리턴받아와 
	// 화면에 출력하면 된다. 
	String guValue = request.getParameter("guValue");
	System.out.println("[getGuAvg](37) : " + guValue);
	HosDAO dao = HosDAO.getInstance();
	AvgPriceDTO dto = dao.getAvgPriceInfo(guValue); 
	DecimalFormat df = new DecimalFormat("###,###");
	
	// (38) Main.jsp 페이지 세션 추가해주기.
%>

<%=df.format(dto.getAvgBasicVaccin())%> <%=df.format(dto.getAvgNeuteringMan())%> <%=df.format(dto.getAvgNeuteringWoman())%> <%=df.format(dto.getAvgHeartWorm())%>

<%
	System.out.println("기초접종 : " + dto.getAvgBasicVaccin());
	System.out.println("중성화(남) : " + dto.getAvgNeuteringMan());
	System.out.println("중성화(여) : " + dto.getAvgNeuteringWoman());
	System.out.println("심장사상충 : " + dto.getAvgHeartWorm());
	System.out.println("");
	
	System.out.println("기초접종 : " + df.format(dto.getAvgBasicVaccin()));
	System.out.println("중성화(남) : " + df.format(dto.getAvgNeuteringMan()));
	System.out.println("중성화(여) : " + df.format(dto.getAvgNeuteringWoman()));
	System.out.println("심장사상충 : " + df.format(dto.getAvgHeartWorm()));

%>

