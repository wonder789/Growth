package com.growth.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.growth.dao.FileDao;
import com.growth.dao.UserDao;
import com.growth.domain.FileVO;
import com.growth.domain.UserCommentVO;
import com.growth.domain.UserTimelineVO;
import com.growth.domain.UserVO;
import com.growth.service.UserService;
@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private FileDao fileDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private UserDao userDao;
	
	
	@Override
	public void userSignup(UserVO userVO) throws Exception {
		FileVO fileVO = new FileVO();
		fileVO.setFileNameOrg(userVO.getFile().getOriginalFilename());
		fileVO.setFileData(userVO.getFile().getBytes());
		userVO.setPassword(passwordEncoder.encode(userVO.getPassword()));
		userVO.setPhoto(fileDao.insertFile(fileVO));
		userDao.insertUser(userVO);
	}


	@Override
	public UserVO findUser(UserVO userVO) throws Exception {
		return userDao.findUser(userVO);
	}

	

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		UserVO userVO = new UserVO();
		UserVO result = null;
		userVO.setEmail(email);
		try {
			result = userDao.findUser(userVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if( result == null ){
			throw new UsernameNotFoundException("없는 유저 입니다.");
		}
		return result;
	}


	@Override
	public List<UserVO> selectUserList(UserVO userVO) throws Exception {
		return userDao.selectUserList(userVO);
	}


	@Override
	public void insertUserComment(UserCommentVO commentVO) throws Exception {
		userDao.insertUserComment(commentVO);
	}


	@Override
	public List<UserCommentVO> selectUserCommentList(UserCommentVO commentVO) throws Exception {
		return userDao.selectUserCommentList(commentVO);
	}


	@Override
	public void updateUserProfile(UserVO userVO) throws Exception {
		userDao.updateUserProfile(userVO);
		
		//태그 등록
		if( userVO.getTag() != null && userVO.getTag().size() > 0  ){
			userDao.deleteUserTags(userVO);
			userDao.insertUserTags(userVO);
		}
	}


	@Override
	public List<String> selectUserTags(UserVO userVO) throws Exception {
		return userDao.selectUserTags(userVO);
	}


	@Override
	public void insertUserTimeline(UserTimelineVO timelineVO) throws Exception {
		FileVO fileVO = new FileVO();
		fileVO.setFileNameOrg(timelineVO.getFile().getOriginalFilename());
		fileVO.setFileData(timelineVO.getFile().getBytes());
		timelineVO.setThumbnail(fileDao.insertFile(fileVO));
		userDao.insertUserTimeline(timelineVO);
	}


	@Override
	public HashMap<String, Object> selectUserTimelineList(UserTimelineVO timelineVO) throws Exception {
		List<String> yearList = userDao.selectUserTimelineYear(timelineVO);
		HashMap<String,Object> result = new HashMap<String,Object>();
		
		for( String year : yearList ){
			timelineVO.setSearchYear(year);
			result.put(year, userDao.selectUserTimelineList(timelineVO));
		}
		
		return result;
	}
	
	

}
