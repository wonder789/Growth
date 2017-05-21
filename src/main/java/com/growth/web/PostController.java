package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.growth.domain.AjaxResult;
import com.growth.domain.PostVO;
import com.growth.domain.UserVO;
import com.growth.service.PostService;

@Controller
public class PostController {

	@Autowired
	private PostService postService;
	
	@ModelAttribute
	public String currentPage(){
		return "post";
	}

	@RequestMapping(value="/post/postPage.do")
	public String postPage(ModelMap model) throws Exception{
		model.addAttribute("hashTagList", postService.selectPopularHashTag() );
		
		return "/post/postPage";
	}


	@RequestMapping(value="/post/postWritePage.do")
	public String postWritePage(ModelMap model) throws Exception{
		
		return "/post/postWritePage";
	}
	
	@RequestMapping(value="/post/postDetailPage.do")
	public String postDetailPage(PostVO postVO
							 , ModelMap model) throws Exception{
		model.addAttribute("post",postService.selectPostOne(postVO));
		
		return "/post/postDetailPage";
	}
	
	@RequestMapping(value="/post/postWrite.do",method=RequestMethod.POST)
	public String postWrite(PostVO postVO,
							@AuthenticationPrincipal UserVO currentUser,
							ModelMap model) throws Exception{
		postVO.setWriterId(currentUser.getEmail());
		postService.insertPost(postVO);
		
		//TODO: 포스트 작성흐 상세페이지로 이동 하도록 수정 
		return "redirect:/post/postPage.do";
		
	}
	
	
	@RequestMapping(value="/post/postList.do")
	public String postList(PostVO postVO,
						 ModelMap model) throws Exception{
		model.addAttribute("postList", postService.selectPostList(postVO));
		return "/post/postList";
	}
	
}
