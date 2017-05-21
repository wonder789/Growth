<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${ postCommentList }" var="comment">
<li class="comment-list-item">
	<div class="media">
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
		</div>
	</div>
</li>
</c:forEach>