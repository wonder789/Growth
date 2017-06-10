package com.growth.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.growth.domain.UserCommentVO;
import com.growth.domain.UserTimelineVO;
import com.growth.domain.UserVO;

@Repository
public class UserDao {

	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertUser(UserVO userVO) throws Exception{
		return sqlSession.insert("com.growth.userMapper.insertUser",userVO);
	}
	
	public void insertUserTags(UserVO userVO) throws Exception{
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		
		paramMap.put("tagList", userVO.getTag());
		paramMap.put("userId", userVO.getEmail());
		
		sqlSession.insert("com.growth.userMapper.insertUserTags", paramMap);
	}
	
	public List<String> selectUserTags(UserVO userVO) throws Exception{
		return sqlSession.selectList("com.growth.userMapper.selectUserTags", userVO);
	}
	
	public void deleteUserTags(UserVO userVO) throws Exception{
		sqlSession.delete("com.growth.userMapper.deleteUserTags", userVO);
	}
	
	public UserVO findUser(UserVO userVO) throws Exception{
		return sqlSession.selectOne("com.growth.userMapper.findUser",userVO);
	}
	
	public void updateUserPoint(String email) throws Exception{
		sqlSession.update("com.growth.userMapper.updateUserPoint", email);
	}
	
	public void insertUserPointHistory(UserVO userVO ) throws Exception{
		sqlSession.insert("com.growth.userMapper.insertUserPointHistory",userVO);
	}
	
	public List<UserVO> selectUserList(UserVO userVO) throws Exception{
		return sqlSession.selectList("com.growth.userMapper.selectUserList",userVO);
	}
	
	
	public void insertUserComment(UserCommentVO commentVO) throws Exception{
		sqlSession.insert("com.growth.userMapper.insertUserComment", commentVO);
	}
	
	public List<UserCommentVO> selectUserCommentList(UserCommentVO commentVO) throws Exception{
		return sqlSession.selectList("com.growth.userMapper.selectUserCommentList", commentVO);
	}
	
	public void updateGrpCommentId(UserCommentVO commentVO) throws Exception{
		sqlSession.update("com.growth.userMapper.updateGrpCommentId", commentVO);
	}
	
	public void updateUserProfile(UserVO userVO) throws Exception{
		sqlSession.update("com.growth.userMapper.updateUserProfile", userVO);
	}
	
	public void insertUserTimeline(UserTimelineVO timelineVO) throws Exception{
		sqlSession.insert("com.growth.userMapper.insertUserTimeline", timelineVO);
	}
	
	public List<String> selectUserTimelineYear(UserTimelineVO timelineVO) throws Exception{
		return sqlSession.selectList("com.growth.userMapper.selectUserTimelineYear",timelineVO);
	}
	
	public List<UserTimelineVO> selectUserTimelineList(UserTimelineVO timelineVO) throws Exception{
		return sqlSession.selectList("com.growth.userMapper.selectUserTimelineList",timelineVO);
	}
}
