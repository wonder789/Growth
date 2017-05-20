package com.growth.service;

import com.growth.domain.UserVO;

public interface UserService {
	
	void userSignup(UserVO userVO) throws Exception;
	
	UserVO findUser(UserVO userVO) throws Exception;
}
