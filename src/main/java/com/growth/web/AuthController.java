package com.growth.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
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
	
	
	@RequestMapping(value="/auth/signupPage.do")
	public String signupPage(ModelMap model) throws Exception{
		model.addAttribute("currentPage","signup");
		model.addAttribute("gradeCodeList", codeService.selectCodeByPcode("UG01"));
		model.addAttribute("userTypeCodeList", codeService.selectCodeByPcode("UT01"));
		
		return "auth/signupPage";
	}
	
	@RequestMapping(value="/auth/loginPage.do")
	public String loginPage(ModelMap model) throws Exception{
		model.addAttribute("currentPage","login");
		return "auth/loginPage";
	}
	
	
	
	@RequestMapping(value="/auth/signup.do", method = RequestMethod.POST)
	@ResponseBody
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
				result.setStatus(AjaxResult.SUCCESS)
					  .setMessage("회원가입이 완료되었습니다.");
			} catch ( Exception e ){
				result.setStatus(AjaxResult.EXCEPTION)
				   .setMessage(e.getMessage());
			}
		}
		
		
		return result;
	}
	
	@RequestMapping(value="/auth/remainPoint.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult remainPoint(
			@AuthenticationPrincipal UserVO currentUser
			) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			UserVO userVO = userService.findUser(currentUser);
			result.setData(userVO.getPoint())
					.setStatus(AjaxResult.SUCCESS);
		} catch( Exception e){
			result.setStatus(AjaxResult.EXCEPTION)
			   .setMessage(e.getMessage());
		}
		return result;
	}
}
