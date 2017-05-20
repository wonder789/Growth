package com.growth.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.growth.dao.CodeDao;
import com.growth.domain.CodeVO;
import com.growth.service.CodeService;

@Service
public class CodeServiceImpl implements CodeService {

	@Autowired
	private CodeDao codeDao;
	
	@Override
	public List<CodeVO> selectCodeByPcode(String pCode) throws Exception {
		return codeDao.selectCodeByPcode(pCode);
	}

}
