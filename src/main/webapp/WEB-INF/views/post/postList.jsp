<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<c:forEach items="${postList}" var="post">
	<div class="card-sizer"></div>
		<div class="card-wrap">
				<div class="card-header">
				<c:if test="${post.thumbnail != -1 }">
					<img class="card-thumbnail" src="${pageContext.request.contextPath }/image.do?id=${post.thumbnail}" alt="" />				
				</c:if>
				</div>
				<div class="card-body">
					<a href="${pageContext.request.contextPath }/post/postDetailPage.do?postId=${post.postId}">
						<h4 class="card-heading">${post.title}</h4>
					</a>
					<p class="card-content">
						${post.plainContent}
					</p>
				</div>
				<div class="card-footer">
					<p class="card-desc">
						<span class="seperate hit"><i class="fa fa-eye"></i>${post.hitCnt}</span> 
						<span class="seperate like"><i class="fa fa-heart"></i>${post.likeCnt}</span>
						<span class="seperate comment"><i class="fa fa-comment"></i>${post.commentCnt}</span>
					</p>
					<p class="card-desc">
						<span class="reg-date"><i class="fa fa-clock-o"></i>${post.regDate}</span>
					</p>
					<div class="card-profile">
						<a href="${pageContext.request.contextPath }/user/profilePage.do?email=${post.writerId }">
							<img src="${pageContext.request.contextPath }/image.do?id=${post.photo}" alt="" class="circular-square user-image" />
							<span class="user-name">${post.name}</span>					
						</a>
					</div>
			</div>
		</div>
</c:forEach>
		