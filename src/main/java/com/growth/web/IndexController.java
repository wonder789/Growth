package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.service.NewsService;
import com.growth.service.PostService;
import com.growth.service.UserService;

@Controller
@RequestMapping("/")
public class IndexController {
 
	@Autowired
	private PostService postService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private NewsService newsService;
	
    @RequestMapping
    public String index(ModelMap model) throws Exception {
    	model.addAttribute("userList", userService.selectUserList(null));
    	model.addAttribute("newsList", newsService.getNewsList("군 장병 자기계발",5));
        return "index";
    }
}