package com.growth.service;

import com.growth.domain.FileVO;

public interface FileService {
	
	public FileVO selectFileBlobData(String fileId) throws Exception;

}
