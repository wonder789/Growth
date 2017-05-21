package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.service.PostService;

@Controller
@RequestMapping("/")
public class IndexController {
 
	@Autowired
	PostService postService;
	
    @RequestMapping
    public String index() throws Exception {
    	
        return "index";
    }
}