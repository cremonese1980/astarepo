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
			<span class="inner">Aggiungi immagine per <b>${item.name}</b></span>
			<span class="inner"><a href="modifyItem.html?itemid=${item.id}">Torna
					all'oggetto </a></span>
		</div>

		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner registrationPage">

				<div class="section1" style="background-color: #F8F8F8;">
					<div class="inner">
						<table class="commonOverride registrationPage">
							<thead align="center">
								<tr>
									<th width="10%"><h3>Nome</h3></th>
									<th width="60%"><h3>Descrizione</h3></th>
									<th width="10%"><h3>Base d'asta</h3></th>
									<th width="10%"><h3>Scadenza</h3></th>
									<th width="10%"><h3>Inizio</h3></th>
									<th width="10%"><h3>Stato</h3></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${item.name}</td>
									<td>${item.description}</td>
									<td><fmt:formatNumber value="${item.baseAuctionPrice}"
											currencyCode="EUR" type="currency" maxFractionDigits="2" />
									</td>
									<td><fmt:formatDate value="${item.expiringDate}"
											pattern="dd/MM/yyyy hh:mm:ss" /></td>
									<td><fmt:formatDate value="${item.fromDate}"
											pattern="dd/MM/yyyy hh:mm:ss" /></td>
									<td>${item.status.value}</td>
								</tr>
							</tbody>
						</table>

					</div>
				</div>



			</div>
		</div>
	
		<div class="inner">&nbsp;</div>

		<div class="section2" style="background-color: #F8F8F8;">
			<div class="inner registrationPage">
				<form:form id="myForm" method="post" action="addImage.html"
					enctype="multipart/form-data" commandName="itemImage">

					<form:hidden path="id" />


					<div class="data n1">
						<label for="name">Titolo</label>
						<form:input type="text" class="form-control" path="name" id="name"
							placeholder="Titolo" />

						<c:if test="${not empty nameMessage}">
							<div class="errorMessage" style="color: red;">
								${nameMessage}</div>
						</c:if>

					</div>
					<div class="data n1">
						<label for="description">Descrizione</label>
						<form:textarea class="form-control" path="description"
							id="description" placeholder="Descrizione immagine" />

						<c:if test="${not empty descriptionMessage}">
							<div class="errorMessage" style="color: red;">
								${descriptionMessage}</div>
						</c:if>

					</div>
					<div class="data n1">
						<label for="uploadImage">Immagine</label> <input
							name="uploadImage" type="file" id="uploadImage" />

						<c:if test="${not empty uploadImageMessage}">
							<div class="errorMessage" style="color: red;">
								${uploadImageMessage}</div>
						</c:if>

					</div>
					<form:hidden path="item.id" />
					<button class="button login">Aggiungi immagine</button>



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
