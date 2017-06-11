<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<style type="text/css">
	.qna-wrap{
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
	}
	.comment-list-item{
		margin-top:20px;
		padding-top:10px;
		border-top:1px solid #ddd;
	}
	.user-img-sm{
		width:50px;
		height:50px;
	}
		/*태블릿 및 PC*/
	@media( max-width : 767px ){
	     .right-panel{
			top:10px;
			right:0;
		}
	}
	.media-left{
	    margin-bottom: 10px;
	}
	.media-body{
		display:block;
		width:100%;
	}
</style>
<script type="text/javascript">
	$( document ).ready(function(){
		var $btnLike         = $("#btn-like"),
		    $btnLikeCancel   = $("#btn-like-cancel"),
		    $btnCommentWrite = $("#btn-comment-write");
		loadQnaCommentList();

		$(document).on("click",".btn-choose",qnaSelectAnswer);
		$btnLike
			.click(function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/qna/qnaLike.do",
					type : "POST",
					data : {
						qnaId : '${qna.qnaId}'
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
					url : "${pageContext.request.contextPath}/qna/qnaLikeCancel.do",
					type : "POST",
					data : {
						qnaId : '${qna.qnaId}'
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
					url : "${pageContext.request.contextPath}/qna/qnaCommentWrite.do",
					type : "POST",
					data : {
						qnaId : "${qna.qnaId}",
						content : $('#comment').val()
					},
					success : function( result ){
						alert(result.message);
						if( result.status == 200 ){
							loadQnaCommentList();		
							$('#comment').val('');
						}
					}
				});
			});
		
		function loadQnaCommentList(){
			var $commentList = $(".comment-list");
			$commentList.empty();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/qna/qnaCommentList.do",
				type : "GET",
				data : {
					qnaId : "${qna.qnaId}"
				},
				success : function( result ){
					$commentList.append(result);
				}
			});
		}
		
		
		function qnaSelectAnswer(){
			if( !confirm("채택하시겠습니까?") )
				return ;
			
			$.ajax({
				url : "${pageContext.request.contextPath}/qna/qnaSelectAnswer.do",
				type : "POST",
				data : $(this).parents(".media-body").find(".choose-form").serialize(),
				success : function( result ){
					alert(result.message);
					if( result.status == 200 ){
						loadQnaCommentList();						
					}
				}
			});
			
		}
	});
</script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<section class="section" id="qna-detail">
	<div class="section-header">
		<h4 class="page-header"><i class="fa fa-question" aria-hidden="true"></i>${ qna.title}</h4>
		<div class="section-header-right">
			<a href="${pageContext.request.contextPath }/qna/qnaPage.do" id="refresh-btn" class="btn btn-primary" >
			<i class="fa fa-list"></i>목록으로</a>
		</div>
	</div>
	<div class="section-body">
		<div class="qna-wrap well">
			<div class="qna-body">
				${qna.content }
			</div>
			<div class="qna-footer">
				<div class="user-profile media">
					<a href="#" class="pull-left">
						<img src="${pageContext.request.contextPath }/image.do?id=${qna.photo}" alt="" class="circular-square"/>
					</a>
					<div class="media-body">
						<h5 class="user-name">${qna.name }</h5>
						<p class="help-block">
							<span class="department">
								<i class="fa fa-briefcase" aria-hidden="true"></i>${qna.department }
							</span><br>
							<span class="reg-date">
								<i class="fa fa-clock-o"></i> ${qna.regDate }
							</span><br/>
							<span class="hit-cnt"><i class="fa fa-eye"></i>조회수 ${qna.hitCnt }</span>
							<span class="like-cnt"><i class="fa fa-heart"></i>좋아요 ${qna.likeCnt }</span>
							<span class="comment-cnt"><i class="fa fa-comment"></i>댓글수  ${qna.commentCnt }</span>
							<span class="bet-point"><i class="fa fa-gift" aria-hidden="true"></i>채택시 포인트  ${qna.betPoint }P</span>
						</p>	
					</div>
					<div class="right-panel">
						<sec:authorize access="isAuthenticated()">
							<button class="btn btn-primary <c:if test='${qna.likeYn > 0 }'>none </c:if>" id="btn-like" ><i class="fa fa-thumbs-up" aria-hidden="true"></i>좋아요</button>
							<button class="btn btn-danger <c:if test='${qna.likeYn == 0 }'>none </c:if>" id="btn-like-cancel" ><i class="fa fa-thumbs-down" aria-hidden="true"></i>좋아요 취소</button>
						</sec:authorize>
					</div>
				</div>
				<div class="comment-wrap">
					<div class="comment-header">
						<h5 class="comment-heading"><i class="fa fa-pencil"></i>답변 작성</h5>
					</div>
					<div class="comment-body">
						<form>
							<textarea name="comment" id="comment" class="form-control" placeholder="답변을 작성해보세요"></textarea>
						</form>
					</div>
					<div class="comment-footer">
						<sec:authorize access="isAuthenticated()">
							<button class="btn btn-danger" id="btn-comment-write"><i class="fa fa-save"></i>작성완료</button>
						</sec:authorize>
					</div>
				</div>
				<ul class="comment-list">
					
				</ul>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>