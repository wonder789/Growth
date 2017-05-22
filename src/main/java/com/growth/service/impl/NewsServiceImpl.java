package com.growth.service.impl;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.growth.domain.NewsVO;
import com.growth.service.NewsService;

@Service
public class NewsServiceImpl implements NewsService {

	@Override
	public List<NewsVO> getNewsList(String searchQuery, int displayCount) throws Exception{
		Document doc = Jsoup.connect("http://news.naver.com/main/search/search.nhn?display=" + displayCount
				+"&page=1&query=" + URLEncoder.encode(searchQuery,"ms949") ).get();
		Elements listItems = doc.select(".srch_lst > li");
		Element  thumbnail = null;
		NewsVO   newsVO = null;
		List<NewsVO> results = new ArrayList<NewsVO>();
		
		for( Element item : listItems ){
			newsVO = new NewsVO();
			newsVO.setImgUrl(item.select("img").attr("src"));
			newsVO.setTitle(item.select(".ct > a").text());
			newsVO.setLink(item.select(".ct > a").attr("href"));
			newsVO.setRegDate(item.select(".time").first().text());
			newsVO.setContent(item.select(".dsc").text().trim());
			results.add(newsVO);
		}
		return results;
	}

}
