<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<style type="text/css">
	.post-wrap{
		margin: 0 20px;
		padding : 20px 50px;
	}
	.user-profile{
	    overflow: hidden;
	    position: relative;
	    margin-top: 45px !important;
	    border-top: 1px solid #ddd;
	    border-bottom: 1px solid #ddd;
	    padding-top: 20px;
	    padding-bottom: 20px;
	}
	.user-profile img{
		width:100px;
		height:100px;
	}
	.user-profile .media-body{
		position:relative;
	}
	.user-name{
		margin-left:20px;
	}
	.user-profile .help-block{
		margin-left : 25px;
	}
	i.fa{
		margin-right:5px;
	}
	.help-block span{
		margin-right:10px;
	}
	.right-panel{
		position:absolute;
		top:50px;
		right:50px;
	}
	.comment-header{
		margin-top:50px;
	}
	#comment{
		height : 100px;
	}
	.comment-footer{
		margin-top:15px;
		text-align:right;
	}
	.comment-list{
	    list-style: none;
	    padding-left:0;
	    
	}
	.comment-list-item{
		margin-top:20px;
		padding-top:10px;
		border-top:1px solid #ddd;
	}
	
		/*태블릿 및 PC*/
	@media( max-width : 767px ){
	     .right-panel{
			top:10px;
			right:0;
		}
	}
	
</style>
<script type="text/javascript">
	$( document ).ready(function(){
		var $btnLike         = $("#btn-like"),
		    $btnLikeCancel   = $("#btn-like-cancel"),
		    $btnCommentWrite = $("#btn-comment-write");
		loadPostCommentList();
		$btnLike
			.click(function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/post/postLike.do",
					type : "POST",
					data : {
						postId : '${post.postId}'
					},
					success : function( result ){
						if( result.status == 200 ){
							$btnLike.addClass("none");
							$btnLikeCancel.removeClass("none");
						} else {
							alert(result.message);
						}
					}
				});
			});
		
		$btnLikeCancel
			.click(function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/post/postLikeCancel.do",
					type : "POST",
					data : {
						postId : '${post.postId}'
					},
					success : function( result ){
						if( result.status == 200 ){
							$btnLike.removeClass("none");
							$btnLikeCancel.addClass("none");
						} else {
							alert(result.message);
						}
					}
				});
			});
		
		$btnCommentWrite
			.click(function(){
				if( !confirm("댓글 작성을 완료하시겠습니까 ?") )
					return ;
				
				$.ajax({
					url : "${pageContext.request.contextPath}/post/postCommentWrite.do",
					type : "POST",
					data : {
						postId : "${post.postId}",
						content : $('#comment').val()
					},
					success : function( result ){
						alert(result.message);
						if( result.status == 200 ){
							loadPostCommentList();						
						}
					}
				});
			});
		
		function loadPostCommentList(){
			var $commentList = $(".comment-list");
			$commentList.empty();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/post/postCommentList.do",
				type : "GET",
				data : {
					postId : "${post.postId}"
				},
				success : function( result ){
					$commentList.append(result);
				}
			});
		}
			
	});
</script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<section class="section" id="post-detail">
	<div class="section-header">
		<h4 class="page-header"><i class="fa fa-bookmark" aria-hidden="true"></i>${ post.title}</h4>
		<div class="section-header-right">
			<a href="${pageContext.request.contextPath }/post/postPage.do" id="refresh-btn" class="btn btn-primary visible-md visible-lg" >
			<i class="fa fa-list"></i>목록으로</a>
		</div>
	</div>
	<div class="section-body">
		<div class="post-wrap well">
			<div class="post-body">
				${post.content }
			</div>
			<div class="post-footer">
				<div class="user-profile media">
					<a href="#" class="profile-media-left">
						<img src="${pageContext.request.contextPath }/image.do?id=${post.photo}" alt="" class="circular-square"/>
					</a>
					<div class="media-body profile-media">
						<h5 class="user-name">${post.name }</h5>
						<p class="help-block">
							<span class="department">
								<i class="fa fa-briefcase" aria-hidden="true"></i>${post.department }
							</span><br>
							<span class="reg-date">
								<i class="fa fa-clock-o"></i> ${post.regDate }
							</span><br/>
							<span class="hit-cnt"><i class="fa fa-eye"></i>조회수 ${post.hitCnt }</span>
							<span class="like-cnt"><i class="fa fa-heart"></i>좋아요 ${post.likeCnt }</span>
							<span class="comment-cnt"><i class="fa fa-comment"></i>댓글수  ${post.commentCnt }</span>
						</p>	
					</div>
					<div class="right-panel">
						<sec:authorize access="isAuthenticated()">
							<button class="btn btn-primary <c:if test='${post.likeYn > 0 }'>none </c:if>" id="btn-like" ><i class="fa fa-thumbs-up" aria-hidden="true"></i>좋아요</button>
							<button class="btn btn-danger <c:if test='${post.likeYn == 0 }'>none </c:if>" id="btn-like-cancel" ><i class="fa fa-thumbs-down" aria-hidden="true"></i>좋아요 취소</button>
						</sec:authorize>
					</div>
				</div>
				
				<div class="comment-wrap">
					<sec:authorize access="isAuthenticated()">
						<div class="comment-header">
							<h5 class="comment-heading"><i class="fa fa-pencil"></i>댓글 작성</h5>
						</div>
						<div class="comment-body">
							<form>
								<textarea name="comment" id="comment" class="form-control" placeholder="댓글을 작성해보세요"></textarea>
							</form>
						</div>
						<div class="comment-footer">
								<button class="btn btn-danger" id="btn-comment-write"><i class="fa fa-save"></i>작성완료</button>
						</div>
					</sec:authorize>
					<sec:authorize access="!isAuthenticated()">
						<span class="help-block">
							※ 로그인 하시면 댓글을 작성하실 수 있습니다. 
						</span>
					</sec:authorize>
				</div>
				
				<ul class="comment-list">
					
				</ul>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>