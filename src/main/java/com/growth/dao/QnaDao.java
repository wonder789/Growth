package com.growth.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.growth.domain.QnaVO;
import com.growth.domain.QnaVO;

@Repository
public class QnaDao {

	
	@Autowired
	private SqlSession sqlSession;
	
	
	public void insertQna(QnaVO qnaVO) throws Exception{
		sqlSession.insert("com.growth.qnaMapper.insertQna",qnaVO);
	}
	
	public void insertQnaTags(QnaVO qnaVO) throws Exception{
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		
		paramMap.put("tagList", qnaVO.getTag());
		paramMap.put("qnaId", qnaVO.getQnaId());
		
		sqlSession.insert("com.growth.qnaMapper.insertQnaTags", paramMap);
	}
	
	public List<QnaVO> selectQnaList(QnaVO qnaVO) throws Exception{
		return sqlSession.selectList("com.growth.qnaMapper.selectQnaList",qnaVO);
	}
	
	public List<String> selectPopularHashTag() throws Exception{
		return sqlSession.selectList("com.growth.qnaMapper.selectPopularHashTag");
	}
	
	public QnaVO selectQnaOne(QnaVO qnaVO) throws Exception{
		return sqlSession.selectOne("com.growth.qnaMapper.selectQnaOne",qnaVO);
	}
	
	public void updateHitCount(QnaVO qnaVO) throws Exception{
		sqlSession.update("com.growth.qnaMapper.updateHitCount",qnaVO);
	}
	
	public void upateLikeCount(QnaVO qnaVO) throws Exception{
		sqlSession.update("com.growth.qnaMapper.updateLikeCount", qnaVO);
	}
	
	public void insertQnaLike(QnaVO qnaVO) throws Exception{
		sqlSession.insert("com.growth.qnaMapper.insertQnaLike", qnaVO);
	}
	
	public int selectQnaLikeCnt(QnaVO qnaVO) throws Exception{
		return (Integer)sqlSession.selectOne("com.growth.qnaMapper.selectQnaLikeCnt", qnaVO);
	}
	
	public void deleteQnaLike(QnaVO qnaVO) throws Exception{
		sqlSession.delete("com.growth.qnaMapper.deleteQnaLike", qnaVO); 
	}
	
	public void insertQnaComment(QnaVO qnaVO) throws Exception{
		sqlSession.insert("com.growth.qnaMapper.insertQnaComment",qnaVO);
	}
	
	public List<QnaVO> selectQnaComments(QnaVO qnaVO) throws Exception{
		return sqlSession.selectList("com.growth.qnaMapper.selectQnaComments", qnaVO);
	}
	
	public void qnaSelectAnswer(QnaVO qnaVO) throws Exception{
		sqlSession.update("com.growth.qnaMapper.qnaSelectAnswer",qnaVO);
	}
}
