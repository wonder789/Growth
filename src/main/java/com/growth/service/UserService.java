package com.growth.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.growth.domain.UserCommentVO;
import com.growth.domain.UserTimelineVO;
import com.growth.domain.UserVO;

public interface UserService extends UserDetailsService{
	
	void userSignup(UserVO userVO) throws Exception;
	
	UserVO findUser(UserVO userVO) throws Exception;
	
	List<UserVO> selectUserList(UserVO userVO) throws Exception;
	
	void insertUserComment(UserCommentVO commentVO) throws Exception;
	
	List<UserCommentVO> selectUserCommentList(UserCommentVO commentVO) throws Exception;
	
	List<String> selectUserTags(UserVO userVO) throws Exception;
	
	void updateUserProfile(UserVO userVO) throws Exception;
	
	void insertUserTimeline(UserTimelineVO timelineVO) throws Exception;
	
	HashMap<String, Object> selectUserTimelineList(UserTimelineVO timelineVO) throws Exception;
}
