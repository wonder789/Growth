<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${qnaList}" var="qna">
	<div class="card-sizer"></div>
		<div class="card-wrap">
				<div class="card-body">
					<a href="${pageContext.request.contextPath }/qna/qnaDetailPage.do?qnaId=${qna.qnaId}">
						<h4 class="card-heading">${qna.title}</h4>
					</a>
					<p class="card-content">
						${qna.plainContent}
					</p>
				</div>
				<div class="card-footer">
					<p class="card-desc">
						<span class="seperate hit"><i class="fa fa-eye"></i>${qna.hitCnt}</span> 
						<span class="seperate like"><i class="fa fa-heart"></i>${qna.likeCnt}</span>
						<span class="seperate comment"><i class="fa fa-comment"></i>${qna.commentCnt}</span>
					</p>
					<p class="card-desc">
						<span class="reg-date"><i class="fa fa-clock-o"></i>${qna.regDate}</span>
					</p>
					<div class="card-profile">
						<img src="${pageContext.request.contextPath }/image.do?id=${qna.photo}" alt="" class="circular-square user-image" />
						<span class="user-name">${qna.name}</span>					
					</div>
			</div>
		</div>
</c:forEach>
		