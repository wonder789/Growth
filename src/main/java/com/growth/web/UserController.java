package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.growth.domain.AjaxResult;
import com.growth.domain.UserCommentVO;
import com.growth.domain.UserTimelineVO;
import com.growth.domain.UserVO;
import com.growth.service.CodeService;
import com.growth.service.UserService;

@Controller
public class UserController {

	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CodeService codeService;
	
	
	@RequestMapping(value="/user/profilePage.do")
	public String profilePage(ModelMap model,
							  UserVO userVO,
							  @AuthenticationPrincipal UserVO currentUser) throws Exception{
		
		if( userVO.getEmail() == null || "".equals(userVO.getEmail()) ){
			if( currentUser == null ){
				model.addAttribute("message","잘못된 접근입니다");
				model.addAttribute("url", "/");
				return "/common/message";
			} else {
				userVO.setEmail(currentUser.getEmail());
			}
			
		}
		
		model.addAttribute("user", userService.findUser(userVO));
		model.addAttribute("userTagList", userService.selectUserTags(userVO));
		
		return "/user/profilePage";
	}
	
	@RequestMapping(value="/user/profileEditPage.do")
	public String profileEditPage(ModelMap model,
							  UserVO userVO,
							  @AuthenticationPrincipal UserVO currentUser) throws Exception{
		
		//업데이트된 유저정보 적용
		model.addAttribute("user", userService.findUser(currentUser));
		model.addAttribute("userTagList", userService.selectUserTags(currentUser));
		
		return "/user/profileEditPage";
	}
	
	
	@RequestMapping(value="/user/profileEdit.do", method=RequestMethod.POST)
	public String profileEdit(ModelMap model, 
						@AuthenticationPrincipal UserVO currentUser,
						UserVO userVO) throws Exception{
		userVO.setEmail(currentUser.getEmail());
		userService.updateUserProfile(userVO);
		
		model.addAttribute("message","프로필이 수정되었습니다.");
		model.addAttribute("url","/user/profilePage.do");
		
		return "/common/message";
	}
	
	@RequestMapping(value="/user/userCommentList.do")
	public String userCommentList(UserCommentVO commentVO,
			     @AuthenticationPrincipal UserVO currentUser,
						 ModelMap model) throws Exception{
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("userCommentList", userService.selectUserCommentList(commentVO));
		return "/user/userCommentList";
	}
	
	@RequestMapping(value="/user/timelineList.do")
	public String userCommentList(UserTimelineVO timelineVO,
						 ModelMap model) throws Exception{
		model.addAttribute("timelineList", userService.selectUserTimelineList(timelineVO));
		return "/user/timelineList";
	}
	
	
	@RequestMapping(value="/user/userCommentWrite.do" , method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult insertUserComment( 
					UserCommentVO commentVO,
					@AuthenticationPrincipal UserVO currentUser
							) throws Exception{
	AjaxResult result = new AjaxResult();
		
		try{
			commentVO.setWriterId(currentUser.getEmail());
			userService.insertUserComment(commentVO);
			result.setStatus(AjaxResult.SUCCESS)
				  .setMessage("작성이 완료되었습니다.");
		} catch (Exception e){
		result.setStatus(AjaxResult.EXCEPTION)
				.setMessage("예기치 못한 오류가 발생하였습니다.");
		}
		
		return result;
	}
	
	@RequestMapping(value="/user/timelineWrite.do" , method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult timelineWrite( 
					UserTimelineVO timelineVO,
					@AuthenticationPrincipal UserVO currentUser
							) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			timelineVO.setUserId(currentUser.getEmail());
			userService.insertUserTimeline(timelineVO);
			result.setStatus(AjaxResult.SUCCESS)
				   .setMessage("작성이 완료되었습니다.");
		} catch (Exception e){
			result.setStatus(AjaxResult.EXCEPTION)
					.setMessage("예기치 못한 오류가 발생하였습니다.");
		}
		
		return result;
	}
}
