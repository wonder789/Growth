<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${contestList }" var="contest">
	<div class="media contest-item">
		<div class="media-body">
			<h5 class="contest-heading"><a href="${contest.href }" target="_blank">${contest.title }</a></h5>
			<p class="news-content">
				${contest.content}
			</p>
		</div>
	</div>
</c:forEach>