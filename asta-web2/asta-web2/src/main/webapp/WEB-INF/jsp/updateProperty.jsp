<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>

<html>
<head>
<link rel="icon" 
      type="image/png" 
      href="../../favicon5.ico" />

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
			<span class="inner">Gestione properties</span>
		</div>


		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner registrationPage">
			
				<form:form id="myForm" method="post" action="updateProperty.html"
					 commandName="configuration">

					<div class="data n1">
						<label for="name">Key</label>
						<form:input type="text" class="form-control" path="name" id="name"
							placeholder="Key" />

					</div>
					<div class="data n2">
						<label for="description">Value</label>
						<form:input class="form-control" path="value"
							id="value" placeholder="Value" />

					</div>
					
					<button class="button login">Update</button>



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
