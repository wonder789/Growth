package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.dao.UserDao;

@Controller
@RequestMapping("/")
public class IndexController {
 
	@Autowired
	UserDao userDao;
	
    @RequestMapping
    public String index() throws Exception {
        return "index";
    }
}