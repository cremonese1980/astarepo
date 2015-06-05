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

	<script>
	function startTimer(duration, display) {
	    var start = Date.now(),
	        diff,
	        days,
	        hours,
	        minutes,
	        seconds;
	    function timer() {
	        // get the number of seconds that have elapsed since 
	        // startTimer() was called
	        diff = duration - (((Date.now() - start) / 1000) | 0);

	        // does the same job as parseInt truncates the float
	        days = (diff / 86400) | 0;
	        hours =((diff- days*86400) / 3600) | 0;
	        minutes = ((diff - hours*3600) /60) | 0;
	        seconds = (diff % 60) | 0;

	        minutes = minutes < 10 ? "0" + minutes : minutes;
	        seconds = seconds < 10 ? "0" + seconds : seconds;
	        hours = hours < 10 ? "0" + hours : hours;

	        display.textContent = days +  " " + hours + ":" + minutes + ":" + seconds; 

	        if (diff <= 0) {
	            // add one second so that the count down starts at the full duration
	            // example 05:00 not 04:59
	            start = Date.now() + 1000;
	        }
	    };
	    // we don't want to wait a full second before the timer starts
	    timer();
	    setInterval(timer, 1000);
	}

	window.onload = function () {
	    var fiveMinutes = 5 * 24 *60 * 60,
	        display = document.querySelector('#time');
	    startTimer(fiveMinutes, display);
	};
	</script>

	<%-------------------------------------------------- HEADER --------------------------------------------------------%>
	<div id="wrapperHeader">
		<jsp:include page="header.jsp" />
	</div>


	<div id="wrapperMain">

		<div class="pageTitle">
				<span class="inner"><a href="itemlist.html">Torna all'elenco</a></span>
		</div>
		
		<div class="section1" style="background-color: #F8F8F8;">
			<div class="inner registrationPage">

				<form:form id="myForm" method="post" action="relaunchItem.html"
					commandName="relaunch">
					
					<form:hidden path="username"/>
					<form:hidden path="item.id" />
					<table>
 					
 					<tr>
							<td colspan="2"><label>L'asta si chiude in <span id="time"></span></label></td>
						</tr>
						<tr>
							<td>Oggetto</td>
							<td>${item.name}</td>
						</tr>
						<tr>
							<td>Descrizione</td>
							<td>${item.description}</td>
						</tr>
						<tr>
							<td>Base d'asta</td>
							<td>&euro; <fmt:formatNumber value="${item.baseAuctionPrice}"
									  maxFractionDigits="2" /></td>
						</tr>
						<tr>
							<td>Scadenza</td>
							<td><fmt:formatDate value="${item.expiringDate}"
									pattern="dd/MM/yyyy HH:mm:ss" /></td>
						</tr>
						<tr>
							<td>Miglior Rilancio</td>
							<td>&euro; <fmt:formatNumber value="${item.bestRelaunch}"
									maxFractionDigits="2" />
								(${bestRelaunch.username} <fmt:formatDate
									value="${bestRelaunch.date}" pattern="dd/MM/yyyy HH:mm:ss" />)
							</td>
						</tr>
						<tr>
							<td >
									<label for="name">Offerta</label>
									

							</td>
							<td>
								<form:input type="text" class="form-control" path="amount"
										id="amount" placeholder="rilancio" />
									<c:if test="${not empty relaunchMessage}">
										<div class="errorMessage" style="color: red;">
											${relaunchMessage}</div>
									</c:if>
								</td>	

						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>	<button class="button login">Rilancia</button></td>
						</tr>
					</table>


				

				</form:form>

			</div>
		</div>
		
		<div class="inner">&nbsp;</div>
		

		<div class="section2" style="background-color: #F8F8F8;">
			<c:if test="${not empty item.images}">
				<div class="inner">
					<table class="commonOverride registrationPage"
						style="border: 1px solid #F8F8F8">
						<thead align="center">
							<tr>
								<th width="20%"><h3>Titolo</h3></th>
								<th width="20%"><h3>Descrizione</h3></th>
								<th width="50%"><h3>Anteprima</h3></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${item.images}" var="image">
								<tr>
									<td>${image.name}</td>
									<td>${image.description}</td>
									<c:url var="urlThumb" value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.thumbName}" />
									<c:url var="url" value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.name}" />
									<td>
										<a href="${url}"><img
										src="${urlThumb}" 
										title="${image.description}" /></a></td>
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
