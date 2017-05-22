<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${qnaList}" var="qna">
		<div class="col-md-3 col-sm-4 col-xs-12">
			<div class="qna-card-wrap">
				<div class="qna-card-body">
					<a href="${pageContext.request.contextPath }/qna/qnaDetailPage.do?qnaId=${qna.qnaId}">
						<h4 class="qna-card-heading">${qna.title}</h4>
					</a>
					<p class="qna-card-content">
						${qna.plainContent}
					</p>
				</div>
				<div class="qna-card-footer">
					<p class="qna-card-desc">
						<span class="seperate hit"><i class="fa fa-eye"></i>${qna.hitCnt}</span> 
						<span class="seperate like"><i class="fa fa-heart"></i>${qna.likeCnt}</span>
						<span class="seperate comment"><i class="fa fa-comment"></i>${qna.commentCnt}</span>
						<span class="seperate betPoint"><i class="fa fa-gift" aria-hidden="true"></i>${qna.betPoint}P</span>
					</p>
					<p class="qna-card-desc">
						<span class="reg-date"><i class="fa fa-clock-o"></i>${qna.regDate}</span>
					</p>
					<div class="qna-card-profile">
						<img src="${pageContext.request.contextPath }/image.do?id=${qna.photo}" alt="" class="circular-square user-image" />
						<span class="user-name">${qna.name}</span>					
					</div>
			</div>
			</div>
		</div>
</c:forEach>
		