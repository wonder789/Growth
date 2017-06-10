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
		Document doc = Jsoup.connect("http://kookbang.dema.mil.kr/kookbangWeb/globalSearch.do")
				.data("category","NARMY")
				.data("searched_kwd","자기계발")
				.data("pageNum","1")
				.data("searchNum","15")
				.data("sort","d")
				.data("kokbangCheck","listAll")
				.data("opiniunCheck","listAll")
				.data("planCheck","listAll")
				.data("societyCheck","listAll")
				.data("sportsCheck","listAll")
				.data("armyCheck","listAll")
				.data("photoCheck","listAll")
				.data("kwd","자기계발")
				.post();
		Elements listItems = doc.select("dl.searchContents");
		Element  thumbnail = null;
		NewsVO   newsVO = null;
		List<NewsVO> results = new ArrayList<NewsVO>();
		
		for( Element item : listItems ){
			newsVO = new NewsVO();
			if( !item.select("img.thumbNail").attr("src").equals("") ){
				newsVO.setImgUrl("http://kookbang.dema.mil.kr" + item.select("img.thumbNail").attr("src"));
			}
			newsVO.setTitle(item.select("dt.tit").text());
			newsVO.setLink(item.select("dt.tit > a").attr("href"));
			newsVO.setRegDate(item.select("dd.day").text());
			newsVO.setContent(item.select("dd.text").text().trim());
			results.add(newsVO);
		}
		return results;
	}

}
