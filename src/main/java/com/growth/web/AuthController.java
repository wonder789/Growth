package com.growth.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AuthController {

	@RequestMapping(value="/signup")
	public String signup() throws Exception{
		
		return "auth/signup";
	}
	
}
