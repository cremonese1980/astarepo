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

		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner">
				<table class="commonOverride registrationPage" >
					<thead align="center">
						<tr>
							<th width="18%"><h3>Articolo</h3></th>
							<th width="50%"><h3>Descrizione</h3></th>
							<th width="10%"><h3>Base d'asta</h3></th>
							<th width="10%"><h3>Inizio</h3></th>
							<th width="10%"><h3>Scadenza</h3></th>
							<th width="10%"><h3>Anteprima</h3></th>
							<th width="10%"><h3>Rilancia!</h3></th>
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
								<fmt:formatNumber value=" ${item.baseAuctionPrice}" 
								currencyCode="EUR" type="currency" maxFractionDigits="2"/> 
								</td>
								<td>
									<fmt:formatDate value="${item.fromDate}" 
									pattern="dd/MM/yyyy HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${item.expiringDate}" 
									pattern="dd/MM/yyyy HH:mm:ss"/>
								</td>

								<td>
<%-- 									<c:if test="${not empty item.images}"> --%>
<%-- 										<c:forEach items="${item.images}" var="image" varStatus="status"> --%>
<%-- 											<c:if test="${0 == status.index}"> --%>
<%-- 												<c:url var="urlThumb" --%>
<%-- 													value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.thumbName}" /> --%>
<%-- 												<c:url var="url" --%>
<%-- 													value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.name}" /> --%>
<%-- 												<a href="${url}"><img src="${urlThumb}" --%>
<%-- 														title="${image.description}" /></a> --%>
<%-- 											</c:if> --%>
<%-- 										</c:forEach> --%>
<%-- 									</c:if> --%>
								</td>
								<c:url var="urlIcon"
										value="img/public/auction_ico2.png" />
								<td><a href="realunchItem.html?itemid=${item.id}"><img src="${urlIcon}"/></a></td>


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
