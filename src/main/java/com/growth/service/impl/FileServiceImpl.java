package com.growth.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.growth.dao.FileDao;
import com.growth.domain.FileVO;
import com.growth.service.FileService;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	private FileDao fileDao;
	
	
	
	@Override
	public FileVO selectFileBlobData(String fileId) throws Exception {
		return fileDao.selectFileBlobData(fileId);
	}

}
