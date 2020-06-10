package com.sist.dao;
import java.util.*;
import java.sql.*;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// 드라이버 등록
	public BoardDAO()
	{
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 연결
	public void getConnection()
	{
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	// 연결 해제
	public void disConnection()
	{
		try {
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	// 목록 출력하기
	public List<BoardVO> boardListData(int page)
	{
		List<BoardVO> list=new ArrayList<BoardVO>();
		
		try {
			getConnection();
			String sql="SELECT no,subject,name,regdate,hit,group_tab,num "
					+ "FROM (SELECT no,subject,name,regdate,hit,group_tab,rownum as num "
					+ "FROM (SELECT no,subject,name,regdate,hit,group_tab "
					+ "FROM replyBoard ORDER BY group_id DESC,group_step ASC)) "
					+ "WHERE num BETWEEN ? AND ?";
			// rownum은 중간부터 잘라낼 수 없다!
			int rowSize=10;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			
			// 전송
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next())
			{
				BoardVO vo=new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setRegdate(rs.getDate(4));
				vo.setHit(rs.getInt(5));
				vo.setGroup_tab(rs.getInt(6));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			disConnection();
		}
		
		return list;
	}
	public int boardRowCount()
	{
		int count=0;
		
		try {
			getConnection();
			String sql="SELECT COUNT(*) FROM replyBoard";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return count;
	}
	public void boardInsert(BoardVO vo)
	{
		try {
			getConnection();
			String sql="INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) "
					+ "VALUES(rb_no_seq.nextval,?,?,?,?,(SELECT NVL(MAX(group_id)+1,1) FROM replyBoard))";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());
			//실행요청   	/ insert는 update, select는 querry
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	// 내용보기(조회수 증가)(= type=0) / 수정하기(데이터읽기)(= type=1)
	public BoardVO boardDetailData(int no, int type)
	{
		BoardVO vo=new BoardVO();
		
		try {
			getConnection();
			String sql="";
			if(type==0) // 조회수 증가
			{
				sql="UPDATE replyBoard SET "
					+ "hit=hit+1 "
					+ "WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, no);
				ps.executeUpdate();
			}
			// 상세보기와 수정하기 동시에 처리하기.
			sql="SELECT no,name,subject,content,regdate,hit "
				+ "FROM replyBoard "
				+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			// 데이터를 읽기 시작한다.
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setRegdate(rs.getDate(5));
			vo.setHit(rs.getInt(6));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return vo;
	}
	// 수정
	public boolean boardUpdate(BoardVO vo)
	{
		boolean bCheck=false;
		
		try {
			getConnection();
			String sql="SELECT pwd FROM replyBoard "
					+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getNo());
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			if(db_pwd.equals(vo.getPwd()))
			{
				bCheck=true;
				sql="UPDATE replyBoard SET "
					+ "name=?,subject=?,content=? "
					+ "WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, vo.getName());
				ps.setString(2, vo.getSubject());
				ps.setString(3, vo.getContent());
				ps.setInt(4, vo.getNo());
				
				ps.executeUpdate(); //commit
			}
			else
			{
				bCheck=false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return bCheck;
	}
	// 답변하기
	public void replyInsert(int pno,BoardVO vo)
	{
		try {
			getConnection();
			
			conn.setAutoCommit(false);
			
			// 그룹아이디, 그룹스탭, 그룹탭
			String sql="SELECT group_id,group_step,group_tab "
					+ "FROM replyBoard "
					+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, pno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int gi=rs.getInt(1);
			int gs=rs.getInt(2);
			int gt=rs.getInt(3);
			rs.close();
			
			sql="UPDATE replyBoard SET "
				+ "group_step=group_step+1 "
				+ "WHERE group_id=? AND group_step>?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gi);
			ps.setInt(2, gs);
			ps.executeUpdate();
			
			// 데이터 추가
			sql="INSERT INTO replyBoard(no,name,subject,content,pwd,group_id,group_step,group_tab,root) VALUES("
					+ "rb_no_seq.nextval,?,?,?,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());
			ps.setInt(5, gi);
			ps.setInt(6, gs+1);
			ps.setInt(7, gt+1);
			ps.setInt(8, pno);
			
			ps.executeUpdate();
			
			// depth 증가(+1)
			sql="UPDATE replyBoard SET "
				+ "depth=depth+1 "
				+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, pno);
			ps.executeUpdate();
			
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (Exception e2) {}
			
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {
				// TODO: handle exception
			}
			
			disConnection();
		}
	}
	// 삭제하기
	public int boardDelete(int no,String pwd)
	{
		int result=0;
		
		try {
			getConnection();
			// 넘어온 비밀번호가 맞는지 검색하기!
			String sql="SELECT pwd FROM replyBoard "
					+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			
			if(db_pwd.equals(pwd))
			{
				result=1;
				sql="SELECT root,depth FROM replyBoard "
					+ "WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, no);
				rs=ps.executeQuery();
				rs.next();
				int root=rs.getInt(1);
				int depth=rs.getInt(2);
				rs.close();
				
				if(depth==0)
				{
					sql="DELETE FROM replyBoard "
						+ "WHERE no=?";
					ps=conn.prepareStatement(sql);
					ps.setInt(1, no);
					ps.executeUpdate();
				}
				else
				{
					String msg="관리자가 삭제한 게시물입니다.";
					sql="UPDATE replyBoard SET "
						+ "subject=?,content=? "
						+ "WHERE no=?";
					ps=conn.prepareStatement(sql);
					ps.setString(1, msg);
					ps.setString(2, msg);
					ps.setInt(3, no);
					ps.executeUpdate();
					
					sql="UPDATE replyBoard SET "
						+ "depth=depth-1 "
						+ "WHERE no=?";
					ps=conn.prepareStatement(sql);
					ps.setInt(1, root);
					ps.executeUpdate();
				}
			}
			else
			{
				result=0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return result;
	}
}
