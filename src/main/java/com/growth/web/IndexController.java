package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.service.PostService;
import com.growth.service.UserService;

@Controller
@RequestMapping("/")
public class IndexController {
 
	@Autowired
	private PostService postService;
	
	@Autowired
	private UserService userService;
	
    @RequestMapping
    public String index(ModelMap model) throws Exception {
    	model.addAttribute("userList", userService.selectUserList(null));
        return "index";
    }
}