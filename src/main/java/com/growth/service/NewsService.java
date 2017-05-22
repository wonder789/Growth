package com.growth.service;

import java.util.List;

import com.growth.domain.NewsVO;

public interface NewsService {

	public List<NewsVO> getNewsList(String searchQuery, int displayCount) throws Exception;
}
