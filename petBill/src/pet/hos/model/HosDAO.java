package pet.hos.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pet.hos.model.AvgPriceDTO;
import pet.hos.model.HosDTO;
import pet.hos.model.HosDAO; 


public class HosDAO { 
	
	// 싱글턴. 객체맨날생성안하도록 .
	private static HosDAO instance = new HosDAO();
	private HosDAO() {}		
	public static HosDAO getInstance() {return instance;}

//커넥션 메서드  
private Connection getConnection() throws Exception{
	Context ctx = new InitialContext();
	Context env = (Context)ctx.lookup("java:comp/env");
	DataSource ds = (DataSource)env.lookup("jdbc/orcl");
	Connection conn = ds.getConnection();
	return conn;
}//getConnection

//#0. 병원회원가입 : 우선 전화번호로 공공데이터 유무 찾기 + (가입내역 있는지 확인용도)
// 입력받은 전화번호 있으면 dto에 넣어주기. 없으면 dto == null 상태로 return.
public HosDTO getHospital(String hosTel) {
	
	HosDTO dto = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		conn = getConnection();
		String sql = "select * from hospital where hosTel=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, hosTel);
		
		rs = pstmt.executeQuery();
		if(rs.next()) {
			dto = new HosDTO();
			//고유번호도 세팅해줘야함!!**
			dto.setHosNo(rs.getInt("hosNo"));
			dto.setHosId(rs.getString("hosId"));
			dto.setHosPw(rs.getString("hosPw"));
			dto.setHosUserName(rs.getString("hosUserName"));
			dto.setHosProfile(rs.getString("hosProfile"));
			dto.setHosMobile(rs.getString("hosMobile"));
			dto.setHosName(rs.getString("hosName"));
			dto.setHosTel(rs.getString("hosTel"));
			dto.setHosTime(rs.getString("hosTime"));
			dto.setHosSiAddress(rs.getString("hosSiAddress"));
			dto.setHosGuAddress(rs.getString("hosGuAddress"));
			dto.setHosNewAddress(rs.getString("hosNewAddress"));
			dto.setHosOldAddress(rs.getString("hosOldAddress"));
			dto.setHosNum(rs.getString("hosNum"));
			dto.setHosNumPhoto(rs.getString("hosNumPhoto"));
			dto.setHosBio(rs.getString("hosBio"));
			dto.setHosReason(rs.getString("hosReason"));
			dto.setHosActiveNum(rs.getInt("hosActiveNum"));
			dto.setHosReg(rs.getTimestamp("hosReg"));
			
		}
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	}
	return dto;
}//getHospital

//#1. 신규 병원회원가입 : 공공데이터 없을때 - 모든정보 받아서 신규 병원회원가입
public void insertHosMember(HosDTO dto) {
	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		conn = getConnection();

			//공공데이터 없으면 고유번호 생성후 새로가입시킴 
			String sql = "insert into hospital(hosNo, hosId, hosPw, hosUserName, hosProfile, hosMobile, hosName, hosTel, hosTime, "
					+ "hosSiAddress, hosGuAddress, hosNewAddress, hosOldAddress, hosNum, hosNumPhoto, hosBio, hosActiveNum, hosReg) "
					+ "values(hospital_seq.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,2,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getHosId());
			pstmt.setString(2, dto.getHosPw());
			pstmt.setString(3, dto.getHosUserName());
			pstmt.setString(4, dto.getHosProfile());
			pstmt.setString(5, dto.getHosMobile());
			pstmt.setString(6, dto.getHosName());
			pstmt.setString(7, dto.getHosTel());
			pstmt.setString(8, dto.getHosTime());
			pstmt.setString(9, dto.getHosSiAddress());
			pstmt.setString(10, dto.getHosGuAddress());
			pstmt.setString(11, dto.getHosNewAddress());
			pstmt.setString(12, dto.getHosOldAddress());
			pstmt.setString(13, dto.getHosNum());
			pstmt.setString(14, dto.getHosNumPhoto());
			pstmt.setString(15, dto.getHosBio());

			pstmt.executeUpdate();
		
	}catch(Exception e) {
		e.printStackTrace();
	}finally {

		if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	}
	System.out.println("신규 병원회원가입 성공!");

}//insertHosMember

//#2. 공공 병원회원가입 : 공공데이터 존재하는경우 - 기존 정보에 추가정보 업데이트 
public int updateExistHosMember(HosDTO dto) {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int result = 0;
	
	try {
		conn = getConnection();
			String sql = "update hospital set "
					+ "hosId=?, hosPw=?, hosUserName=?, hosProfile=?, hosMobile=?, "
					+ "hosNum=?, hosNumPhoto=?, "
					+ "hosBio=?, hosReg=sysdate, hosActiveNum='2', hosTime=?"
					+ "where hosNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getHosId());
			pstmt.setString(2, dto.getHosPw());
			pstmt.setString(3, dto.getHosUserName());
			pstmt.setString(4, dto.getHosProfile());
			pstmt.setString(5, dto.getHosMobile());
			pstmt.setString(6, dto.getHosNum());
			pstmt.setString(7, dto.getHosNumPhoto());
			pstmt.setString(8, dto.getHosBio());
			pstmt.setString(9, dto.getHosTime());
			pstmt.setInt(10, dto.getHosNo());
				
			result = pstmt.executeUpdate();
		
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	}
	return result;
	
}//updateExistHosMember

//#3. 병원회원가입 공통 : 아이디 중복체크
public boolean confirmHosId(String hosId){
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean result = false;
	
	try {
		conn = getConnection();
		String sql = "select * from hospital where hosId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, hosId);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		
	}catch(Exception e) {
		
	}finally {
		if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	}
	return result;
}//confirmHosId

//#4. 신규 병원회원가입 : 전화번호 중복체크
public boolean confirmHosTel(String hosTel){
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean result = false;
	
	try {
		conn = getConnection();
		String sql = "select * from hospital where hosTel=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, hosTel);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		
	}catch(Exception e) {
		
	}finally {
		if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	}
	return result;
}//confirmHosId

//#1. 병원마이페이지 - 기존정보 read only용 데이터 가지고오기.
public HosDTO getHosMember(String hosId) {
	
	HosDTO dto = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		conn = getConnection();
		String sql = "select * from hospital where hosId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, hosId);
		
		rs = pstmt.executeQuery();
		if(rs.next()) {
			dto = new HosDTO();
			//고유번호도 세팅해줘야함!!**
			dto.setHosNo(rs.getInt("hosNo"));
			dto.setHosId(rs.getString("hosId"));
			dto.setHosPw(rs.getString("hosPw"));
			dto.setHosUserName(rs.getString("hosUserName"));
			dto.setHosProfile(rs.getString("hosProfile"));
			dto.setHosMobile(rs.getString("hosMobile"));
			dto.setHosName(rs.getString("hosName"));
			dto.setHosTel(rs.getString("hosTel"));
			dto.setHosTime(rs.getString("hosTime"));
			dto.setHosSiAddress(rs.getString("hosSiAddress"));
			dto.setHosGuAddress(rs.getString("hosGuAddress"));
			dto.setHosNewAddress(rs.getString("hosNewAddress"));
			dto.setHosOldAddress(rs.getString("hosOldAddress"));
			dto.setHosNum(rs.getString("hosNum"));
			dto.setHosNumPhoto(rs.getString("hosNumPhoto"));
			dto.setHosBio(rs.getString("hosBio"));
			dto.setHosReason(rs.getString("hosReason"));
			dto.setHosActiveNum(rs.getInt("hosActiveNum"));
			dto.setHosReg(rs.getTimestamp("hosReg"));
		}
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	}
	return dto;
}//getHosMember


// 병원회원정보 수정 hosActiveNum='1'(회원상태)만 수정가능
	public int hosMemberUpdate(HosDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "update hospital set "
						+ "hosUserName=?, hosProfile=?, hosMobile=?, "
						+ "hosName=?, hosTel=?, hosTime=?, "
						+ "hosSiAddress=?, hosGuAddress=?, hosNewAddress=?, hosOldAddress=?, "
						+ "hosNum=?, hosNumPhoto=?, hosBio=?, "
						+ "hosReg=sysdate, hosActiveNum='1' "
						+ "where hosId=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getHosUserName());
			pstmt.setString(2, dto.getHosProfile());
			pstmt.setString(3, dto.getHosMobile());
			pstmt.setString(4, dto.getHosName());
			pstmt.setString(5, dto.getHosTel());
			pstmt.setString(6, dto.getHosTime());
			pstmt.setString(7, dto.getHosSiAddress());
			pstmt.setString(8, dto.getHosGuAddress());
			pstmt.setString(9, dto.getHosNewAddress());
			pstmt.setString(10, dto.getHosOldAddress());
			pstmt.setString(11, dto.getHosNum());
			pstmt.setString(12, dto.getHosNumPhoto());
			pstmt.setString(13, dto.getHosBio());
			pstmt.setString(14, dto.getHosId());
					
			result = pstmt.executeUpdate();
			
			System.out.println("dao 업데이트결과 : "+ result);
				
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}//hosMemberUpdate

	//병원 회원탈퇴시 수정처리
	public int deleteHosMember(int hosNo, String hosPw){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();
			//해당 회원의 고유번호로 패스워드 찾기 
			String sql = "select hosPw from hospital where hosNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hosNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//패스워드 일치시 none으로 업데이트 (초기화시키기) -> hosActiveNum='0'(탈퇴상태)로 변경
				String dbPw = rs.getString("hosPw");
				if(dbPw.equals(hosPw)) {
					sql = "update hospital set "
							+ "hosId=?, hosPw=?, hosUserName=?, hosProfile=?, hosMobile=?, "
							+ "hosNum=?, hosNumPhoto=?, "
							+ "hosBio=?, hosReg=sysdate, hosActiveNum='0', hosTime=?"
							+ "where hosNo=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "none");
					pstmt.setString(2, "none");
					pstmt.setString(3, "none");
					pstmt.setString(4, "none");
					pstmt.setString(5, "none");
					pstmt.setString(6, "none");
					pstmt.setString(7, "none");
					pstmt.setString(8, "none");
					pstmt.setString(9, "none");
					pstmt.setInt(10, hosNo);
						
					result = pstmt.executeUpdate();
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
		
	}//deleteHosMember
	
	
	
	//#1. 병원목록 - hospital 테이블의 병원 전체개수 가져오기 
	public int getHosArticleCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from hospital"; // 전체개수 가져오기 
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1); // count(*)는 결과를 숫자로 가져오며, 컬럼명대신 컬럼번호로 꺼내기 	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return count;
	}//getHosArticleCount

	//#2. 병원목록 범위만큼 가져옴 
	public List getHosArticles(int startRow, int endRow) { //매개변수 이름 달라도 상관X, 순서가 중요 (startRow, endRow)
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
	
		try {
			conn = getConnection(); 
			// 서브쿼리문 : 3번 긁어와야된다는데.. 정렬때문인듯함. 우선 테스트용이므로 생략.
			String sql = "select hosNo, hosName, hosSiAddress, hosGuAddress, hosNewAddress from hospital where rownum >= ? and rownum <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과를 null인지 먼저 체크해보고 
				articleList = new ArrayList(); // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
				do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
					HosDTO article = new HosDTO();
					article.setHosNo(rs.getInt("hosNo"));
					article.setHosName(rs.getString("hosName"));
					article.setHosSiAddress(rs.getString("hosSiAddress"));
					article.setHosGuAddress(rs.getString("hosGuAddress"));
					article.setHosNewAddress(rs.getString("hosNewAddress"));
					articleList.add(article); // 처음거는 무조건 실행해서 리스트에 추가하고 
				}while(rs.next()); // 반복해라 
				
			}//if 중괄호 끝 
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return articleList;
		
	}
	
	//#3. 병원고유번호 받아서 해당 병원정보 불러오기
	//#3. 병원고유번호 받아서 해당 병원정보 불러오기
			public HosDTO getHosArticle(int hosNo) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				HosDTO article = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql = "select hosName, hosProfile, hosBio, hosSiAddress, hosGuAddress, hosNewAddress, hosTel, hosTime, "
							+ "hosBasicVaccin, hosNeuteringMan, hosNeuteringWoman, hosHeartWorm from hospital where hosNo=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, hosNo);
					rs = pstmt.executeQuery();
					 
					if(rs.next()) {
						article = new HosDTO();
						article.setHosName(rs.getString("hosName"));
						article.setHosProfile(rs.getString("hosProfile"));
						article.setHosBio(rs.getString("hosBio"));
						article.setHosSiAddress(rs.getString("hosSiAddress"));
						article.setHosGuAddress(rs.getString("hosGuAddress"));
						article.setHosNewAddress(rs.getString("hosNewAddress"));
						article.setHosTel(rs.getString("hosTel"));
						article.setHosTime(rs.getString("hosTime"));
						article.setHosBasicVaccin(rs.getString("hosBasicVaccin"));
						article.setHosNeuteringMan(rs.getString("hosNeuteringMan"));
						article.setHosNeuteringWoman(rs.getString("hosNeuteringWoman"));
						article.setHosHeartWorm(rs.getString("hosHeartWorm"));
						article.setHosNo(hosNo);
						 
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				System.out.println("dto에 데이터 들어감");
				return article;
			}
			
		//후기 리스트 띄우기
			public void reviewList(int hosNo) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				
				try {
					conn = getConnection();
					String sql = "select * from review where reviewHosNo?";
					
					
					
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				
			}
			// 병원 회원 가입시 화면에 뿌려줄 메서드 
			public int getHosJoinWaitingCount() {
				int waitingCount = 0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql = "select count(*) from hospital where hosActiveNum = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, 2);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						waitingCount = rs.getInt(1);
						System.out.println("병원가입 수 : " + waitingCount);
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
					if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
					if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
				}
				return waitingCount;
			
			}
			
			
			// 병원 회원가입 대기중인 리스트 모두 뿌려주기 
			public List getHosJoinWaitingList(int start, int end) {
				List hosJoinNumberList = null;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql = "select B.*, r "
									+ "from (select A.*, rownum r "
										+ "from (select * from hospital where hosActiveNum = ?) A "
									+ "order by hosreg) B "
								+ "where r >= ? and r <= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, 2);
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						hosJoinNumberList = new ArrayList();
						do {
							HosDTO dto = new HosDTO();
							dto.setHosNo(rs.getInt("hosNo"));
							dto.setHosId(rs.getString("hosId"));
							dto.setHosPw(rs.getString("hosPw"));
							dto.setHosUserName(rs.getString("hosUserName"));
							dto.setHosProfile(rs.getString("hosProfile"));
							dto.setHosMobile(rs.getString("hosMobile"));
							dto.setHosName(rs.getString("hosName"));
							dto.setHosTel(rs.getString("hosTel"));
							dto.setHosSiAddress(rs.getString("hosSiAddress"));
							dto.setHosGuAddress(rs.getString("hosGuAddress"));
							dto.setHosNewAddress(rs.getString("hosNewAddress"));
							dto.setHosOldAddress(rs.getString("hosOldAddress"));
							dto.setHosNum(rs.getString("hosNum"));
							dto.setHosNumPhoto(rs.getString("hosNumPhoto"));
							dto.setHosBio(rs.getString("hosBio"));
							dto.setHosReg(rs.getTimestamp("hosReg"));
							dto.setHosActiveNum(rs.getInt("hosActiveNum"));
							dto.setHosReason(rs.getString("hosReason"));
							dto.setHosTime(rs.getString("hosTime"));
							
							hosJoinNumberList.add(dto);
							
						} while (rs.next());
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
					if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
					if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
				}
				return hosJoinNumberList;
			}
	
//----------------------------------------------------------------------------------------
		
		// (9) 전체 병원의 갯수(count(*)) 가져올 getHosListCount 메서드 만들기.
		//	 이유 : 검색이 안되었을때 모든 병원list 보여주기 위함.
		//		(24) searchMain 위 내용과 같음.
		public int getHosTotalListCount() {
			// (9-1) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();	
			// (9-2) 지역변수 사용하기 위해 미리 변수 만들어 주기. 
			int hosCount = 0;							// 병원 전체list를 (count(*))로 담을 int 변수 
			
			// (9-4) // try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (9-5) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (9-6) DB에 'hospital' table 에서 count(*) 정보 가져오기
				// 		count(*) : 병원list의 총 개수  
				//		이유 : 병원list 총 개수(count(*)) 가 '0' 보다 크면 병원 리스트 뿌려주기 위한 sql문 
				String sql = "select count(*) from hospital";
				// (9-7) 'sql'(병원list 총 개수(count(*)))의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (9-8) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 		executeUpdate 의 경우 DBeaver에 데이터를 입력(update) 할때 사용 
				// 		ResultSet rs 로 쿼리문 실행 하기. 
				rs = pstmt.executeQuery();			// 'hospital' table에서 'count(*)' 값을 '가져온' 것이기 때문에 executeQuery()를 사용해야 한다.
				
				// (9-9) hospital table에 hosNo hosName... 등 의 columns의 다음 줄(next()) - 커서가 밑으로 한줄 내려간다 
				if (rs.next()) {			// rs에(hospital table)에 다음 값(즉, 게시글)이 있다면 'if'문 실행 
											
					// count(*)은 결과를 숫자로 가져오며, 
					// 컬럼명 대신 컬럼번호로 꺼내서 count 변수에 담기
					// 즉, hospital 테이블의 총 컬럼의 갯수를 나타내는 1번 컬럼(35(병list의 총 개수)) 불러와 count에 담기  
					// DB hospital table 에 "select count(*) from board"; 입력하면 ,
//					   |__|COUNT(*)|______________________________|
	// (rs.next()) ㄴ>  |1 |___813___|_____________________________|
					
					// '1'번 컬럼의 정보인(813)를 가지고 와서(rs.getInt(1)) 'count' 담겠다. 
					hosCount = rs.getInt(1);
				}
				System.out.println("[DAO](9-9) 전체 병원 갯수(count(*)) hosCount : " + hosCount);
				System.out.println("");
			} catch (Exception e) {
				// (9-4) 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace(); 	
				
			// (9-4) try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 	
			} finally {
				// (9-4) DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			
			// (9-3) count 변수명에 담길 값 return 해주기.
			// 		즉, 위 (9-9)의 조건문의 count=813 값을 가지고 리턴해줌. 
			return hosCount;
			// (9-10) searchResult.jsp -> getHosListCount()메서드 int type으로 담아주기.
			//		(24-1) searchMain.jsp -> 위 내용과 같음.
		}
		
		
		// (10-2) DB에 병원list 수 만큼 병원의 모든 정보 범위 저장하여 가져오기 위한 hospitalList(int start, int end) 메서드 만들기. -------------------------------------------------
		//		(25) (27) 위 내용과 같음.
		public List getTotalHospitals(int start, int end) { 
			// (10-3) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();	
			// (10-4) do-while문 에서 변수 사용하기 위한 변수 미리 선언 
			//		이유 : if(rs.next()) 하게 되면 컬럼에서 밑으로 한줄 내려가게 되므로 바로 do문에 실행할 코드들 입력하기 위해.
			List totalHospitalList = null;	
			
			// (10-5) try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (10-6) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (10-7) DB 'hospital'의 병원list 전체 정보를 r의 기준만큼 가져오기.
				//		 'r'을 설정한 이유는 병원list의 첫 정보와 끝정보 보두 가져오려고.
//				String sql = "select *, r from prachospital where r >= ? and r <= ?";
				String sql = "select B.*, r "
								+ "from (select A.*, rownum r "
									+ "from (select * from hospital order by hosguaddress) A "
								+ "order by hosname) B "
							+ "where r >= ? and r <= ?";
				
//				String sql = "select B.*, r from (select A.*, rownum r from (select * from prachospital order by hosguaddress) A order by hosname) B where r >= ? and r <= ?";
				
				
				// (10-8) 'sql'(조건해당된 쿼리문)의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (10-8) (10-7) 의 sql 조건문 중 '?'에 조건 설정해주기.
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				// (10-9) 위 쿼리문(10-8)에서 ?에 값 대입하기. 
				// 		  		   where r >= ? and r <= ?; 쿼리문 
				//  해석 : where r >= (1, start) and r <= (2, end);
				// (10-10) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 			executeUpdate 의 경우 DB에 데이터를 입력(update) 할때 사용 
				// ResultSet rs 로 쿼리문 실행 하기. 
				// pstmt[] = setInt[(1, start), (2, end)];
				rs = pstmt.executeQuery();			// 즉, 위 설정한 값으로 데이터 가져와 rs에 담아주어 실행하는 것이기 때문에 executeQuery(); 를 사용해야 함.
				
				// (10-11) hospital table에 hosNo, hosName...등 의 columns의 다음 줄(next()) - 커서가 밑으로 한줄 내려간다 
				if (rs.next()) {		// rs에(hospital table)에 다음 값(즉, 병원list)이 있다면 'if'문 실행 
										// 커서가 한번 내려감. 
//				   |	|__|hosNo|hosId|hosPw|hos...|hos...|hos...|hos...|hos...|hosActiveNum|hosReason|hosTime|
	// (rs.next()) ㄴ> 	|1_|__a1_|_a2__|__a3_|__a4__|__a5__|__a6__|__a7__|__a8__|_____a9_____|___a10___|__a11__|
//						|2_|__b1_|_b2__|__b3_|__b4__|__b5__|__b6__|__b7__|__b8__|_____b9_____|___b10___|__b11__|
//						|3_|__c1_|_c2__|__c3_|__c4__|__c5__|__c6__|__c7__|__c8__|_____c9_____|___c10___|__c11__|
//						|4_|__d1_|_d2__|__d3_|__d4__|__d5__|__d6__|__d7__|__d8__|_____d9_____|___d10___|__d11__|			  				 	
//						|5_|__e1_|_e2__|__e3_|__e4__|__e5__|__e6__|__e7__|__e8__|_____e9_____|___e10___|__e11__|
					
					// (10-12) do-while문 안에 변수 사용으로 인한 밖에서 객체생성 
					//        ArrayList(); 즉, 배열로 객체생성 이유는,
					//		  DB에 저장된 'hospital'테이블의,
					//		  hosNo, hosId, hosPw, 등의 컬럼 값들을 
					//		  한번에 배열로 가져오기 위하여 ArrayList(); 배열로 객체생성 
					totalHospitalList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
				
					// (10-13) do { 무조건 1번은 실행해야 되는 것.
					//		이유 : if(rs.next()) 하게 되면 컬럼에서 밑으로 한줄 내려가게 되므로 바로 do문에 실행할 코드들 입력하기 위해.
					do {	// if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
						// (10-14) HosDTO에 get/set 메서드 사용하여 값들을 return hospitalList 담아주기 위해. 
						HosDTO dto = new HosDTO();
						// (10-15) 각 저장된 값들을 꺼내와(get) 저장하기(set) 
						dto.setHosNo(rs.getInt("hosNo"));
						
						dto.setHosId(rs.getString("hosId"));
						dto.setHosPw(rs.getString("hosPw"));
						dto.setHosUserName(rs.getString("hosUserName"));
						dto.setHosProfile(rs.getString("hosProfile"));
						dto.setHosMobile(rs.getString("hosMobile"));
						dto.setHosName(rs.getString("hosName"));
						dto.setHosTel(rs.getString("hosTel"));
						dto.setHosSiAddress(rs.getString("hosSiAddress"));
						dto.setHosGuAddress(rs.getString("hosGuAddress"));
						dto.setHosNewAddress(rs.getString("hosNewAddress"));
						dto.setHosOldAddress(rs.getString("hosOldAddress"));
						dto.setHosNum(rs.getString("hosNum"));
						dto.setHosNumPhoto(rs.getString("hosNumPhoto"));
						dto.setHosBio(rs.getString("hosBio"));
						
						dto.setHosReg(rs.getTimestamp("hosReg"));
						
						dto.setHosActiveNum(rs.getInt("hosActiveNum"));
					
						dto.setHosReason(rs.getString("hosReason"));
						dto.setHosTime(rs.getString("hosTime"));
						
						// (10-16) 위 get/set 의 값들 return 해주기 위한 'hospitalList'에 더하기(add).
						totalHospitalList.add(dto);
						
						
					// (10-17) 위 get/set하여 값 저장한거 다시 한줄 내려 값 있으면 반복해주기 -> while (rs.next()) -> do
					} while (rs.next());
//				   |   |__|hosNo|hosId|hosPw|hos...|hos...|hos...|hos...|hos...|hosActiveNum|hosReason|hosTime|
	// (rs.next()) ㄴ> |1_|__a1_|_a2__|__a3_|__a4__|__a5__|__a6__|__a7__|__a8__|_____a9_____|___a10___|__a11__|
//					   |2_|__b1_|_b2__|__b3_|__b4__|__b5__|__b6__|__b7__|__b8__|_____b9_____|___b10___|__b11__|
//		   			   |3_|__c1_|_c2__|__c3_|__c4__|__c5__|__c6__|__c7__|__c8__|_____c9_____|___c10___|__c11__|
//					   |4_|__d1_|_d2__|__d3_|__d4__|__d5__|__d6__|__d7__|__d8__|_____d9_____|___d10___|__d11__|			  				 	
//					   |5_|__e1_|_e2__|__e3_|__e4__|__e5__|__e6__|__e7__|__e8__|_____e9_____|___e10___|__e11__|				
				}
				System.out.println("[HosDAO](10-16) (검색X) ArrayList에 담긴 totalHospitalList : " + totalHospitalList);
				System.out.println("");
			} catch (Exception e) {
				// (10-5) 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace();
				
			// (10-5) try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 
			} finally {
				// (10-5) DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			// (10-18) 위 do-while 조건에 맞는 값을 가지고 return hospitalList 해줌. 
			// (10-19) searchHospitalList 변수에 담아주러 searchResult.jsp 로 돌아감.
			return totalHospitalList;
			// (25-2) 위 내용과 같음. resultMain 으로 돌아가기.
		}
			
		
		// (11) 검색된 병원의 갯수(count(*)) 가져올 getSearchHosListCount(String hosSearch) 메서드 만들기 ------------------------------------------------------------------------------------------
		public int getSearchHosListCount(String hosSearch) {
			// (11-1) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();
			// (11-2) return 값 int로 받을것이기 때문에 미리 변수 생성해주기
			int hosCount = 0;
			
			// (11-3) try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (11-4) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (11-9) 병원 키워드 검색 가능하게 sql문 작성해 주어 DB에 저장되어있는 병원 이름 및 검색어 포함하여 sql문에 저장해주기. 
				String sql = "select count(*) from hospital where hosname like '%" + hosSearch + "%' or hosguaddress like '%" + hosSearch + "%'";
				// (11-10) 'sql'(조건해당된 쿼리문)의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (11-11) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 			executeUpdate 의 경우 DB에 데이터를 입력(update) 할때 사용 
				// ResultSet rs 로 쿼리문 실행 하기. 
				rs = pstmt.executeQuery();			// 즉, 위 설정한 값으로 데이터 가져와 rs에 담아주어 실행하는 것이기 때문에 executeQuery(); 를 사용해야 함.
				
				// (11-12) 조건문으로 1번 rows 열에 조건에 맞는 정보 꺼내어 hosCount에 담기.
//				   	   |__|COUNT(*)|
	//(rs.next()) ㄴ>   |1_|___813__|
				if (rs.next()) {
					hosCount = rs.getInt(1);
				}
				System.out.println("[HosDAO](11-12) 검색된(O) hosCoun : " + hosCount);
				System.out.println("");
			
			} catch (Exception e) {
				// (11-5) 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace();
				
			// (11-6) try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 
			} finally {
				// (11-7) DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			
			// (11-8) 리턴 보내기.
			return hosCount;
			// (11-9) searchResult hosSearchCount = dao.getSearchHosListCount(hosName, hosSearch)로 설정해주기. 
		}
		
		
		// (12) 사용자가 검색창에 검색한 정보의 DB 병원이 있다면 모두 화면에 뿌려주기 위한 메서드 만들기 --------------------------------------------------------------------------------------------------
		public List getSearchHospitals(int start, int end, String hosSearch) {
			// (12-1) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();
			// (12-2) List 배열로 변수 생성하여 정보의 값들을 배열로 담기위해 변수 생성하기 
			List searchHospitalList = null;
			
			// (12-3) try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (12-4) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (12-9) 사용자가 입력한 String 값을 가지고 '%검색어%' 에 포함된 모든 정보(중복안됨) 가져오기.
				String sql = "select B.*, r "
								+ "from (select A.*, rownum r "
									+ "from (select * from hospital where hosguaddress like '%" + hosSearch + "%' "
									+ "or hosname like '%" + hosSearch + "%' order by hosname) A "
								+ "order by hosguaddress) B "
							+ "where r >= ? and r <= ?";
				
				System.out.println("[HosDAO](12-9) : sql : " + sql);
				System.out.println("");
				
				// (12-10) 'sql'(조건해당된 쿼리문)의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (12-11) (12-9) 의 sql 조건문 중 '?'에 조건 설정해주기.
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				// (12-12) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 			executeUpdate 의 경우 DB에 데이터를 입력(update) 할때 사용 
				// ResultSet rs 로 쿼리문 실행 하기. 
				// pstmt[] = setInt[(1, start), (2, end)];
				rs = pstmt.executeQuery();			// 즉, 위 설정한 값으로 데이터 가져와 rs에 담아주어 실행하는 것이기 때문에 executeQuery(); 를 사용해야 함.
				System.out.println("[HosDAO](12-12) rs.쿼리 : " + rs);
				System.out.println("");
				
				// (12-13) 조건문으로 위 (12-9)의 sql 조건문에 해당하는 DB정보 꺼내어 ArrayList() => hospitalList 로 담기.
				if (rs.next()) {
//					   |	|__|hosNo|hosName|hosNewAddress|hosTel|....
//		   			   | 	|1_|_a1__|__a2___|_____a3______|__a4__|
//		   (rs.next()) ㄴ>	|2_|_b1__|__b2___|_____b3______|__b4__|
//		   				. 	|3_|_c1__|__c2___|_____c3______|__c4__|
//		   				. 	|4_|_d1__|__d2___|_____d3______|__d4__|
//		   				. 	|5_|_e1__|__e2___|_____e3______|__e4__|
					
					// (12-14) hospitalList 변수에 sql 배열로 담을 객체생성 
					searchHospitalList = new ArrayList();
					
					// (12-15) 위 if 문에서 rs.next() 하였기 때문에 do-while로 설정하여 do문에 dto객체생성 후 hospital 에 담아주기.
					do {
						HosDTO hosArticle = new HosDTO();
						
						// (12-16) (12-9)에 설정한 DB sql문 의 정보 담아주기.
						hosArticle.setHosNo(rs.getInt("hosNo"));
						hosArticle.setHosId(rs.getString("hosId"));
						hosArticle.setHosPw(rs.getString("hosPw"));
						hosArticle.setHosName(rs.getString("hosUserName"));
						hosArticle.setHosProfile(rs.getString("hosProfile"));
						hosArticle.setHosMobile(rs.getString("hosMobile"));
						hosArticle.setHosName(rs.getString("hosName"));
						hosArticle.setHosTel(rs.getString("hosTel"));
						hosArticle.setHosSiAddress(rs.getString("hosSiAddress"));
						hosArticle.setHosGuAddress(rs.getString("hosGuAddress"));
						hosArticle.setHosNewAddress(rs.getString("hosNewAddress"));
						hosArticle.setHosOldAddress(rs.getString("hosOldAddress"));
						hosArticle.setHosNum(rs.getString("hosNum"));
						hosArticle.setHosNumPhoto(rs.getString("hosNumPhoto"));
						hosArticle.setHosBio(rs.getString("hosBio"));
						hosArticle.setHosReg(rs.getTimestamp("hosReg"));
						hosArticle.setHosActiveNum(rs.getInt("hosActiveNum"));
						hosArticle.setHosReason(rs.getString("hosReason"));
						hosArticle.setHosTime(rs.getString("hosTime"));
						
						// (12-17) 위 정보 add하여 hospitalList 리턴 값에 담아주기 
						searchHospitalList.add(hosArticle);
						
					//	do문 실행하고 커서 내려서 정보 있을때까지 반복 do(실행) -> while(조건문) 있으면 -> do, 없으면 do-while문 빠져나가기.
					} while (rs.next());
				}
				System.out.println("[HosDAO](12-17) (검색O) ArrayList 배열로 searchHospitalList : " + searchHospitalList);
				System.out.println("");
				
			} catch (Exception e) {
				// (12-5) 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace();
				
			// (12-6) try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 
			} finally {
				// (12-7) DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			
			// (12-8) sql문에서 가져온 정보를 배열로 담아 리턴해주기.
			return searchHospitalList;
			// (12-18) searchResult.jsp -> dao.getSearchHospital(startRow, endRow, hosName, hosSearch); 한거 searchHospitalList 변수에 담아주기.
		}
		
		//	(22) [searchMain] 에서 해당 메서드 확인 후 리턴해주기. ------------------------------------------------------------------[searchMain]----------
		public int getSearchMainHosListCount(String mainHosSearch) {
			// (22-1) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();
			// (22-2) return 값 int로 받을것이기 때문에 미리 변수 생성해주기
			int hosMainCount = 0;
			
			// (22-3) try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (22-4) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (22-9) 병원 키워드 검색 가능하게 sql문 작성해 주어 DB에 저장되어있는 병원 이름 및 검색어 포함하여 sql문에 저장해주기. 
				String sql = "select count(*) from hospital where hosname like '%" + mainHosSearch + "%' or hosguaddress like '%" + mainHosSearch + "%'";
				// (22-10) 'sql'(조건해당된 쿼리문)의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (22-11) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 			executeUpdate 의 경우 DB에 데이터를 입력(update) 할때 사용 
				// ResultSet rs 로 쿼리문 실행 하기. 
				rs = pstmt.executeQuery();			// 즉, 위 설정한 값으로 데이터 가져와 rs에 담아주어 실행하는 것이기 때문에 executeQuery(); 를 사용해야 함.
				
				// (22-12) 조건문으로 1번 rows 열에 조건에 맞는 정보 꺼내어 hosCount에 담기.
//				   	   |__|COUNT(*)|
	//(rs.next()) ㄴ>   |1_|___813__|
				if (rs.next()) {
					hosMainCount = rs.getInt(1);
				}
				System.out.println("[HosDAO](22-12) 검색된Main count(*) hosMainCount : " + hosMainCount);
				System.out.println("");
			
			} catch (Exception e) {
				// 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace();
				
			// try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 
			} finally {
				// DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return hosMainCount;
			// 	(22-13) 리턴해주고 해당 맞는 타입의 변수로 담아주기.
		}
		
		
		//	(24) searchMain > 해당 메서드 불러오는거 확인 하고 리턴해주기. --------------------------------------------------------------[searchMain]----------
		public List getSearchMainHospitals(int mainStart, int mainEnd, String mainHosSearch) { 
			// (24-1) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();
			// (24-2) List 배열로 변수 생성하여 정보의 값들을 배열로 담기위해 변수 생성하기 
			List searchMainHospitalList = null;
			
			// (24-3) try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (24-4) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (24-9) 사용자가 입력한 String 값을 가지고 '%검색어%' 에 포함된 모든 정보(중복안됨) 가져오기.
				String sql = "select B.*, r from "
								+ "(select A.*, rownum r from "
									+ "(select * from hospital where hosguaddress like '%" + mainHosSearch + "%' "
									+ "or hosname like '%" + mainHosSearch + "%' order by hosname) A "
								+ "order by hosguaddress) B "
							+ "where r >= ? and r <= ?";
				
				System.out.println("[HosDAO](24-9) sql : " + sql);
				System.out.println("");
				
				// (24-10) 'sql'(조건해당된 쿼리문)의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (24-11) (24-9) 의 sql 조건문 중 '?'에 조건 설정해주기.
				pstmt.setInt(1, mainStart);
				pstmt.setInt(2, mainEnd);
				
				// (24-12) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 			executeUpdate 의 경우 DB에 데이터를 입력(update) 할때 사용 
				// ResultSet rs 로 쿼리문 실행 하기. 
				// pstmt[] = setInt[(1, start), (2, end)];
				rs = pstmt.executeQuery();			// 즉, 위 설정한 값으로 데이터 가져와 rs에 담아주어 실행하는 것이기 때문에 executeQuery(); 를 사용해야 함.
				System.out.println("[HosDAO](24-12) rs.쿼리 : " + rs);
				System.out.println("");
				
				// (24-13) 조건문으로 위 (12-9)의 sql 조건문에 해당하는 DB정보 꺼내어 ArrayList() => hospitalList 로 담기.
				if (rs.next()) {
//						   |	|__|hosNo|hosName|hosNewAddress|hosTel|....
//			   			   | 	|1_|_a1__|__a2___|_____a3______|__a4__|
//			   (rs.next()) ㄴ>	|2_|_b1__|__b2___|_____b3______|__b4__|
//			   				. 	|3_|_c1__|__c2___|_____c3______|__c4__|
//			   				. 	|4_|_d1__|__d2___|_____d3______|__d4__|
//			   				. 	|5_|_e1__|__e2___|_____e3______|__e4__|
					
					// (24-14) hospitalList 변수에 sql 배열로 담을 객체생성 
					searchMainHospitalList = new ArrayList();
					
					// (24-15) 위 if 문에서 rs.next() 하였기 때문에 do-while로 설정하여 do문에 dto객체생성 후 hospital 에 담아주기.
					do {
						HosDTO hosArticle = new HosDTO();
						
						// (24-16) (24-9)에 설정한 DB sql문 의 정보 담아주기.
						hosArticle.setHosNo(rs.getInt("hosNo"));
						hosArticle.setHosId(rs.getString("hosId"));
						hosArticle.setHosPw(rs.getString("hosPw"));
						hosArticle.setHosName(rs.getString("hosUserName"));
						hosArticle.setHosProfile(rs.getString("hosProfile"));
						hosArticle.setHosMobile(rs.getString("hosMobile"));
						hosArticle.setHosName(rs.getString("hosName"));
						hosArticle.setHosTel(rs.getString("hosTel"));
						hosArticle.setHosSiAddress(rs.getString("hosSiAddress"));
						hosArticle.setHosGuAddress(rs.getString("hosGuAddress"));
						hosArticle.setHosNewAddress(rs.getString("hosNewAddress"));
						hosArticle.setHosOldAddress(rs.getString("hosOldAddress"));
						hosArticle.setHosNum(rs.getString("hosNum"));
						hosArticle.setHosNumPhoto(rs.getString("hosNumPhoto"));
						hosArticle.setHosBio(rs.getString("hosBio"));
						hosArticle.setHosReg(rs.getTimestamp("hosReg"));
						hosArticle.setHosActiveNum(rs.getInt("hosActiveNum"));
						hosArticle.setHosReason(rs.getString("hosReason"));
						hosArticle.setHosTime(rs.getString("hosTime"));
						
						// (24-17) 위 정보 add하여 hospitalList 리턴 값에 담아주기 
						searchMainHospitalList.add(hosArticle);
						
					//	do문 실행하고 커서 내려서 정보 있을때까지 반복 do(실행) -> while(조건문) 있으면 -> do, 없으면 do-while문 빠져나가기.
					} while (rs.next());
				}
				System.out.println("[HosDAO](24-17) (검색O) ArrayList 배열로 searchHospitalList : " + searchMainHospitalList);
				System.out.println("");
				
			} catch (Exception e) {
				// (12-5) 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace();
				
			// (24-6) try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 
			} finally {
				// (24-7) DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			
			// (24-8) sql문에서 가져온 정보를 배열로 담아 리턴해주기.
			return searchMainHospitalList;
			// (24-18) searchResult.jsp -> dao.getSearchHospital(startRow, endRow, hosName, hosSearch); 한거 searchHospitalList 변수에 담아주기.
			//		(23) searchMain.jsp -> list 타입으로 searchHospitalList 변수 담아주기.
		}
		
		
		// (39) avgPrice table에서 사용자가 선택한 구의 수가 0개 이상일때의 메서드 평균 정보 가져올 메서드 만들기. 
		public AvgPriceDTO getAvgPriceInfo(String guSel) {
			
			// (39-1) 리턴 받을 avgPriceDTO avgDto 변수 미리 생성하기.
			AvgPriceDTO avgDto = null;
			
			// (39-2) DB 연결 하여 값들 가져오기 위한 변수 미리 만들어 주기 (지역변수에 사용도 해야 하므로) 
			Connection conn = null;				// DB에 연결 하는 메서드 
			PreparedStatement pstmt = null;		// DB에 연결한걸 xxtable의 정보를 가져와 '준비(장전)' 시켜주는 메서드 ==> pstmt.executeQuery();
			ResultSet rs = null;				// 위 두개 즉, DB에 연결하여 정보를 가져와 준비한걸 '실행' 하는 메서드 ==> rs = pstmt.executeQuery();
			
			// (39-3) try-catch로 묶어주기 (DB연결 변수 사용과 종료 close(); 및 예외처리 발생시 개발자에게 오류 내용 보여줘야 하기 때문)
			try {
				// (39-4) DB 'hospital' table 가져오기 위한 DB 연결
				conn = getConnection();
				// (39-8) DB avgPrice 테이블에서 평균값 가져올 쿼리문 작성해주기.
				String sql = "SELECT " 
					    		+ "hosguaddress, "
					    		+ "ceil(ROUND(avg(hosBasicVaccin), -3)), "
					    		+ "ceil(ROUND(avg(hosNeuteringMan), -3)), "
					    		+ "ceil(ROUND(avg(hosNeuteringWoman), -3)), "
					    		+ "ceil(ROUND(avg(hosHeartWorm), -3)) "
					    	+ "FROM hospital "
					    	+ "where hosguaddress=? " 
					    	+ "group by hosguaddress";
				
				// (39-9) 'sql'(조건해당된 쿼리문)의 값을 가진 쿼리문 장전 하여 준비 시키켜 pstmt 에 담아주기(즉, 장전) 
				pstmt = conn.prepareStatement(sql);
				// (39-9) ? 에 불러올 값 대입해주기. 
				pstmt.setString(1, guSel);
				
				// (39-10) executeQuery 의 경우 DB에 있는 값을 가져올때 사용.
				// 			executeUpdate 의 경우 DB에 데이터를 입력(update) 할때 사용 
				// ResultSet rs 로 쿼리문 실행 하기. 
				rs = pstmt.executeQuery();			// 즉, 위 설정한 값으로 데이터 가져와 rs에 담아주어 실행하는 것이기 때문에 executeQuery(); 를 사용해야 함.
				System.out.println("[HosDAO](39-10) 평균값 구한 rs " + rs);
				System.out.println("");
				// (39-11) rs.next() 하여 해당 정보 보두 가져오기.
				if (rs.next()) {
					// (39-12) AvgPriceDTO avgDto 생성한거 get/set 해주어 담기.
					avgDto = new AvgPriceDTO();
					
					avgDto.setAvgHosGu(rs.getString(1));
					
					avgDto.setAvgBasicVaccin(rs.getInt(2));
					avgDto.setAvgNeuteringMan(rs.getInt(3));
					avgDto.setAvgNeuteringWoman(rs.getInt(4));
					avgDto.setAvgHeartWorm(rs.getInt(5));
				}
				System.out.println("[HosDAO](39-1) avgDto : " + avgDto);
				
			} catch (Exception e) {
				// (39-5) 예외 처리 발생 시 console 창에 보여주어 개발자에게 확인을 위한 처리.
				e.printStackTrace();
				
			// (39-6) try-catch 문과 상관 없이 무조건 실행 되는 finally문에 close(); 예외처리 해주기 
			} finally {
				// (39-7) DB연결 위해 연결 메서드 변수 가져와 사용했으니 꼭! 종료 close(); 해주기 
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}	
			
			// (39-13) 위 정보 리턴 해주기.
			return avgDto;
			// (40) searchResult 불러온곳으로 돌아가기.
		}
		
		 
		
		
		
		
		
		
		
		
		
}//HosDAO

