package com.growth.service;

import java.util.List;

import com.growth.domain.PostVO;

public interface PostService {
	
	public void insertPost(PostVO postVO) throws Exception;
	
	public List<String> selectPopularHashTag() throws Exception;
	
	public List<PostVO> selectPostList(PostVO postVO) throws Exception;
	
	public PostVO selectPostOne(PostVO postVO) throws Exception;
	
	public void updateHitCount(PostVO postVO) throws Exception;
	
	public void updateLikeCount(PostVO postVO) throws Exception;
	
	public int selectPostLikeCnt(PostVO postVO) throws Exception;
	
	public void updateDislike(PostVO postVO) throws Exception;
	
	public void insertPostComment(PostVO postVO) throws Exception;
	
	public List<PostVO> selectPostComments(PostVO postVO) throws Exception;
}
