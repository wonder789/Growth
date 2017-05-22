<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${ qnaCommentList }" var="comment">
<li class="comment-list-item">
	<div class="media">
			<c:if test="${ comment.chooseYn eq 'Y' }">
				<div class="select-answer">채택된 답변</div>
			</c:if>
		<a href="#" class="pull-left media-left">
			<img src="${pageContext.request.contextPath }/image.do?id=${comment.photo}" alt="" class="circular-square user-img-sm"/>
		</a>
		<div class="media-body">
			
			<span class="comment-writer">${comment.name }</span>
			<p class="help-block">
			<span class="reg-date">
				<i class="fa fa-clock-o"></i> ${comment.regDate }
			</span><br/>
			<pre>${comment.content }</pre>
			
			<sec:authorize access="isAuthenticated()">
				<c:if test="${ qnaInfo.writerId eq currentUserId 
							and qnaInfo.writerId ne comment.writerId
							and comment.chooseYn eq 'N' }">
					<p class="text-right choose-wrap">
						<button class='btn btn-success btn-choose' id="btn" ><i class="fa fa-check"></i>채택하기</button>
						<form class="choose-form">
							<input type="hidden" name="writerId" value="${comment.writerId }">
							<input type="hidden" name="qnaId" value="${qnaInfo.qnaId }">
							<input type="hidden" name="commentId" value="${comment.commentId }">
						</form>
					
					</p>
						
			
				</c:if>
			</sec:authorize>
		</div>
	</div>
</li>
</c:forEach>