package com.growth.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.growth.domain.PostVO;

@Repository
public class PostDao {

	@Autowired
	private SqlSession sqlSession;

	
	public int insertPost(PostVO postVO) throws Exception{
		sqlSession.insert("com.growth.postMapper.insertPost", postVO);
		return postVO.getPostId();
	}
	
	public void insertPostTags(PostVO postVO) throws Exception{
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		
		paramMap.put("tagList", postVO.getTag());
		paramMap.put("postId", postVO.getPostId());
		
		sqlSession.insert("com.growth.postMapper.insertPostTags", paramMap);
	}
	
	public List<String> selectPopularHashTag() throws Exception{
		return sqlSession.selectList("com.growth.postMapper.selectPopularHashTag");
	}
	
	public List<PostVO> selectPostList(PostVO postVO) throws Exception{
		return sqlSession.selectList("com.growth.postMapper.selectPostList",postVO);
	}
	
	public PostVO selectPostOne(PostVO postVO) throws Exception{
		return sqlSession.selectOne("com.growth.postMapper.selectPostOne",postVO);
	}
	
	public void updateHitCount(PostVO postVO) throws Exception{
		sqlSession.update("com.growth.postMapper.updateHitCount",postVO);
	}
	
	public void upateLikeCount(PostVO postVO) throws Exception{
		sqlSession.update("com.growth.postMapper.updateLikeCount", postVO);
	}
	
	public void insertPostLike(PostVO postVO) throws Exception{
		sqlSession.insert("com.growth.postMapper.insertPostLike", postVO);
	}
	
	public int selectPostLikeCnt(PostVO postVO) throws Exception{
		return (Integer)sqlSession.selectOne("com.growth.postMapper.selectPostLikeCnt", postVO);
	}
	
	public void deletePostLike(PostVO postVO) throws Exception{
		sqlSession.delete("com.growth.postMapper.deletePostLike", postVO); 
	}
	
	public void insertPostComment(PostVO postVO) throws Exception{
		sqlSession.insert("com.growth.postMapper.insertPostComment",postVO);
	}
	
	public List<PostVO> selectPostComments(PostVO postVO) throws Exception{
		return sqlSession.selectList("com.growth.postMapper.selectPostComments", postVO);
	}
	
	
}
