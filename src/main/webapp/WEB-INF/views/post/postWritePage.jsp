<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	#post-form{
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
		$("#file").change(loadFile);
		$("#tag").keypress(function(e){
			
			if( e.keyCode == 13 ){
				addTagList( $(this).val() );
				$(this).val('');
			}
		});
		
		$(document).on('click', ".tag-remove", removeTagList);
		$("#btn-list").click(function(){
			location.href="${pageContext.request.contextPath}/post/postPage.do";
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
	
	function loadFile(event) {
	    var output = $('#output-photo').get(0);
	    output.src = URL.createObjectURL(event.target.files[0]);
    };
    
    function preSubmit(event){
    	$("#post-content").html($('#summernote').summernote('code'));
    	
    	if( !validateForm() ){
    		event.preventDefault();
    		return;
    	}
    		
    }
    function validateForm(){
		var postForm = $("#post-form").get(0);
		
		var 		title = postForm.title,
				  content = postForm.content;
		
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
	
	<section class="section" id="post-write">
		<div class="section-header">
			<h2 class="page-header"><i class="fa fa-bookmark" aria-hidden="true"></i>포스트 작성</h2>
		</div>
				<form class="form-horizontal well" id="post-form" onsubmit="return preSubmit(event)" 
				enctype="multipart/form-data" action="${pageContext.request.contextPath}/post/postWrite.do" method="POST">
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
				      		<textarea id="post-content" name="content" class="none"></textarea>
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
				    <label for="passwordCheck" class="col-sm-2 control-label">대표사진</label>
				    <div class="col-sm-9">
				      <input type="file" accept="image/*" class="form-control" id="file" name="file" >
				      <div class="thumbnail">
				      	<img class="img-rounded" id="output-photo"/>
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