package pet.cat.model;

import java.security.spec.RSAKeyGenParameterSpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CatDAO {

	
	// 커넥션 메서드 (분리)
	private Connection getConnection() throws Exception {
		// DB 연결
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		Connection conn = ds.getConnection();
		return conn;
	}
	
	// 대분류 전체 목록 가져오기 (한 페이지에서 보여줄 만큼만 가져오기) 
	public List getCatLarge(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		List catLarge = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select A.*, rownum from "
					+ "(select * from largepettable order by lptno) A "
					+ "where rownum >= ? and rownum <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 먼저 커서 1번째 레코드로 내려서 결과가 있는지확인 
				catLarge = new ArrayList(); // 저장공간 만들어주기 
				do { // if문 때문에 커서가 이미 내려갔으니 먼저 뽑고 while검사해서 다시 반복 
					CatLDTO dto = new CatLDTO();
					dto.setLptNo(rs.getInt("lptno"));
					dto.setLptName(rs.getString("lptname"));
					catLarge.add(dto);
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }
		}
		return catLarge;
	}

	// 대분류 수정
	public int updateCatL(CatLDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		int result = 0;

		try {
			//해당 대분류 고유번호 찾기
			conn = getConnection();
			String sql = "select lptNo from largepettable where lptNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getLptNo());
			//select문은 executeQuery로 쿼리문 날려주고
			//Resultset 타입인 rs 에 담아줌
			rs = pstmt.executeQuery();
	        
			if(rs.next()) { //rs에 내용이 있으면
				int rsNo = rs.getInt("lptNo"); //DB상의 lptNo을담아줌
				// 담아준 rsNo과 수정form의 lptNo과 비교해서 맞으면 업데이트!
			if(rsNo == article.getLptNo()) {
				sql = "update largepettable set lptName=? where lptNo=?"; 
	       		pstmt = conn.prepareStatement(sql);
	       		pstmt.setString(1, article.getLptName());
	       		pstmt.setInt(2, article.getLptNo());
	        		
	       		result = pstmt.executeUpdate();
	        	 }
	         }
	         
	      }catch(Exception e){
	         e.printStackTrace();

	      }finally {
	    	 if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
	         if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
	         if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }
	      }
	      return result;
	   }//updateCatL
	
	// 대분류 삭제
	public int deleteCatL(int lptNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "delete from largepettable where lptNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lptNo);
				
			result = pstmt.executeUpdate();
			// 삭제 잘 되었으면 1 리턴
			// System.out.println("Result dao : "+result);
				
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }

		}
		return result;
	}
	
	// 대분류 추가
	public int insertCatL(CatLDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "insert into largepettable values(largepettable_seq.nextVal,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getLptName());
			
			result = pstmt.executeUpdate();
			

		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace();}			
		}
		return result;
	}
	
	// update는 수정, select는 삭제, insert는 추가
	
	   // 소분류 전체 목록 가져오기 (한 페이지에서 보여줄 만큼만 가져오기) 
    public List getCatSmall(int startRow, int endRow) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null; 
       List catSmall = null; 
       
       try {
          conn = getConnection(); 
          String sql = "select A.*, rownum from "
                + "(select * from smallpettable order by sublptno) A "
                + "where rownum >= ? and rownum <= ?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, startRow);
          pstmt.setInt(2, endRow);
          
          rs = pstmt.executeQuery(); 
          if(rs.next()) { // 먼저 커서 1번째 레코드로 내려서 결과가 있는지확인 
             System.out.println("if 탔다");
             catSmall = new ArrayList(); // 저장공간 만들어주기 
             do { // if문 때문에 커서가 이미 내려갔으니 먼저 뽑고 while검사해서 다시 반복 
                CatSDTO dto = new CatSDTO();
                dto.setSubNo(rs.getInt("subno"));
                dto.setSubLptNo(rs.getString("sublptno"));
                dto.setSubName(rs.getString("subname"));
                dto.setSubImg(rs.getString("subimg"));
                catSmall.add(dto);
             }while(rs.next());
          }
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
          if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
          if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }
       }
       return catSmall;
    }
 
	
	// 소분류 수정
	public int updateCatS(CatSDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		int results = 0;

		try {
			//해당 대분류 고유번호 찾기
			conn = getConnection();
			String sql = "select subName from smallpettable where subNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getSubNo());
			//select문은 executeQuery로 쿼리문 날려주고
			//Resultset 타입인 rs 에 담아줌
			rs = pstmt.executeQuery();
	        
			if(rs.next()) { //rs에 내용이 있으면
				int rsNo = rs.getInt("subno"); //DB상의 lptNo을담아줌
				// 담아준 rsNo과 수정form의 lptNo과 비교해서 맞으면 업데이트!
			if(rsNo == article.getSubNo()) {
				sql = "update smallpettable set subName=? where subNo=?"; 
	       		pstmt = conn.prepareStatement(sql);
	       		pstmt.setString(1, article.getSubName());
	       		pstmt.setInt(2, article.getSubNo());
	        		
	       		results = pstmt.executeUpdate();
	        	 }
	         }
	         
	      }catch(Exception e){
	         e.printStackTrace();

	      }finally {
	    	 if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
	         if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
	         if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }
	      }
	      return results;
	   }//updateCatL
	
	// 소분류 삭제
	public int deleteCatS(int subNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "delete from smallpettable where subNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subNo);
				
			result = pstmt.executeUpdate();
			// 삭제 잘 되었으면 1 리턴
			// System.out.println("Results dao : "+results);
				
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }

		}
		return result;
	}
	
	
	//대분류 가져오는 메서드
	public List Lptdata() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		
		try {
			conn = getConnection();
			String sql = "select * from largepettable";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList();
				do {
					CatLDTO article = new CatLDTO();
					article.setLptName(rs.getString("lptName"));
					article.setLptNo(rs.getInt("lptNo"));
					//System.out.println(article.getLptName());
					articleList.add(article);
				}while(rs.next());
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();}catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close();}catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close();}catch(Exception e) { e.printStackTrace(); }
		}
		 return articleList;
	}
	
	
/*	
	// 대분류, 소분류, img 추가하기
	public CatSDTO updateinsertImg(CatSDTO dto) {
*/
}
