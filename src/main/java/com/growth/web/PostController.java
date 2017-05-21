package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		PostVO postDetail = null;
		postService.updateHitCount(postVO);
		postDetail = postService.selectPostOne(postVO);
		model.addAttribute("post", postDetail);
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
	
	@RequestMapping(value="/post/postCommentList.do")
	public String postCommentList(PostVO postVO,
						 ModelMap model) throws Exception{
		model.addAttribute("postCommentList", postService.selectPostComments(postVO));
		return "/post/postCommentList";
	}
	
	@RequestMapping(value="/post/postLike.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult postLike( PostVO postVO,
						@AuthenticationPrincipal UserVO currentUser) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			postVO.setWriterId(currentUser.getEmail());
			if( postService.selectPostLikeCnt(postVO) > 0 ){
				result.setStatus(AjaxResult.FAIL)
						.setMessage("이미 좋아요를 눌렀습니다.");
			} else {
				postService.updateLikeCount(postVO);
				result.setStatus(AjaxResult.SUCCESS);
			}
		} catch (Exception e){
			result.setStatus(AjaxResult.EXCEPTION)
					.setMessage("예기치 못한 오류가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value="/post/postLikeCancel.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult postLikeCancel( PostVO postVO,
						@AuthenticationPrincipal UserVO currentUser) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			postVO.setWriterId(currentUser.getEmail());
			if( postService.selectPostLikeCnt(postVO) == 0 ){
				result.setStatus(AjaxResult.FAIL)
						.setMessage("좋아요를 누른적이 없습니다.");
			} else {
				postService.updateDislike(postVO);
				result.setStatus(AjaxResult.SUCCESS);
			}
		} catch (Exception e){
			result.setStatus(AjaxResult.EXCEPTION)
					.setMessage("예기치 못한 오류가 발생하였습니다.");
		}
		
		return result;
	}
	
	@RequestMapping(value="/post/postCommentWrite.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult postCommentWrite( PostVO postVO,
			@AuthenticationPrincipal UserVO currentUser) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			postVO.setWriterId(currentUser.getEmail());
			postService.insertPostComment(postVO);
			result.setStatus(AjaxResult.SUCCESS)
				  .setMessage("댓글작성이 완료되었습니다.");
		} catch (Exception e){
		result.setStatus(AjaxResult.EXCEPTION)
				.setMessage("예기치 못한 오류가 발생하였습니다.");
		}
		
		return result;
	}
}
