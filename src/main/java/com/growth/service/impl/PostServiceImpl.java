package com.growth.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.growth.dao.CodeDao;
import com.growth.dao.FileDao;
import com.growth.dao.PostDao;
import com.growth.dao.UserDao;
import com.growth.domain.CodeVO;
import com.growth.domain.FileVO;
import com.growth.domain.PostVO;
import com.growth.domain.UserVO;
import com.growth.service.PostService;
import com.growth.util.Const;

@Service
@Transactional
public class PostServiceImpl implements PostService {

	
	@Autowired
	private PostDao postDao;
	
	@Autowired
	private FileDao fileDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CodeDao codeDao;
	
	@Override
	public void insertPost(PostVO postVO) throws Exception {
		//사진 등록 
		if( postVO.getFile().getOriginalFilename() != null && !postVO.getFile().getOriginalFilename().equals("") ){
			FileVO fileVO = new FileVO();
			fileVO.setFileNameOrg(postVO.getFile().getOriginalFilename());
			fileVO.setFileData(postVO.getFile().getBytes());
			
			fileDao.insertFile(fileVO);
			postVO.setThumbnail(fileVO.getFileId());
		}
		
		postDao.insertPost(postVO);
		
		CodeVO codeVO = codeDao.selectCodeByCodeId(Const.POST_WRITE_CODE);
		//글 작성에대한 포인트 값을 가져옴 
		UserVO userVO = new UserVO();
		userVO.setEmail(postVO.getWriterId());
		userVO.setActivity(Const.POST_WRITE_CODE);
		userVO.setPoint(Integer.parseInt(codeVO.getCodeComment1()));
		//활동내역 삽입 
		userDao.insertUserPointHistory(userVO);
		//드라이브 컬럼 업데이트
		userDao.updateUserPoint(postVO.getWriterId());

		//태그 등록
		if( postVO.getTag() != null && postVO.getTag().size() > 0  ){
			postDao.insertPostTags(postVO);
		}
		
	}

	@Override
	public List<String> selectPopularHashTag() throws Exception {
		return postDao.selectPopularHashTag();
	}

	@Override
	public List<PostVO> selectPostList(PostVO postVO) throws Exception {
		return postDao.selectPostList(postVO);
	}

	@Override
	public PostVO selectPostOne(PostVO postVO) throws Exception {
		return postDao.selectPostOne(postVO);
	}

	
	
	
	


}
