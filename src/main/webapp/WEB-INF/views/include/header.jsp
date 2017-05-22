<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="wrap">
		<!-- Fixed navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
	  <div class="container">
		<div class="navbar-header">
		  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		  </button>
		  <a class="navbar-brand logo" href="/" >Growth</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse navbar-right">
		  <ul class="nav navbar-nav">
		  	<li <c:if test="${ currentPage eq 'post' }">class="active"</c:if> ><a href="${pageContext.request.contextPath}/post/postPage.do">
		  			<i class="fa fa-bookmark" aria-hidden="true"></i>포스트</a></li>	
			<li <c:if test="${ currentPage eq 'news' }">class="active"</c:if> ><a href="${pageContext.request.contextPath}/news/newsPage.do"><i class="fa fa-newspaper-o" aria-hidden="true"></i>뉴스</a></li>
			<li <c:if test="${ currentPage eq 'qna' }">class="active"</c:if> ><a href="/qna/qnaPage.do"><i class="fa fa-question" aria-hidden="true"></i>질의응답</a></li>
			<li <c:if test="${ currentPage eq 'notice' }">class="active"</c:if> ><a href="/notice/noticePage.do"<i class="fa fa-bullhorn" aria-hidden="true"></i>>공지사항</a></li>
			<sec:authorize access="isAnonymous()">
				<li <c:if test="${ currentPage eq 'login' }">class="active"</c:if>><a href="${pageContext.request.contextPath}/auth/loginPage.do">
				<i class="fa fa-key" aria-hidden="true"></i>로그인</a></li>
				<li <c:if test="${ currentPage eq 'signup' }">class="active"</c:if>><a href="${pageContext.request.contextPath}/auth/signupPage.do">
					<i class="fa fa-sign-in" aria-hidden="true"></i>회원가입</a></li>	
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><a href="${pageContext.request.contextPath}/auth/mypage.do">
					<img class="circular-square user-image" 
						 src="${pageContext.request.contextPath}/image.do?id=<sec:authentication property='principal.photo'/>" />
		  <sec:authentication property="principal.name"/></a></li>
				<li><a href="${pageContext.request.contextPath}/auth/logout.do"><i class="fa fa-sign-out" aria-hidden="true"></i>로그아웃</a></li>
			</sec:authorize>
		  </ul>
		</div><!--/.nav-collapse -->
	  </div>
	</nav>
	
	
	<div class="container">