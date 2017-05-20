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
		  	<li class="active"><a href="news.html">포스트</a></li>	
			<li><a href="news.html">뉴스</a></li>
			<li><a href="consult.html">질의응답</a></li>
			<li><a href="notice.html">공지사항</a></li>
			<sec:authorize access="isAnonymous()">
				<li><a href="/auth/loginPage.do">로그인</a></li>
				<li><a href="/auth/signupPage.do">회원가입</a></li>	
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><a href="/auth/mypage.do">
					<img class="circular-square user-image" 
						 src="${pageContext.request.contextPath}/image.do?id=<sec:authentication property='principal.photo'/>" 
				/><sec:authentication property="principal.name"/></a></li>
				<li><a href="/auth/logout.do">로그아웃</a></li>
			</sec:authorize>
		  </ul>
		</div><!--/.nav-collapse -->
	  </div>
	</nav>
	
	
	<div class="container">