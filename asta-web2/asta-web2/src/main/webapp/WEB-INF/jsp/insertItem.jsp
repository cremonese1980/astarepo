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
						<label for="name">Base d'asta</label>
						<form:input type="text" class="form-control" path="baseAuctionPrice"
							id="baseAuctionPrice" placeholder="baseAuctionPrice"  />
						
						<c:if test="${not empty baseAuctionPriceMessage}">
							<div class="errorMessage" style="color: red;">
								${baseAuctionPriceMessage}
							</div>
						</c:if>
						
					</div>
					<div class="data n4">
						<label for="description">Data scadenza</label>
						<form:input type="text" class="form-control" path="expiringDate"
							id="expiringDate" placeholder="Data scadenza" />

						<c:if test="${not empty expiringDateMessage}">
							<div class="errorMessage" style="color: red;">
								${expiringDateMessage}
							</div>
						</c:if>

					</div>

					<c:choose>
						<c:when test="${not empty item.id}">
							<button class="button login">Modifica</button>

						</c:when>
						<c:otherwise>
							<button class="button login">Inserisci</button>
						</c:otherwise>
					</c:choose>

					


				</form:form>

			</div>
		</div>
		
		<div class="inner">&nbsp;</div>

		<div class="section2" style="background-color: #F8F8F8;">
			<div class="inner">
				<c:if test="${not empty item.id}">
					<div class="data n5">
						<span><a href="addImage.html?itemid=${item.id}">Aggiungi
								immagini</a></span>
					</div>
				</c:if>
			</div>
			<div class="inner">
				<table class="commonOverride registrationPage" style="border: 1px solid #F8F8F8 ">
					<thead align="center">
						<tr>
							<th width="20%"><h3>Titolo</h3></th>
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
								<td>antemprima</td>
								<td><a href="deleteImage.html?imageid=${image.id}">Elimina</a></td>
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
