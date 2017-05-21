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
</style>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<section class="section" id="post-detail">
	<div class="section-header">
		<h4 class="page-header"><i class="fa fa-bookmark" aria-hidden="true"></i>${ post.title}</h4>
		<div class="section-header-right">
			<a href="${pageContext.request.contextPath }/post/postPage.do" id="refresh-btn" class="btn btn-primary" >
			<i class="fa fa-list"></i>목록으로</a>
		</div>
	</div>
	<div class="section-body">
		<div class="post-wrap well">
			<div class="post-body">
				${post.content }
			</div>
			<div class="post-footer">
				<div class="comment-wrap">
					<div class="comment-header">
					
					</div>
					<div class="comment-body">
					
					</div>
					<div class="comment-footer">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>