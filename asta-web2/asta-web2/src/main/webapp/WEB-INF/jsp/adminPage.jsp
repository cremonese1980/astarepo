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
			<span class="inner">Oggetti in vendita</span>
		</div>
		
		<div class="inner">
			<span class="inner"><a href="insertItem.html">Aggiungi oggetto</a></span>
		</div>

		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner">
				<table class="commonOverride registrationPage" >
					<thead align="center">
						<tr>
							<th width="10%"><h3>Nome</h3></th>
							<th width="50%"><h3>Descrizione</h3></th>
							<th width="10%"><h3>Base d'asta</h3></th>
							<th width="10%"><h3>Scadenza</h3></th>
							<th width="10%"><h3>Inizio</h3></th>
							<th width="10%"><h3>Stato</h3></th>
							<th width="10%"><h3>Azioni</h3></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${itemlist}" var="item">
							<tr>
								<td>
									${item.name}
								</td>
								<td>
									${item.description}
								</td>
								<td>
								<fmt:formatNumber value="${item.baseAuctionPrice}" 
								currencyCode="EUR" type="currency" maxFractionDigits="2"/> 
								</td>
								<td>
									<fmt:formatDate value="${item.expiringDate}" 
									pattern="dd/MM/yyyy HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${item.fromDate}" 
									pattern="dd/MM/yyyy HH:mm:ss"/>
								</td>
								<td>
									${item.status.value}
								</td>
								<td>
									<a href="modifyItem.html?itemid=${item.id}">Modifica </a>
									<a href="deleteItem.html?itemid=${item.id}">Elimina </a>
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
