package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.growth.domain.AjaxResult;
import com.growth.domain.UserVO;
import com.growth.service.CodeService;
import com.growth.service.UserService;

@Controller
public class AuthController {

	@Autowired
	private CodeService codeService;
	
	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value="/signupPage.do")
	public String signupPage(ModelMap model) throws Exception{
		
		model.addAttribute("gradeCodeList", codeService.selectCodeByPcode("UG01"));
		model.addAttribute("userTypeCodeList", codeService.selectCodeByPcode("UT01"));
		
		return "auth/signupPage";
	}
	
	@RequestMapping(value="/loginPage.do")
	public String loginPage(ModelMap model) throws Exception{
		
		return "auth/loginPage";
	}
	
	
	@RequestMapping(value="/signup.do", method = RequestMethod.POST)
	public AjaxResult signup(UserVO userVO, ModelMap model) throws Exception{
		AjaxResult result = new AjaxResult();
		UserVO searchUser = userService.findUser(userVO);
		
		if( searchUser != null ){
			result.setStatus(AjaxResult.FAIL)
				   .setMessage("이미 등록된 이메일 입니다.");
		} else {
			//ajax 요청이라 따로 예외처리안할시 클라이언트 반응안함
			try{
				userService.userSignup(userVO);
			} catch ( Exception e ){
				result.setStatus(AjaxResult.EXCEPTION)
				   .setMessage(e.getMessage());
			}
		}
		
		
		return result;
	}
}
