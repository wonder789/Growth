package com.growth.service;

import java.util.HashMap;
import java.util.List;

import com.growth.domain.CodeVO;

public interface CodeService {
	
	List<CodeVO> selectCodeByPcode(String pCode) throws Exception;

}
