package com.growth.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.growth.dao.FileDao;
import com.growth.dao.UserDao;
import com.growth.domain.FileVO;
import com.growth.domain.UserVO;
import com.growth.service.UserService;
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private FileDao fileDao;
	
	
	@Autowired
	private UserDao userDao;
	
	
	@Override
	public void userSignup(UserVO userVO) throws Exception {
		FileVO fileVO = new FileVO();
		fileVO.setFileNameOrg(userVO.getFile().getOriginalFilename());
		fileVO.setFileData(userVO.getFile().getBytes());
		
		userVO.setPhoto(fileDao.insertFile(fileVO));
		userDao.insertUser(userVO);
	}


	@Override
	public UserVO findUser(UserVO userVO) throws Exception {
		return userDao.findUser(userVO);
	}

}
