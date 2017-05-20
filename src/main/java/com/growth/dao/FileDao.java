package com.growth.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.growth.domain.FileVO;

@Repository
public class FileDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public int insertFile(FileVO fileVO) throws Exception{
		sqlSession.insert("com.growth.fileMapper.insertFile",fileVO);
		return fileVO.getFileId();
	}
	
	public FileVO selectFileBlobData(String fileId) throws Exception{
		return (FileVO) sqlSession.selectOne("com.growth.fileMapper.selectFileBlobData",fileId);
	}

}
