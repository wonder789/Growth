package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.service.NewsService;

@Controller
public class NewsController {
	
	@Autowired
	private NewsService newsService;
	
	
	@RequestMapping(value="/news/newsList.do")
	public String newsList(String searchQuery,
						   ModelMap model) throws Exception{
		
		model.addAttribute("newsList" , newsService.getNewsList("군 장병 자기계발",5));
		return "/news/newsList";
	}
}
