package com.growth.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.growth.domain.UserVO;

@Repository
public class UserDao {

	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertUser(UserVO userVO) throws Exception{
		return sqlSession.insert("com.growth.userMapper.insertUser",userVO);
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
	
}
