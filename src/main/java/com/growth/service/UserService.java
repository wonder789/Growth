package com.growth.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.growth.domain.UserVO;

public interface UserService extends UserDetailsService{
	
	void userSignup(UserVO userVO) throws Exception;
	
	UserVO findUser(UserVO userVO) throws Exception;
}
