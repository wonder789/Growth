package com.growth.service;

import java.util.List;

import com.growth.domain.ContestVO;

public interface ContestService {
	List<ContestVO> getContestList() throws Exception;
}
