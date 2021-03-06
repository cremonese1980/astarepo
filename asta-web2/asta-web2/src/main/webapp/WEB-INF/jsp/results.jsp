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

<script type="text/javascript">
</script>

<style> 
  

.modalDialog {
	position: fixed;
	font-family: Arial, Helvetica, sans-serif;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background: rgba(0,0,0,0.8);
	z-index: 99999;
	opacity:0;
	-webkit-transition: opacity 400ms ease-in;
	-moz-transition: opacity 400ms ease-in;
	transition: opacity 400ms ease-in;
	pointer-events: none;
}


.modalDialog:target {
	opacity:1;
	pointer-events: auto;
}

.modalDialog > div {
	width: 800px;
	position: relative;
	margin: 10% auto;
	padding: 5px 20px 13px 20px;
	margin-top:30px;
	border-radius: 10px;
	background: #fff;
	background: -moz-linear-gradient(#fff, #999);
	background: -webkit-linear-gradient(#fff, #999);
	background: -o-linear-gradient(#fff, #999);
}



.close {
	background: #606061;
	color: #FFFFFF;
	line-height: 25px;
	position: absolute;
	right: -12px;
	text-align: center;
	top: -10px;
	width: 24px;
	text-decoration: none;
	font-weight: bold;
	-webkit-border-radius: 12px;
	-moz-border-radius: 12px;
	border-radius: 12px;
	-moz-box-shadow: 1px 1px 3px #000;
	-webkit-box-shadow: 1px 1px 3px #000;
	box-shadow: 1px 1px 3px #000;
	
}

.close:hover { background: #00d9ff; }




  </style>


<title>Ciao Rocco</title>

</head>

<body class="commonOverride becomeFundraiser support">


	<%-------------------------------------------------- HEADER --------------------------------------------------------%>
	<div id="wrapperHeader">
		<jsp:include page="header.jsp" />
	</div>


	<div id="wrapperMain">
	

		<div class="pageTitle">
			<span class="inner">Risultati Asta</span>
		</div>

		<div class="section1" style="background-color: #F8F8F8;">
			<c:if test="${not empty astaService.testPhaseMessage}">
				<div class="inner" style="background-color:#DDDDDD;">
					<b>${astaService.testPhaseMessage}</b>
				</div>
			</c:if>
			<br/>
			<br/>
			<div class="inner">
				<table class="commonOverride registrationPage" style="width:100%">
					<thead align="center">
						<tr>
							<th width="18%"><h3>Articolo</h3></th>
							<th width="30%"><h3>Descrizione</h3></th>
							<th width="10%"><h3>Base d'asta</h3></th>
							<th width="10%"><h3>Miglior offerta</h3></th>
							<th width="10%"><h3>Scadenza</h3></th>
							<th width="10%"><h3>Anteprima</h3></th>
						</tr>
					</thead>
					<tbody align="center">
						<c:forEach items="${itemlist}" var="item" varStatus="itemStatus">
							<c:choose>
								<c:when test="${itemStatus.index % 2 == 1}">
									<tr>
								</c:when>
								<c:otherwise>
									<tr style="background-color:#DDDDDD">
								</c:otherwise>
								</c:choose>
								<td><b>
									${item.name}
									</b>
								</td>
								<td>
									${item.description}
								</td>
								<td>&euro;
								<fmt:formatNumber value="${item.baseAuctionPrice}" 
								 maxFractionDigits="2"/> 
								</td>
								<td><c:choose>
										<c:when test="${not empty item.bestRelaunch.amount}">
											<b>${item.bestRelaunch.username}</b>: &euro; <fmt:formatNumber value="${item.bestRelaunch.amount}"
										maxFractionDigits="2" />
										</c:when>
										<c:otherwise>
											Nessuna offerta
										</c:otherwise>
									</c:choose> 
								</td>
								<td>
									<fmt:formatDate value="${item.expiringDate}" 
									pattern="dd/MM/yyyy HH:mm:ss"/>
								</td>

								<td>
									<c:if test="${not empty item.images}">
										<c:forEach items="${item.images}" var="image" varStatus="status">
											<c:if test="${0 == status.index}">
												<c:url var="urlThumb"
												value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.thumbName}" /> 
 												<c:url var="url"
 													value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.name}" /> 

												<a href="#openModal${image.id}"><img src="${urlThumb}" 
 														title="${image.description}" /></a>

												<div id="openModal${image.id}" class="modalDialog">
													<div>
														<a style="margin: 10px;" href="#close" title="Close" class="close">X</a>
														<img style="max-width: 800px; max-height: 500px" src="${url}" 
 														title="${image.description}" />
													</div>
												</div>

											</c:if> 
 										</c:forEach>
 									</c:if> 
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
