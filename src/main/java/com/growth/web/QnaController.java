package com.growth.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.growth.domain.AjaxResult;
import com.growth.domain.QnaVO;
import com.growth.domain.QnaVO;
import com.growth.domain.UserVO;
import com.growth.service.QnaService;

@Controller
public class QnaController {

	@Autowired
	private QnaService qnaService;
	@RequestMapping(value="/qna/qnaPage.do")
	public String qnaPage( ModelMap model ) throws Exception{
		
		model.addAttribute("hashTagList", qnaService.selectPopularHashTag() );
		return "/qna/qnaPage";
	}
	
	@RequestMapping(value="/qna/qnaWritePage.do")
	public String qnaWritePage(ModelMap model) throws Exception{
		
		return "/qna/qnaWritePage";
	}
	
	
	@RequestMapping(value="/qna/qnaWrite.do",method=RequestMethod.POST)
	public String qnaWrite(QnaVO qnaVO,
							@AuthenticationPrincipal UserVO currentUser,
							ModelMap model) throws Exception{
		qnaVO.setWriterId(currentUser.getEmail());
		qnaService.insertQna(qnaVO);
		
		model.addAttribute("message","질문 작성이 완료되었습니다.");
		model.addAttribute("url","/qna/qnaPage.do");
		//TODO: 포스트 작성흐 상세페이지로 이동 하도록 수정 
		return "/common/message";
	}
	
	@RequestMapping(value="/qna/qnaList.do")
	public String qnaList(QnaVO qnaVO,
						 ModelMap model) throws Exception{
		model.addAttribute("qnaList", qnaService.selectQnaList(qnaVO));
		return "/qna/qnaList";
	}
	
	@RequestMapping(value="/qna/qnaDetailPage.do")
	public String qnaDetailPage(QnaVO qnaVO
							 , ModelMap model) throws Exception{
		QnaVO qnaDetail = null;
		qnaService.updateHitCount(qnaVO);
		qnaDetail = qnaService.selectQnaOne(qnaVO);
		model.addAttribute("qna", qnaDetail);
		model.addAttribute("currentPage","qna");
		return "/qna/qnaDetailPage";
	}
	
	
	@RequestMapping(value="/qna/qnaCommentList.do")
	public String qnaCommentList(QnaVO qnaVO,
						 ModelMap model) throws Exception{
		model.addAttribute("qnaCommentList", qnaService.selectQnaComments(qnaVO));
		return "/qna/qnaCommentList";
	}
	
	@RequestMapping(value="/qna/qnaLike.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult qnaLike( QnaVO qnaVO,
						@AuthenticationPrincipal UserVO currentUser) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			qnaVO.setWriterId(currentUser.getEmail());
			if( qnaService.selectQnaLikeCnt(qnaVO) > 0 ){
				result.setStatus(AjaxResult.FAIL)
						.setMessage("이미 좋아요를 눌렀습니다.");
			} else {
				qnaService.updateLikeCount(qnaVO);
				result.setStatus(AjaxResult.SUCCESS);
			}
		} catch (Exception e){
			result.setStatus(AjaxResult.EXCEPTION)
					.setMessage("예기치 못한 오류가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value="/qna/qnaLikeCancel.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult qnaLikeCancel( QnaVO qnaVO,
						@AuthenticationPrincipal UserVO currentUser) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			qnaVO.setWriterId(currentUser.getEmail());
			if( qnaService.selectQnaLikeCnt(qnaVO) == 0 ){
				result.setStatus(AjaxResult.FAIL)
						.setMessage("좋아요를 누른적이 없습니다.");
			} else {
				qnaService.updateDislike(qnaVO);
				result.setStatus(AjaxResult.SUCCESS);
			}
		} catch (Exception e){
			result.setStatus(AjaxResult.EXCEPTION)
					.setMessage("예기치 못한 오류가 발생하였습니다.");
		}
		
		return result;
	}
	
	@RequestMapping(value="/qna/qnaCommentWrite.do", method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult qnaCommentWrite( QnaVO qnaVO,
			@AuthenticationPrincipal UserVO currentUser) throws Exception{
		AjaxResult result = new AjaxResult();
		
		try{
			qnaVO.setWriterId(currentUser.getEmail());
			qnaService.insertQnaComment(qnaVO);
			result.setStatus(AjaxResult.SUCCESS)
				  .setMessage("댓글작성이 완료되었습니다.");
		} catch (Exception e){
		result.setStatus(AjaxResult.EXCEPTION)
				.setMessage("예기치 못한 오류가 발생하였습니다.");
		}
		
		return result;
	}
	
	
}
