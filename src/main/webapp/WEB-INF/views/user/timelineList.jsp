<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${ timelineList }" var="timeline">
	<dt>${timeline.key } 년</dt>
	<c:forEach items="${timeline.value }" var="timelineItem" varStatus="status">
		<c:if test="${ status.index % 2 == 0 }">
			<dd class="pos-right clearfix">
		</c:if>
		<c:if test="${ status.index % 2 != 0 }">
			<dd class="pos-left clearfix">
		</c:if>
			  <div class="circ"></div>
			  <div class="time">${timelineItem.completeDate }</div>
			  <div class="events">
				  <div class="pull-left">
					  <img class="events-object img-rounded" src="${pageContext.request.contextPath }/image.do?id=${timelineItem.thumbnail}">
				  </div>
				  <div class="events-body">
					  <h4 class="events-heading">${timelineItem.title }</h4>
					  <p>${timelineItem.content }</p>
				  </div>
			  </div>
		  </dd>
	  </c:forEach>
</c:forEach>
				 