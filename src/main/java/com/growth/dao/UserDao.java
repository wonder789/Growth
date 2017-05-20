package com.growth.dao;

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
	
	
	
}
