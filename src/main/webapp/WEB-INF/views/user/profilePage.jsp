<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<style type="text/css">
	.profile-wrap{
		margin:30px 0;
		padding: 40px 30px;
	}
	ul.profile-list {
	    list-style: none;
	    margin: 0;
	    padding: 0 20px;
	}
	
	li.profile-list-item i.fa {
	    margin-right: 10px;
	}
	
	li.profile-list-item {
	    font-size: 14px;
	}
	.profile-img{
		width:100px;
		height:100px;
	}
	.profile-name{
		margin : 10px 0;
	}
	.user-comment-footer{
		margin-top:10px;
	}
	.user-comment-list-item{
		position:relative;
		padding-bottom:10px;
		margin-bottom:15px;
		border-bottom: 1px solid #ddd;
	}
	.user-comment-list-item.r2{
		padding-left:100px;
	}
	.user-comment-desc-list{
    	list-style: none;
    	padding-left:0;
	}
	.user-comment-desc-list > li{
		margin-bottom:5px;
	}
	.desc-name{
		margin:0px;
	}
	.comment-content{
		width:100%;
	}
	
	.comment-body-left{
		position:absolute;
	}
	.comment-body{
		display: inline-block;
	    width: 100%;
	    padding-left: 70px;
	}
	.icon-reply{
	    position: absolute;
	    top: 10px;
	    left: 50px;
	    font-size: 30px;
	}
	.blockquote h5{
		margin:0;
		margin-bottom:10px;
	}
	.blockquote{
		font-size:14px;
	}
	.tag-sm{
		font-size:13px;
	}
	.tag-sm i.fa{
		margin-right:0 !important;
	}
	.profile-list-item label{
		margin-right:15px;
		width: 90px;
    	display: inline-block;
	}
	#btn-timeline-modal{
		position:absolute;
		bottom:3px;
		right:0;
	}
	.timeline dl dd .events .events-object{
	    width: 100px;
 	    box-shadow: 1px 1px 1px #4b4b4b;
	}
	.timeline dl dd .time{
		width:105px;
	    font-size: 13px;
	}
	.profile-media-left >img{
		top: 20px !important;
    	position: absolute;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		loadUserCommentList();
		loadUserTimelineList();
		$("#file").change(loadFile);
	});
	
	function loadFile(event) {
	    var output = $('#output-photo').get(0);
	    output.src = URL.createObjectURL(event.target.files[0]);
    };
    function validateForm(){
		var timelineForm = $("#timeline-form").get(0);
		
		var   title = timelineForm.title,
		    content = timelineForm.content,
		    completeDate = timelineForm.completeDate;
		
		var invalid = [];
		$(".form-group").removeClass("has-error");
		
		if( title.value.trim() == ""  ){
			invalid.push({
				element : "title",
				message : "제목은 필수 입력값입니다."
			});
		}
		if( title.value.length > 300  ){
			invalid.push({
				element : "title",
				message : "제목은 40자 내로 작성해주시기 바랍니다."
			});
		}
		
		if( content.value.trim() == ""   ){
			invalid.push({
				element : "content",
				message : "내용은 필수 입력값입니다."
			});
		} 
		
		if( content.value.length > 300  ){
			invalid.push({
				element : "content",
				message : "내용은 300자 내로 작성해주시기 바랍니다."
			});
		} 
		
		if( completeDate.value.trim() == ""   ){
			invalid.push({
				element : "completeDate",
				message : "완료일자는  필수 입력값입니다."
			});
		} 
		
		if( !isDateFormat(completeDate.value) ){
			invalid.push({
				element : "completeDate",
				message : "날짜 형식으로 입력해주세요"
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
    
    function timelineWrite(){
		if( !validateForm() )
			return ;
		
		var form = $("#timeline-form").get(0);
	 	form.method = "POST",
		form.enctype = "multipart/form-data";
		
		var formData = new FormData(form);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/user/timelineWrite.do",
			type : "POST",
			data : formData,
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(result){
				alert(result.message);		
				if( result.status == 200 ){
					timelineFormClear();
					$("#timeline-modal").modal('hide');
					loadUserTimelineList();
				} 
			}
		}); 
	}
	  
    function timelineFormClear(){
    	var timelineForm = $("#timeline-form").get(0);
    	
    	timelineForm.title.value = "";
    	timelineForm.content.value = "";
    	timelineForm.file.value = "";
    	$("#output-photo").attr('src','');
    }
    
	function loadUserCommentList(){
		var $commentList = $(".user-comment-list");
		$commentList.empty();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/user/userCommentList.do",
			type : "GET",
			data : {
				userId : "${user.email}"
			},
			success : function( result ){
				$commentList.append(result);
			}
		});
	}
	
	function loadUserTimelineList(){
		var $timelineList = $(".timeline-list");
		$timelineList.empty();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/user/timelineList.do",
			type : "GET",
			data : {
				userId : "${user.email}"
			},
			success : function( result ){
				$timelineList.append(result);
			}
		});
	}
	
	function commentReplyWrite( event ){
		commentWrite(null,$(event.currentTarget).serialize());
		event.preventDefault();
	}
		
	function commentWrite( event, formData ){
		var formData = formData || $(event.currentTarget).serialize();
		if( !confirm("댓글 작성을 완료하시겠습니까 ?") )
			return ;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/user/userCommentWrite.do",
			type : "POST",
			data : formData,
			async : false,
			success : function( result ){
				alert(result.message);
				if( result.status == 200 ){
					loadUserCommentList();
				}
			}
		});
		
		if( event )
			event.preventDefault();
	}
	
	function showReplyForm( event ){
		var $target = $(event.currentTarget),
		    $replyForm = $target.siblings(".reply-form-wrap");
		
		if( $replyForm.hasClass("none") ){
			$replyForm.removeClass("none");
		} else {
			$replyForm.find("textarea").focus();
		}
		
		event.preventDefault();
	}
</script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<sec:authentication var="currentUser" property="principal" />
<div class="row">
	<section id="profile" class="col-md-6">
		<div class="profile-wrap media well">
			<div class="profile-img-wrap profile-media-left">
				<img src="${pageContext.request.contextPath }/image.do?id=${user.photo}" alt="" class="circular-square profile-img"/>
			</div>
			<div class="profile-body media-body profile-media">
				<ul class="profile-list">
					<li class="profile-list-item">
						<h4 class="profile-name">${user.gradeNm } ${user.name }</h4>
					</li>
					<li class="profile-list-item">
						<span class="profile-email">
							<i class="fa fa-envelope"></i><label class="hidden-xs" for="">이메일</label>${user.email }
						</span>
					</li>
					<li class="profile-list-item">
						<span class="profile-department">
							<i class="fa fa-briefcase"></i><label class="hidden-xs" for="">소속</label>${user.department }
						</span>
					</li>
					<li class="profile-list-item">
						<span class="profile-favorite">
							<i class="fa fa-star"></i><label class="hidden-xs" for="">관심분야</label>
							<c:forEach items="${userTagList }" var="tagItem" varStatus="status">
								<a href="#" class="tag-sm"><i class="fa fa-hashtag"></i>${tagItem }</a>
								<c:if test="${ !status.last }">,</c:if>
							</c:forEach>
						</span>
							
					</li>
					<sec:authorize access="isAuthenticated()"> 
						<c:if test="${currentUser.email == user.email }">
							<li>
								<a href="/user/profileEditPage.do" class="btn btn-success">프로필 수정</a>
								<a href="/user/privateEditPage.do" class="btn btn-info">개인정보 수정</a>
							</li>
						</c:if>
					</sec:authorize>
				</ul>
			</div>
		</div>
		<div class="profile-desc-wrap">
			<blockquote class="blockquote">
				<h5 class="">소개글</h5>
				<p>${user.introText }</p>
			</blockquote>
			<blockquote class="blockquote">
				<h5 class="">입대전 활동</h5>
				<p>${user.history }</p>
			</blockquote>
			<blockquote class="blockquote">
				<h5 class="">성취목표</h5>
				<p>${user.goal }</p>
			</blockquote>
			
		</div>
		</section>
		<div class="user-comment-wrap col-md-6">
			<form class="user-comment-form" onsubmit="return commentWrite(event);">
				<h4 class="user-comment-header">
					<i class="fa fa-comments"></i>${user.name }님 에게 코멘트 남기기
				</h4>
				<div class="user-comment-body">
					<textarea name="content" id="user-comment" class="form-control" rows="5" placeholder="칭찬, 감사, 질문을 남겨보세요"></textarea>
				</div>
				<div class="user-comment-footer text-right">
					<button type="submit" class="btn btn-danger" id="btn-comment-write"><i class="fa fa-save"></i>작성완료</button>
				</div>
				<input type="hidden" name="userId" value="${user.email }"/>
			</form>
			<div class="user-comment-list">
			
			</div>
	
		</div>
		
	
</div>
<div class="row">
<section id="timeline">
	<div class="section-header">
		<h3 class="page-header text-center"><i class="fa fa-tasks" aria-hidden="true"></i>성과 기록</h3>
		<sec:authorize access="isAuthenticated()"> 
			<c:if test="${currentUser.email == user.email }">
				<button class="btn btn-success" id="btn-timeline-modal" data-toggle="modal" data-target="#timeline-modal">성과 등록</button>	
			</c:if>
		</sec:authorize>
		
	</div>
	<span class="help-block">
			<i class="fa fa-share-alt"></i>군 생활 동안의 자기계발 성과를 하나씩 기록해보세요 
		</span>
	
	
</section>

	<div class="timeline">
		<dl class="timeline-list">
		</dl>
    </div>
</div>

<div class="modal fade" id="timeline-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">성과등록</h4>
      </div>
      <div class="modal-body">
        <form id="timeline-form">
          <div class="form-group">
            <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요">
          </div>
          <div class="form-group">
            <textarea class="form-control" id="content" name="content" placeholder="내용을 입력해주세요" rows="4"></textarea>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" name="completeDate" id="completeDate" placeholder="완료일자를 입력해주세요   ex)2017-05-10">
          </div>
          <div class="form-group">
            <input type="file" accept="image/*" class="form-control" id="file" name="file" >
		      <div class="thumbnail">
		      	<img class="img-rounded" id="output-photo"/>
		      </div>
            <span class="help-block">
            	※ 성과의 썸네일을 입력해주세요
            </span>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" id="btn-timeline-write" onclick="timelineWrite();">작성완료</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="../include/footer.jsp" %>