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
			$(".backToTop").on("click", function() {
				$("#wrapperMain").scrollToMe(500);
			});
			$(window).scroll(function(e) {
				if ($(window).scrollTop() > 400) {
					$(".backToTop").fadeIn();
				} else {
					$(".backToTop").fadeOut();
				}
			});
		</script>
	</c:if>


	<%-------------------------------------------------- HEADER --------------------------------------------------------%>
	<div id="wrapperHeader">
		<jsp:include page="header.jsp" />
	</div>


	<div id="wrapperMain">

		<div class="pageTitle">
			<span class="inner">Login Amministrazione</span>
		</div>

		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner">

				<form:form id="myForm" method="post" action="loginAdmin.html"
					commandName="user">
					<div class="data n1">
						<label for="username">Username</label>
						<form:input type="text" class="form-control" path="username"
							id="username" placeholder="Username" />
						
						<c:if test="${not empty userMessage}">
							<div class="errorMessage" style="color: red;">
								${userMessage}
							</div>
						</c:if>
						
					</div>
					<div class="data n2">
						<label for="password">Password</label>
						<form:input type="password" class="form-control" path="password"
							id="password" placeholder="Password" />

						<c:if test="${not empty passwordMessage}">
							<div class="errorMessage" style="color: red;">
								${passwordMessage}
							</div>
						</c:if>

					</div>
						
					<button class="button login">Login</button>


				</form:form>

			</div>
		</div>

	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
