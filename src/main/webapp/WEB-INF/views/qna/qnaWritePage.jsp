<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	#qna-form{
		margin:20px;
	}
	.tag{
		margin-right:10px;
	}
	.fa-hashtag{
		margin-right:3px;
	}
	.tag-remove{
		margin-left:3px;
		cursor:pointer;
	}
</style>
<%@ include file="../include/headTag.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		$("#summernote").summernote({
			height:450
		});	
		$("#tag").keypress(function(e){
			
			if( e.keyCode == 13 ){
				addTagList( $(this).val() );
				$(this).val('');
			}
		});
		
		$(document).on('click', ".tag-remove", removeTagList);
		$("#btn-list").click(function(){
			location.href="${pageContext.request.contextPath}/qna/qnaPage.do";
		});
	});
	
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
    function preSubmit(event){
    	$("#qna-content").html($('#summernote').summernote('code'));
    	if( !confirm("질문작성을 완료하시겠습니까?") ){
    		event.preventDefault();
			return;
		}
    	if( !validateForm() ){
    		event.preventDefault();
    		return;
    	}
    		
    }
    
    function getRemainPoint(){
    	var point = -1;
    	$.ajax({
    		url : "/auth/remainPoint.do",
    		type : 'POST',
    		async : false,
    		success : function(result){
    			if( result.status == 200 ){
    				point = result.data;
    			} else {
    				alert(result.message);
    			}
    		}
    	});
    	return point;
    }
    function validateForm(){
		var qnaForm = $("#qna-form").get(0);
		
		var title    = qnaForm.title,
			content  = qnaForm.content,
			betPoint = qnaForm.betPoint;
		
		var remainPoint ;
		
		var invalid = [];
		$(".form-group").removeClass("has-error");
		
		if( title.value.trim() == "" || title.value.length == 0 ){
			invalid.push({
				element : "title",
				message : "제목은 필수 입력값입니다."
			});
		} 
		
		if( title.value.length >= 200 ){
			invalid.push({
				element : "title",
				message : "제목은 200자 이하로 입력해주십시오"
			});
		}
		
		if( betPoint.value != null && isNaN(betPoint.value) ){
			invalid.push({
				element : "betPoint",
				message : "포인트는 숫자만 입력해주세요"
			});
		}
		
		remainPoint = getRemainPoint();
		
		if( betPoint.value != null ){
			if( betPoint.value > remainPoint ){
				invalid.push({
					element : "betPoint",
					message : "최대 " + remainPoint + "까지 지정 가능합니다."
				});
			}	
		}
		
		
		
		if( invalid.length == 0 ){
			return true;
		} else {
			$("#" + invalid[0].element + "-error" ).text(invalid[0].message);	
			$("#" + invalid[0].element).parents(".form-group").addClass("has-error");
			return false;
		}
		
    }

</script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
	
	<section class="section" id="qna-write">
		<div class="section-header">
			<h2 class="page-header"><i class="fa fa-bookmark" aria-hidden="true"></i>질문 작성</h2>
		</div>
				<form class="form-horizontal well" id="qna-form" onsubmit="return preSubmit(event)" 
				enctype="multipart/form-data" action="${pageContext.request.contextPath}/qna/qnaWrite.do" method="POST">
				  <div class="form-group">
				    <label for="email" class="col-sm-2 control-label">제목</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				    		<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="title" id="title-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-2 control-label">내용</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				    		<div id="summernote"></div>
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="content" id="content-error"></label>
				      		<textarea id="qna-content" name="content" class="none"></textarea>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="passwordCheck" class="col-sm-2 control-label">태그</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				      		<input type="text" class="form-control" id="tag" placeholder="태그를 입력하세요   ex) 자격증 , 운동 ">
				      		<div class="tag-list none">
				      		</div>
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="tag" id="tag-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="betPoint" class="col-sm-2 control-label">채택시 포인트</label>
				    <div class="col-sm-9">
				    	<div class="input-wrap">
				    		<input type="number" class="form-control" id="betPoint" name="betPoint" placeholder="채택시 제공할 포인트을 입력하세요">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="betPoint" id="betPoint-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <p class="text-center">
				    	<input type="button" class="btn btn-primary" id="btn-list" value="목록으로" />
				    	<input type=submit class="btn btn-danger" id="btn-write" value="작성완료" />
				    </p>
				  </div>
			</form>
		
	</section>

<%@ include file="../include/footer.jsp" %>