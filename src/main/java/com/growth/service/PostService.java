package com.growth.service;

import java.util.List;

import com.growth.domain.PostVO;

public interface PostService {
	
	public void insertPost(PostVO postVO) throws Exception;
	
	public List<String> selectPopularHashTag() throws Exception;
	
	public List<PostVO> selectPostList(PostVO postVO) throws Exception;
	
	public PostVO selectPostOne(PostVO postVO) throws Exception;
	
	
}
