package com.growth.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.growth.domain.ContestVO;
import com.growth.service.ContestService;

@Service
public class ContestServiceImpl implements ContestService{

	@Override
	public List<ContestVO> getContestList() throws Exception {
		Document doc = Jsoup.connect("http://www.wevity.com/?c=srh&s=2&kind=contest&sw=%EC%9E%A5%EB%B3%91&gbn=list&gp=1")
						.get();
		List<ContestVO> resultList = new ArrayList<ContestVO>();
		ContestVO temp = null;
		Elements listItems = doc.select(".result-list > li");
		
		for( Element element : listItems ){
			temp = new ContestVO();
			temp.setTitle(element.select(".tit > a").text());
			temp.setHref("http://www.wevity.com/" + element.select(".tit > a").attr("href"));
			temp.setContent(element.select(".result-desc").text());
			resultList.add(temp);
		}
		
		return resultList;
	}

}
