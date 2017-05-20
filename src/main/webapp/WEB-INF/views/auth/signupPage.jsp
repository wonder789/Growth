<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<style type="text/css">
	#output-photo{
		width:150px;
		height:150px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#signup-btn").click(userSignup);
		$("input[name=type]").click(userTypeCheck);
		$("#file").change(loadFile);
	});
	function loadFile(event) {
	    var output = $('#output-photo').get(0);
	    output.src = URL.createObjectURL(event.target.files[0]);
	  };
	
	function userSignup(){
		if( !validateForm() )
			return ;
		
		var form = $("#signup-form").get(0);
	 	form.method = "POST",
		form.enctype = "multipart/form-data";
		
		var formData = new FormData(form);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/auth/signup.do",
			type : "POST",
			data : formData,
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(result){
				if( result.status == 200 ){
					alert(result.message);		
					location.href="${pageContext.request.contextPath}/auth/loginPage.do";
				} else if ( result.status == 400 ){
					alert(result.message);
				} else if( result.status == 500 ){
					alert("오류가 발생하였습니다.");
					console.log(result.message);
				}
			}
		}); 
	}
	
	function userTypeCheck(){
		var signupForm = $("#signup-form").get(0);
		
		if( $("input[name=type]").val() == "UT0101" ){
			$("#department").parents(".form-group").addClass("none-i");
			$("#grade").parents(".form-group").addClass("none-i");
		} else {
			$("#department").parents(".form-group").removeClass("none-i");
			$("#grade").parents(".form-group").removeClass("none-i");
		}
	}
	
	function validateForm(){
		var signupForm = $("#signup-form").get(0);
		
		var 		email = signupForm.email,
				 password = signupForm.password,
			passwordCheck = signupForm.passwordCheck,
			   department = signupForm.department,
			   	    type  = signupForm.type,
			   	    grade = signupForm.grade, 
			   	     name = signupForm.name;
		
		var invalid = [];
		$(".form-group").removeClass("has-error");
		
		if( email.value.trim() == "" || email.value.length == 0 ){
			invalid.push({
				element : "email",
				message : "이메일은 필수 입력값입니다."
			});
		} 
		
		if ( !emailcheck(email.value) ){
			invalid.push({
				element : "email",
				message : "이메일 형식이 아닙니다."
			});
		}
		
		if( password.value.trim() == "" || password.value.length == 0 ){
			invalid.push({
				element : "password",
				message : "비밀번호는 필수 입력값입니다."
			});
		}
		
		if (  password.value.length < 8 ){
			invalid.push({
				element : "password",
				message : "비밀번호는 8자리 이상으로 입력해주세요."
			});
		}
		
		if ( password.value != passwordCheck.value ){
			invalid.push({
				element : "passwordCheck",
				message : "비밀번호확인과 맞지 않습니다."
			});
		}
		
		if ( grade.value == "" && type.value != "UT0101" ){
			invalid.push({
				element : "grade",
				message : "계급을 체크해주세요."
			});
		}
		
		
		if( department.value.trim() == "" || department.value.length == 0 ){
			invalid.push({
				element : "department",
				message : "소속은 필수 입력값입니다."
			});
		} 
		
		if( name.value.trim() == "" || name.value.length == 0 ){
			invalid.push({
				element : "name",
				message : "이름은 필수 입력값입니다."
			});
		}
		
		if( invalid.length == 0 ){
			return true;
		} else {
			$("#" + invalid[0].element + "-error" ).text(invalid[0].message);	
			$("#" + invalid[0].element).parents(".form-group").addClass("has-error");
			return false;
		}
		
	}
</script>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	
	<section class="section" id="signup">
		<div class="row">
			<div class="col-md-6 col-md-pull-3 col-md-push-3 col-sm-8 col-sm-pull-2 col-sm-push-2">
				<form class="form-horizontal well" id="signup-form">
				  <div class="form-header">
				  	<h4 class="logo-header text-center">Growth</h4>
				  </div>
				  <div class="form-group">
				    <label for="email" class="col-sm-3 control-label">이메일</label>
				    <div class="col-sm-7">
				    	<div class="input-wrap">
				    		<input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="email" id="email-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-3 control-label">비밀번호</label>
				    <div class="col-sm-7">
				    	<div class="input-wrap">
				      		<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요 ">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="password" id="password-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="passwordCheck" class="col-sm-3 control-label">비밀번호 확인</label>
				    <div class="col-sm-7">
				    	<div class="input-wrap">
				      		<input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="비밀번호를  한번 더 입력하세요 ">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="passwordCheck" id="passwordCheck-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="type" class="col-sm-3 control-label">구분</label>
				    <div class="col-sm-7">
					    <c:forEach items='${userTypeCodeList }' var="userTypeCode">
					    	<label class="radio-inline"><input type="radio"   name="type" value="${userTypeCode.code }"
					    	 <c:if test="${ userTypeCode.code == 'UT0102' }" >checked</c:if> >${userTypeCode.codeNm }<br/></label>
					    </c:forEach>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="grade" class="col-sm-3 control-label">계급</label>
				    <div class="col-sm-7">
					    <div class="input-wrap">
						      <select class="form-control" id="grade" name="grade">
						      	<c:forEach items="${gradeCodeList }" var="gradeCode">
						      		<option value="">전체</option>
						      		<option value="${gradeCode.code }">${ gradeCode.codeNm}</option>
						      	</c:forEach>
						      </select>
					      <label class="control-label" for="grade" id="grade-error"></label>
				    	</div>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="department" class="col-sm-3 control-label">소속</label>
				    <div class="col-sm-7">
				    	<div class="input-wrap">
				      		<input type="text" class="form-control" id="department" name="department" placeholder="소속을 입력해주세요 ">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="department" id="department-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="passwordCheck" class="col-sm-3 control-label">이름</label>
				    <div class="col-sm-7">
					    <div class="input-wrap">
					      	<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요 ">
					      	<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="name" id="name-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="passwordCheck" class="col-sm-3 control-label">사진</label>
				    <div class="col-sm-7">
				      <input type="file" accept="image/*" class="form-control" id="file" name="file" >
				      <div class="thumbnail">
				      	<img class="img-rounded" id="output-photo"/>
				      </div>
				      
				    </div>
				  </div>
				  <div class="form-group">
				    <p class="text-center">
				    	<input type="button" class="btn btn-danger" id="signup-btn" value="회원가입" />
				    </p>
				  </div>
			</form>
			</div>
			
		</div>
	</section>
	
<%@ include file="../include/footer.jsp" %>