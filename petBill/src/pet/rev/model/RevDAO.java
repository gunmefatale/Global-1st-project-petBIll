package pet.rev.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pet.hos.model.HosDTO;
import pet.rev.model.RevDAO;
import pet.rev.model.RevDTO;



public class RevDAO {
	
	private static RevDAO instance = new RevDAO();
	private RevDAO() {}
	public static RevDAO getInstance() {return instance;}
	
	

	   private Connection getConnection() throws Exception {
	      Context ctx = new InitialContext();
	      Context env = (Context)ctx.lookup("java:comp/env");
	      DataSource ds = (DataSource)env.lookup("jdbc/orcl");
	      return ds.getConnection();
	   }
	   
	   // 게시글 전체 가져오기 
	   public int getArticleCount() {
	      int count = 0; 
	      Connection conn = null; 
	      PreparedStatement pstmt = null;
	      ResultSet rs = null; 
	      
	      try {
	         conn = getConnection(); 
	         String sql = "select count(*) from review";
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery(); 
	         if(rs.next()) {
	            count = rs.getInt(1);  
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
	         if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
	         if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	      }
	      return count;
	   }

	   // 글 저장
	   public void RevinsertArticle(RevDTO article) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		    
		   try {
			   conn = getConnection();
			   String sql = "insert into review(reviewNo,reviewId,reviewSubject,reviewPetKind,reviewGender,reviewAge,reviewWeight,reviewPetType,reviewPhoto,reviewArticle,reviewPrice,reviewContent,reviewJudge,reviewHosNo,reviewGu,reviewDate) "
					   +"values(review_seq.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, article.getReviewId());
			   pstmt.setString(2, article.getReviewSubject()); 
			   pstmt.setString(3, article.getReviewPetKind());
			   pstmt.setString(4, article.getReviewGender());
			   pstmt.setString(5, article.getReviewAge());
			   pstmt.setString(6, article.getReviewWeight());
			   pstmt.setString(7, article.getReviewPetType());
			   pstmt.setString(8, article.getReviewPhoto());
			   pstmt.setString(9, article.getReviewArticle());
			   pstmt.setString(10, article.getReviewPrice());
			   pstmt.setString(11, article.getReviewContent());
			   pstmt.setString(12, article.getReviewJudge());
			   pstmt.setString(13, article.getReviewHosNo());
			   pstmt.setString(14, article.getReviewGu());
			   pstmt.executeUpdate();
			  
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			   
		   }
	   }
	   
	   
	   // 리뷰 삭제  -- reviewNo랑 HosNo랑 같은지 확인해함
	   public int deleteReview(String userId, String userPw, int reviewNo) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   int result = 0;
		   try {
			   conn = getConnection();
			   String sql = "select userPw from users where userId=?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, userId);
			   rs = pstmt.executeQuery();
			   
			   if(rs.next()) {
				   String dbPw = rs.getString("userPw");
				   
				   System.out.println("dbpw : " + dbPw);
				   System.out.println("userPw : " + userPw);
				   
				   if(dbPw.equals(userPw)) {
					   sql = "delete from review where reviewId=? and reviewNo=?";
					   pstmt = conn.prepareStatement(sql);
					   pstmt.setString(1, userId);
					   pstmt.setInt(2, reviewNo);
					   result = pstmt.executeUpdate();
				   }else {
					   result = -1;
				   }
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   return result;
	   }
			   
  
	   // 아이디로 게시글 가져오기
	   public RevDTO getReview(String userId, String reviewHosNo) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			RevDTO rev = null;
			
			try {
				conn = getConnection();
				String sql = "select * from review where reviewId = ? and reviewHosNo = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userId); 
				pstmt.setString(2, reviewHosNo);   
				rs = pstmt.executeQuery();
				if(rs.next()) {
					rev = new RevDTO();
			               rev.setReviewNo(rs.getInt("reviewNo"));
			               rev.setReviewId(rs.getString("reviewId"));
			               rev.setReviewSubject(rs.getString("reviewSubject"));			               
			               rev.setReviewPetKind(rs.getString("reviewPetKind"));
			               rev.setReviewGender(rs.getString("reviewGender"));
			               rev.setReviewAge(rs.getString("reviewAge"));
			               rev.setReviewWeight(rs.getString("reviewWeight"));
			               rev.setReviewPetType(rs.getString("reviewPetType"));
			               rev.setReviewPhoto(rs.getString("reviewPhoto"));
			               rev.setReviewArticle(rs.getString("reviewArticle"));
			               rev.setReviewPrice(rs.getString("reviewPrice"));
			               rev.setReviewContent(rs.getString("reviewContent"));
			               rev.setReviewJudge(rs.getString("reviewJudge"));
			               rev.setReviewHosNo(rs.getString("reviewHosNo"));
			               rev.setReviewGu(rs.getString("reviewGu"));
			               rev.setReviewRef(rs.getString("reviewRef"));
			               rev.setReviewDate(rs.getTimestamp("reviewDate"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			
			}
			return rev;
		}
	   
	   
	   	// 리뷰 수정 처리
		public int ReviewUpdate(RevDTO dto,String userId) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			int result = 0;
			System.out.println("123 :" + dto.getReviewNo());
			System.out.println("456 :" + dto.getReviewId());
			try {
				conn = getConnection();
				
				// 고유넘
				String sql = "select * from review where reviewNo=? and reviewId=?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getReviewNo());
				pstmt.setString(2, dto.getReviewId());
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					String dbno = rs.getString(1);
					System.out.println("dbno : " + dbno);
					if(dbno != null) { // rs 값이 null이 아닐 때
						sql = "update review set "
								+ "reviewSubject=?, reviewPetKind=?, reviewGender=?, reviewAge=?, reviewWeight=?, reviewPetType=?, "
								+ "reviewPhoto=?, reviewArticle=?, reviewPrice=?, reviewContent=?, reviewJudge=? where reviewNo=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, dto.getReviewSubject());
						pstmt.setString(2, dto.getReviewPetKind());
						pstmt.setString(3, dto.getReviewGender());
						pstmt.setString(4, dto.getReviewAge());
						pstmt.setString(5, dto.getReviewWeight());
						pstmt.setString(6, dto.getReviewPetType());
						pstmt.setString(7, dto.getReviewPhoto());
						pstmt.setString(8, dto.getReviewArticle());
						pstmt.setString(9, dto.getReviewPrice());
						pstmt.setString(10, dto.getReviewContent());
						pstmt.setString(11, dto.getReviewJudge());
						pstmt.setInt(12, dto.getReviewNo());
						result = pstmt.executeUpdate(); // 하나의 레코드 업데이트 되면 1리턴 
					}else {
						result = -1;
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return result;
		}
		// 병원 답글
		public void HosRef(RevDTO article) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				String sql = "update review set reviewRef=? where reviewNo=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, article.getReviewRef());
				pstmt.setInt(2, article.getReviewNo());
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
		}
		
}  


	
	   

