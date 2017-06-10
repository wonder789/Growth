<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${newsList }" var="item">
	<div class="media news-item">
		<c:if test="${item.imgUrl != null or item.imgUrl eq ''}">
			<a href="#" class="pull-left media-left">
				<img data-original="${item.imgUrl}" alt="" class="news-img lazy"/>
			</a>
		</c:if>
		<div class="media-body">
			<h5 class="news-heading"><a href="${item.link }" target="_blank">${item.title }</a></h5>
			<span class="help-block news-date">${item.regDate }</span>
			<p class="news-content">
				${item.content}
			</p>
		</div>
	</div>
</c:forEach>