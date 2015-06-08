<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>

<html>
<head>
<c:url var="urlIcon" value="http://www.ciaorocco.it/app/favicon5.ico" />
<link rel="icon" type="image/x-icon" href="${urlIcon}" />
<link rel="shortcut icon" href="${urlIcon}" type="image/x-icon"> 

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
			
				<table class="commonOverride registrationPage" >
					<thead align="center">
						<tr>
							<th width="40%"><h3>Key</h3></th>
							<th width="40%"><h3>Value</h3></th>
							<th width="20%"><h3>Modifica</h3></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${configurations}" var="configuration">
							<tr>
								<td>
									${configuration.name}
								</td>
								<td>
									${configuration.value}
								</td>
								<td>
									<a href="updateProperty.html?propertyname=${configuration.name}">Update </a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
		</div>
		
		<div class="section1" style="background-color: #F8F8F8;">
			NOT Refreshed Properties
			<div class="inner registrationPage">
			
				<table class="commonOverride registrationPage" >
					<thead align="center">
						<tr>
							<th width="40%"><h3>Key=Value</h3></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${printProperties}" var="property">
							<tr>
								<td>
									${property}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
		</div>
		
		<div class="section1" style="background-color: #F8F8F8;">
			Refreshed Properties
			<div class="inner registrationPage">
			
				<table class="commonOverride registrationPage" >
					<thead align="center">
						<tr>
							<th width="40%"><h3>Key=Value</h3></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${printRefreshedProperties}" var="property">
							<tr>
								<td>
									${property}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
		</div>

	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
