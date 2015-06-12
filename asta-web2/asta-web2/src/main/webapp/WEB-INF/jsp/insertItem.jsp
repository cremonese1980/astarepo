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
			<c:choose>
				<c:when test="${not empty item.id}">
					<span class="inner">Modifica oggetto</span>
									</c:when>
				<c:otherwise>
				<span class="inner">Inserimento</span>
				</c:otherwise>
				</c:choose>
				
		</div>
		<div class="inner">
				<span class="inner" ><a href="adminPage.html">Torna all'elenco</a></span>
		</div>

		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner registrationPage">

				<form:form id="myForm" method="post" action="insertItem.html" enctype="multipart/form-data"
					commandName="item">
					
					<form:hidden path="id"/>
					<form:hidden path="status"/>
					<form:hidden path="bestRelaunch.id"/>
					
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
						<label for="description">Descrizione</label>
						<form:textarea type="description" class="form-control" path="description"
							id="description" placeholder="Descrizione" />

						<c:if test="${not empty passwordMessage}">
							<div class="errorMessage" style="color: red;">
								${passwordMessage}
							</div>
						</c:if>

					</div>
					
					<div class="data n3">
						<label for="baseAuctionPrice">Base d'asta</label>
						<form:input type="text" class="form-control" path="baseAuctionPrice"
							id="baseAuctionPrice" placeholder="Prezzo Base d'asta"  />
						
						<c:if test="${not empty baseAuctionPriceMessage}">
							<div class="errorMessage" style="color: red;">
								${baseAuctionPriceMessage}
							</div>
						</c:if>
						
					</div>
					
					<div class="data n4">
						<label for="fromDate">Data inizio (gg/MM/aaaa)</label>
						<form:input type="text" class="form-control" path="fromDate"
							id="fromDate" placeholder="gg/mm/aaaa HH:mm:ss" />
<%-- 							<form:input type="text" class="form-control" path="fromDateTime" --%>
<%-- 							id="fromDateTime" placeholder="HH:mm:ss" /> --%>

						<c:if test="${not empty fromDateMessage}">
							<div class="errorMessage" style="color: red;">
								${fromDateMessage}
							</div>
						</c:if>

					</div>
					
					<div class="data n5">
						<label for="expiringDate">Data scadenza (gg/MM/aaaa)</label>
						<form:input type="text" class="form-control" path="expiringDate"
							id="expiringDate" placeholder="gg/mm/aaaa HH:mm:ss" />
<%-- 						<form:input type="text" class="form-control" path="expiringDateTime" --%>
<%-- 							id="expiringDateTime" placeholder="HH:mm:ss" /> --%>

						<c:if test="${not empty expiringDateMessage}">
							<div class="errorMessage" style="color: red;">
								${expiringDateMessage}
							</div>
						</c:if>

					</div>
					
					<div class="data n6">

						<c:if test="${not empty okMessage}">
							<div class="errorMessage" style="color: red;">
								${okMessage}
							</div>
						</c:if>
						<c:if test="${not empty errorMessage}">
							<div class="errorMessage" style="color: red;">
								${errorMessage}
							</div>
						</c:if>

					</div>

					<button class="button login">Salva</button>

				</form:form>

			</div>
		</div>
		
		<div class="inner">&nbsp;</div>

		<div class="section2" style="background-color: #F8F8F8;">
			<c:if test="${not empty item.id}">
				<div class="inner">
					<div class="data n5">
						<span><a href="addImage.html?itemid=${item.id}">Aggiungi
								immagini</a></span>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty images}">
				<div class="inner">
					<table class="commonOverride registrationPage"
						style="border: 1px solid #F8F8F8">
						<thead align="center">
							<tr>
								<th width="20%"><h3>Titolosd</h3></th>
								<th width="20%"><h3>Descrizione</h3></th>
								<th width="50%"><h3>Anteprima</h3></th>
								<th width="10%"><h3>Elimina</h3></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${images}" var="image">
								<tr>
									<td>${image.name}</td>
									<td>${image.description}</td>
									<c:url var="urlThumb" value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.thumbName}" />
									<c:url var="url" value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.name}" />
									<td>
										<a href="${url}"><img
										src="${urlThumb}" 
										title="${image.description}" /></a></td>
									<td><a href="deleteImage.html?imageid=${image.id}">Elimina</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

				</div>
				</c:if>
		</div>

	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
