<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>

<html>
<head>

<%-------------------------------------------------- TITLE --------------------------------------------------------%>

<meta name="keywords" content="asta,benefica" />
<meta name="description" content="Asta benefica per..." />

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width">

<%-------------------------------------------------- INCLUDE CSS --------------------------------------------------------%>
<%@ include file="includeCss.jsp"%>

<%-------------------------------------------------- INCLUDE JAVASCRIPT --------------------------------------------------------%>
<%@ include file="includeJavascript.jsp"%>


<title>Asta Online</title>

</head>

<body class="commonOverride becomeFundraiser support">

	<c:set var="showBackToTop"></c:set>
	<c:if test="${showBackToTop=='true'}">
		<div class="button backToTop">BACK TO TOP</div>
		<script>			
			$(".backToTop").on("click",function () {$("#wrapperMain").scrollToMe(500);});
	    	$(window).scroll(function(e) {
				if ($(window).scrollTop()>400) {$(".backToTop").fadeIn();
				} else {$(".backToTop").fadeOut();}
			});
		</script>
	</c:if>


	<%-------------------------------------------------- HEADER --------------------------------------------------------%>
	<div id="wrapperHeader">
		<jsp:include page="header.jsp" />
	</div>


	<div id="wrapperMain">
	<div class="inner support banner">
		<c:if test="${not empty message}">
			<div class="overlayFormError error">${message}</div>
		</c:if>
		<form:form id="myForm" method="post" action="loginAdmin.html"
			class="bs-example form-horizontal" commandName="user">
			<fieldset>
				<legend>Student Enrollment Login Form</legend>
				<div class="form-group">
					<label for="userNameInput" class="col-lg-3 control-label">Username</label>
					<div class="col-lg-9">
						<form:input type="text" class="form-control" path="username"
							id="userNameInput" placeholder="User Name" />
						<form:errors path="username" cssClass="error" />
					</div>
				</div>
				<div class="form-group">
					<label for="passwordInput" class="col-lg-3 control-label">Password</label>
					<div class="col-lg-9">
						<form:input type="password" class="form-control" path="password"
							id="passwordInput" placeholder="Password" />
						<form:errors path="password" cssClass="error" />
					</div>
				</div>
				<div class="col-lg-9 col-lg-offset-3">
					<button class="btn btn-primary">Login</button>
				</div>
			</fieldset>
		</form:form>
	</div>
	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
