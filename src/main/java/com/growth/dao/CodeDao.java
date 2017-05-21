package com.growth.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.growth.domain.CodeVO;

@Repository
public class CodeDao {

	@Autowired
	SqlSession sqlSession;
	
	
	public List<CodeVO> selectCodeByPcode(String pCode) throws Exception{
		return sqlSession.selectList("com.growth.codeMapper.selectCodeByPcode", pCode);
	}
	
	public CodeVO selectCodeByCodeId(String codeId) throws Exception{
		return sqlSession.selectOne("com.growth.codeMapper.selectCodeByCodeId", codeId);
	}
}
