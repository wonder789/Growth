package com.growth.service;

import java.util.List;

import com.growth.domain.QnaVO;
import com.growth.domain.UserVO;

public interface QnaService {
	
	
	public void insertQna(QnaVO qnaVO) throws Exception;
	
	public List<QnaVO> selectQnaList(QnaVO qnaVO) throws Exception;
	
	public List<String> selectPopularHashTag() throws Exception;
	
	public QnaVO selectQnaOne(QnaVO qnaVO) throws Exception;
	
	public void updateHitCount(QnaVO qnaVO) throws Exception;
	
	public void updateLikeCount(QnaVO qnaVO) throws Exception;
	
	public int selectQnaLikeCnt(QnaVO qnaVO) throws Exception;
	
	public void updateDislike(QnaVO qnaVO) throws Exception;
	
	public void insertQnaComment(QnaVO qnaVO) throws Exception;
	
	public List<QnaVO> selectQnaComments(QnaVO qnaVO) throws Exception;

	public void qnaSelectAnswer(QnaVO qnaVO, UserVO userVO) throws Exception;
	
}	
