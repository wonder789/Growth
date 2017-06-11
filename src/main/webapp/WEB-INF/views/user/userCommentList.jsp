<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${ userCommentList }" var="comment">
<div class="user-comment-list-item <c:if test='${comment.level > 1 }'>r2</c:if>">
	<c:if test='${comment.level > 1 }'>
		<i class="fa fa-reply fa-rotate-180 icon-reply"></i>
	</c:if>
	<div class="comment-body-left">
		<a href="">
			<img src="${pageContext.request.contextPath }/image.do?id=${comment.writerPhoto}" alt="" class="circular-square user-img-sm"/>
		</a>	
	</div>
	<div class="comment-body">
		<ul class="user-comment-desc-list">
			<li>
				<h5 class="desc-name">${comment.writerName }</h5>
			</li>
			<li>
				<i class="fa fa-clock-o">${comment.regDate }</i>
			</li>
			<li>
				<p class="comment-content">${comment.content }</p>
			</li>
		</ul>
		<div class="comment-footer text-right">
			<a class="comment-reply" href="#" onclick="showReplyForm(event);">답글달기</a>
			<div class="reply-form-wrap none">
				<form class="reply-form" onsubmit="return commentReplyWrite(event);">
					<c:if test="${comment.grpCommentId != null }">
						<input type="hidden" name="grpCommentId" value="${comment.grpCommentId }" />
					</c:if>
					<input type="hidden" name="pCommentId" value="${comment.commentId }"/>
					<input type="hidden" name="userId" value="${ comment.userId }"/>
					<div class="comment-body-left">
						<img src="${pageContext.request.contextPath }/image.do?id=${currentUser.photo}" alt="" class="circular-square user-img-sm"/>
					</div>
					<div class="comment-body">
						<textarea name="content" id="" class="form-control"></textarea>
					</div>
					<div class="comment-footer text-right">
						<button type="submit" class="btn btn-danger" ><i class="fa fa-save"></i>작성완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</c:forEach>