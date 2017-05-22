package com.growth.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.growth.dao.CodeDao;
import com.growth.dao.QnaDao;
import com.growth.dao.UserDao;
import com.growth.domain.CodeVO;
import com.growth.domain.QnaVO;
import com.growth.domain.QnaVO;
import com.growth.domain.UserVO;
import com.growth.service.QnaService;
import com.growth.util.Const;

@Service
@Transactional
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private CodeDao codeDao;
	
	
	@Autowired
	private UserDao userDao;
	



	@Override
	public void insertQna(QnaVO qnaVO) throws Exception {
		qnaDao.insertQna(qnaVO);
		
		CodeVO codeVO = codeDao.selectCodeByCodeId(Const.QNA_WRITE_CODE);
		//글 작성에대한 포인트 값을 가져옴 
		UserVO userVO = new UserVO();
		userVO.setEmail(qnaVO.getWriterId());
		userVO.setActivity(Const.QNA_WRITE_CODE);
		userVO.setPoint(Integer.parseInt(codeVO.getCodeComment1()));
		//활동내역 삽입 
		userDao.insertUserPointHistory(userVO);
		//드라이브 컬럼 업데이트
		userDao.updateUserPoint(qnaVO.getWriterId());

		//태그 등록
		if( qnaVO.getTag() != null && qnaVO.getTag().size() > 0  ){
			qnaDao.insertQnaTags(qnaVO);
		}

	}




	@Override
	public List<QnaVO> selectQnaList(QnaVO qnaVO) throws Exception {
		return qnaDao.selectQnaList(qnaVO);
	}
	
	@Override
	public List<String> selectPopularHashTag() throws Exception {
		return qnaDao.selectPopularHashTag();
	}


	@Override
	public QnaVO selectQnaOne(QnaVO qnaVO) throws Exception {
		return qnaDao.selectQnaOne(qnaVO);
	}

	@Override
	public void updateHitCount(QnaVO qnaVO) throws Exception {
		qnaDao.updateHitCount(qnaVO);
	}

	@Override
	public void updateLikeCount(QnaVO qnaVO) throws Exception {
		qnaDao.insertQnaLike(qnaVO);
		qnaDao.upateLikeCount(qnaVO);
	}

	@Override
	public int selectQnaLikeCnt(QnaVO qnaVO) throws Exception {
		return qnaDao.selectQnaLikeCnt(qnaVO);
	}

	@Override
	public void updateDislike(QnaVO qnaVO) throws Exception {
		qnaDao.deleteQnaLike(qnaVO);
		qnaDao.upateLikeCount(qnaVO);
	}

	
	@Override
	public void insertQnaComment(QnaVO qnaVO) throws Exception {
		qnaDao.insertQnaComment(qnaVO);
	}

	@Override
	public List<QnaVO> selectQnaComments(QnaVO qnaVO) throws Exception {
		return qnaDao.selectQnaComments(qnaVO);
	}

}
