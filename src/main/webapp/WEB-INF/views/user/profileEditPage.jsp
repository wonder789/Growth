<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
	
		$("#tag").keypress(function(e){
			
			if( e.keyCode == 13 ){
				addTagList( $(this).val() );
				$(this).val('');
			}
			e.preventDefault();
		});
		
		$(document).on('click', ".tag-remove", removeTagList);
	});
	

	
	function validateForm(){
		var profileForm = $("#profile-form").get(0);
		
		var   introText = profileForm.introText,
				   goal = profileForm.goal,
		    	history = profileForm.history;
		
		var invalid = [];
		$(".form-group").removeClass("has-error");
		
		if( introText.value.length > 300  ){
			invalid.push({
				element : "introText",
				message : "소개글은 300자 내로 작성해주시기 바랍니다."
			});
		}
		
		if( goal.value.length > 300  ){
			invalid.push({
				element : "introText",
				message : "성취목표는은 300자 내로 작성해주시기 바랍니다."
			});
		} 
		
		if( history.value.length > 300  ){
			invalid.push({
				element : "introText",
				message : "입대전활동은 300자 내로 작성해주시기 바랍니다."
			});
		} 
		
		
		
		
		if( invalid.length == 0 ){
			return true;
		} else {
			$("#" + invalid[0].element + "-error" ).text(invalid[0].message);	
			$("#" + invalid[0].element).parents(".form-group").addClass("has-error");
			return false;
		}
		
	}
	
	function profileEdit(target){
		if( !validateForm() )
			return false;
		
		if( confirm("저장하시겠습니까?") ){
			this.submit();
		}
		
		return false;
	}
	
	function removeTagList(event){
		var $tagList = $(".tag-list");
		var $code = null;
		console.log($(this));
		$(this).parents(".tag").remove();
		
		$code = $tagList.find(".tag");
		
		if( $code.size() == 0 ){
			$tagList.addClass("none");
		}
	}
	
	function addTagList( tagName ){
		var $tagList = $(".tag-list");
		var $code    = null;
		var codeTemplate = "<code class=\"tag\"><i class=\"fa fa-hashtag\" aria-hidden=\"true\"></i>{{tagName}}" + 
			 				"<i class=\"fa fa-remove tag-remove\" aria-hidden=\"true\"/>" + 
							"<input type=\"hidden\" name=\"tag\" value=\"{{tagName}}\"/></code>";
		
		$tagList.append(codeTemplate.replace(/{{tagName}}/gi,tagName));
		
		$code = $tagList.find(".tag");
		if( $code.size() == 0 ){
			$tagList.addClass("none");
		} else if( $code.size() > 0 ){
			$tagList.removeClass("none");
		}
		
		//TODO: 같은이름 태그가 존재하는지 확인
		
	}
</script>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	
	<section class="section" id="signup">
		<div class="row">
			<div class="col-md-8 col-md-pull-2 col-md-push-2 col-sm-8 col-sm-pull-2 col-sm-push-2">
				<form class="form-horizontal well" id="profile-form" action="/user/profileEdit.do" method="POST" onsubmit="return profileEdit(this);">
					 <div class="form-header">
				  	<h5 class="text-center logo-desc-heading">프로필 수정 </h5>
				  </div>
				   <div class="form-group">
				    <label for="introText" class="col-sm-2 control-label">소개글</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				      		<textarea class="form-control" id="introText" name="introText" placeholder="소개글을 입력해주세요 " rows="6">${user.orgIntroText }</textarea>
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="introText" id="introText-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="history" class="col-sm-2 control-label">입대전 활동</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				      		<textarea class="form-control" id="history" name="history" placeholder="입대전 어떤 활동을 했는지 적어보세요   ex) 치킨집알바 " rows="6">${user.orgHistory }</textarea>
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="history" id="history-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="goal" class="col-sm-2 control-label">성취목표</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				      		<textarea class="form-control" id="goal" name="goal" placeholder="성취목표를 입력해주세요  ex)자격증 취득 " rows="6">${user.orgGoal }</textarea>
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="goal" id="goal-error"></label>
				    	</div>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="passwordCheck" class="col-sm-2 control-label">관심분야</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				      		<input type="text" class="form-control" id="tag" placeholder="관심분야를 입력하세요   ex) 자격증 , 운동 ">
				      		<div class="tag-list <c:if test='${fn:length(userTagList) == 0}'>none</c:if>">
				      			<c:forEach items="${userTagList }" var="tagItem">
				      				<code class="tag">
					      				<i class="fa fa-hashtag" aria-hidden="true"></i>${tagItem }
					      				<i class="fa fa-remove tag-remove" aria-hidden="true"></i>
					      				<input type="hidden" name="tag" value="${tagItem }">
			      					</code>
				      			</c:forEach>
				      		</div>
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="tag" id="tag-error"></label>
				    	</div>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <p class="text-center">
				    	<a class="btn btn-primary" href="/user/profilePage.do">취소</a>
				    	<button class="btn btn-danger" id="signup-btn" >저장</button>
				    </p>
				  </div>
			</form>
			</div>
			
		</div>
	</section>
	
<%@ include file="../include/footer.jsp" %>