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


<title>Ciao Rocco</title>

</head>

<body class="commonOverride becomeFundraiser support">



	<%-------------------------------------------------- HEADER --------------------------------------------------------%>
	<div id="wrapperHeader">
		<jsp:include page="header.jsp" />
	</div>

	<div id="wrapperMain">

		<div class="pageTitle">
			<span class="inner">Iserisci i tuoi dati</span>
		</div>
		<div class="inner">
			Si prega gentilmente di inserire nome e cognome reali, e la parola segreta ricevuta.
		</div>

		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner registrationPage">

				<form:form id="myForm" method="post" action="loginUser.html"
					commandName="player">
					<div class="data n1">
						<label for="name">Nome</label>
						<form:input type="text" class="form-control" path="name"
							id="name" placeholder="Nome" />
						
						<c:if test="${not empty nameMessage}">
							<div class="errorMessage" style="color: red;">
								${nameMessage}
							</div>
						</c:if>
						
					</div>
					<div class="data n2">
						<label for="username">Cognome</label>
						<form:input type="text" class="form-control" path="lastName"
							id="lastName" placeholder="Cognome" />
						
						<c:if test="${not empty lastNameMessage}">
							<div class="errorMessage" style="color: red;">
								${lastNameMessage}
							</div>
						</c:if>
						
					</div>
					<div class="data n3">
						<label for="password">Parola d'ordine</label>
						<form:input type="password" class="form-control" path="password"
							id="password" placeholder="Password" />

						<c:if test="${not empty passwordMessage}">
							<div class="errorMessage" style="color: red;">
								${passwordMessage}
							</div>
						</c:if>

					</div>
						
					<button class="button login">Gioca!</button>


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
