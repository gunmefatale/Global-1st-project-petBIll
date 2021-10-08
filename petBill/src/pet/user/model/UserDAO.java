package pet.user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pet.rev.model.RevDTO;

public class UserDAO {
	
	private static UserDAO instance = new UserDAO();
	private UserDAO() {}
	public static UserDAO getInstance() {return instance;}
	
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//회원가입 메서드
	
	public void userSignup(UserDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into users values(?,?,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getUserId());
			pstmt.setString(2,dto.getUserPw());
			pstmt.setString(3,dto.getUserName());
			pstmt.setString(4,dto.getUserMobile()); 
			pstmt.setString(5,dto.getUserNick());
			pstmt.setString(6,dto.getUserSiAddress());
			pstmt.setString(7,dto.getUserSelectAddress());
			pstmt.setString(8,dto.getUserDetailAddress());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
	}
	
	//회원 , 병원 로그인 체크  (로그인)
	
	public int IdPwcheck(String userId, String userPw, String login) { 
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;   
		int res = -1;  
		  
		if(login.equals("0")) {
			System.out.println("login if문 탐");
			
			
			if(userId.equals("admin")) {
				System.out.println("admin if문 탐");
				try {
					conn = getConnection();
					String sql = "select userPw from users where userId=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userId);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						String dbpw = rs.getString(1);
						if(dbpw.equals(userPw)) {
						res = 2; 
						}
					}	
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return res; 
			}else if(login.equals("0")){	
			try { 
					conn = getConnection();
					String sql = "select userPw from users where userId=? ";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1,userId);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						String dbpw= rs.getString(1);
						if(dbpw.equals(userPw)) {
							res = 0;
						}
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return res;
				// 병원
				}
		}else { 
				try {
						conn = getConnection();
						String sql = "select hosPw from HOSPITAL where hosId=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,userId);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							String dbpw = rs.getString(1);
							if(dbpw.equals(userPw)) {
								res = 1;
							}
						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally{
						if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
					}
				}
			return res; 
		}  
	
	// 회원 1명의 전체 정보 가져오기 (마이페이지)
	public UserDTO getUser(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDTO dto = null;
		
		try {
				conn = getConnection();
				String sql = "select * from users where userId=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userId);
				rs = pstmt.executeQuery();
			
				if(rs.next()) {
					dto = new UserDTO();
					dto.setUserId(rs.getString("userId"));
					dto.setUserPw(rs.getString("userPw"));
					dto.setUserName(rs.getString("userName"));
					dto.setUserMobile(rs.getString("userMobile"));
					dto.setUserNick(rs.getString("userNick"));
					dto.setUserSiAddress(rs.getString("userSiAddress"));
					dto.setUserSelectAddress(rs.getString("userSelectAddress"));
					dto.setUserDetailAddress(rs.getString("userDetailAddress"));
					dto.setUserReg(rs.getTimestamp("userReg"));
					
				}
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return dto;
		}
		
	
	//정보 수정
	
	public int updateUser(UserDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "update users set userMobile=?, userNick=?, userSiAddress=?, userSelectAddress=?, userDetailAddress=? where userId=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserMobile());
			pstmt.setString(2, dto.getUserNick());
			pstmt.setString(3, dto.getUserSiAddress());
			pstmt.setString(4, dto.getUserSelectAddress());
			pstmt.setString(5, dto.getUserDetailAddress());
			pstmt.setString(6, dto.getUserId());
			
			result = pstmt.executeUpdate();
			System.out.println("dao result: " + result); 
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
			}
		return result;
	}
	
	
	//비밀번호 수정 		세션아이디로 비교
	
	public int pwupdateUser(String userId, String userPw, String useruserPwModify) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select userPw from users where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpw = rs.getString(1);
				if(dbpw.equals(userPw)) {
					sql = "update users set userPw=? where userId=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, useruserPwModify);
					pstmt.setString(2, userId);
					result=pstmt.executeUpdate();
				}				
			}else {
				result = -1;
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
			return result;
	}		
	
	
			
			
	//회원탈퇴
	public int userDeletepw(String userId, String userPw) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int result = 0;
	      
	      try {
	         conn =  getConnection();
	         String sql = "select userPw from  users where userId=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userId);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            String dbpw = rs.getString("userPw");
	            if(dbpw.equals(userPw)) {
	               sql = "delete from users where userId=?";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, userId);
	               result = pstmt.executeUpdate();//1이면 삭제 성공  , 0이면 if문 안탄것, -1 삭제 실패
	               System.out.println("result 1 :" + result);
	               if(result == 1) {
	                  sql = "delete from review where reviewId=?";
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, userId);
	                  result = pstmt.executeUpdate(); 
	                  System.out.println("result 몇번이냐? : " + result);
	               }
	               
	            }else {
	               result = -1;
	            }
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
	         if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
	         if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
	      }
	      return result;
	      
	   }
	
	
	
	//id 찾기 이름, 핸드폰번호
	
	public String findid(String userName, String userMobile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbid = null;
		try {
			conn = getConnection();
			String sql = "select userId from users where userName=? and userMobile=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userMobile);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbid = rs.getString(1);
			}else {
				dbid = null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return dbid;
	}
	
	
	//비밀번호 찾기
	
	public String findpw(String userId, String userName, String userMobile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpw = null;
		try {
			conn = getConnection();
			String sql = "select userPw from users where userid = ? and username=? and userMobile = ?";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userName);
			pstmt.setString(3, userMobile);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString(1);
			}else {
				dbpw = null;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dbpw;
	}
	
	
	// 유저 게시글 전체 불러오기
	   public int getUserArticleCount(String userId) {
	      int count = 0; 
	      Connection conn = null; 
	      PreparedStatement pstmt = null;
	      ResultSet rs = null; 
	      
	      try {
	         conn = getConnection(); 
	         String sql = "select count(*) from review where reviewId=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userId);
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
	   
	   
	   //시작번호 끝번호 설정
	   public List getArticles(int startRow, int endRow, String userId) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   List articleList = null;
		   
		   try {
			   conn = getConnection();
			   String sql = "select B.*, r "+ 
					   			"from (select A.*, rownum r "+
					   				"from (select * from review where reviewId=? order by reviewno desc) A " + 
					   			"order by reviewno desc) B "+ 
					   		"where r >= ? and r <= ?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, userId);
			   pstmt.setInt(2, startRow);
			   pstmt.setInt(3, endRow);
			   
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   articleList = new ArrayList();
				   do {
					   RevDTO article = new RevDTO();
					   article.setReviewNo(rs.getInt("reviewNo"));
		               article.setReviewId(rs.getString("reviewId"));
		               article.setReviewPetKind(rs.getString("reviewPetKind"));
		               article.setReviewGender(rs.getString("reviewGender"));
		               article.setReviewAge(rs.getString("reviewAge"));
		               article.setReviewWeight(rs.getString("reviewWeight"));
		               article.setReviewPetType(rs.getString("reviewPetType"));
		               article.setReviewArticle(rs.getString("reviewArticle"));
		               article.setReviewPrice(rs.getString("reviewPrice"));
		               article.setReviewContent(rs.getString("reviewContent"));
		               article.setReviewJudge(rs.getString("reviewJudge"));
		               article.setReviewPhoto(rs.getString("reviewPhoto"));
		               article.setReviewHosNo(rs.getString("reviewHosNo"));
		               article.setReviewGu(rs.getString("reviewGu"));
		               article.setReviewRef(rs.getString("reviewRef"));
		               article.setReviewDate(rs.getTimestamp("reviewDate"));
		               article.setReviewSubject(rs.getString("reviewSubject")); 
		               
		               articleList.add(article);
				   }while(rs.next());
			   }
			   
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
		       if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   
		   return articleList;
	   }
	
	   
	   //아이디 중복 체크 
	   
	   public boolean confirmId(String userId) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   boolean result = false;
				   
				   
		   try {
			   conn =  getConnection();
			   String sql = "select userId from users where userId=?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1,userId);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   result = true;
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
	  
	   
	   //아이디 중복 체크 
	   
	   public boolean confirmNick(String userNick) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   boolean result = false;
		   try {
			   conn =  getConnection();
			   String sql = "select userNick from users where userNick=?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1,userNick);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   result = true;
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
	   
	   
	// 관리자 회원정보 전체 수 가져오는 메서드 
		public int getAdminUserCount() {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select count(*) from users";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
					System.out.println("회원정보 전체수 : " + count);
				}
			} catch (Exception e) {
				e.printStackTrace(); 	
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return count;
		}
		
		// 관리자 회원정보 모든 리스트로 불러올 메서드 
		public List getAdminUserList(int start, int end) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List adminUserList = null;
			
			try {
				conn = getConnection();
				String sql = "select B.*, r "
								+ "from (select A.*, rownum r "
									+ "from (select * from users order by userreg desc) A "
								+ "order by username) B "
							+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					UserDTO dto = new UserDTO();
					adminUserList = new ArrayList();
					do {
						dto.setUserId(rs.getString("userId"));
						dto.setUserPw(rs.getString("userPw"));
						dto.setUserName(rs.getString("userName"));
						dto.setUserMobile(rs.getString("userMobile"));
						dto.setUserNick(rs.getString("userNick"));
						dto.setUserSiAddress(rs.getString("userSiAddress"));
						dto.setUserSelectAddress(rs.getString("userSelectAddress"));
						dto.setUserDetailAddress(rs.getString("userDetailAddress"));
						dto.setUserReg(rs.getTimestamp("userReg"));
						
						adminUserList.add(dto);
						
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return adminUserList;
		}
	   
	   
	   
	   
	   
	   
	   
	
	
	
	
	
	
	

}
