package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.service.ContestService;

@Controller
public class ContestController {
	
	@Autowired
	private ContestService contestService;
	
	@RequestMapping(value="/contest/contestPage.do")
	public String contestPage(ModelMap model) throws Exception{
		model.addAttribute("contestList",contestService.getContestList());
		return "/contest/contestPage";
	}
	
}
