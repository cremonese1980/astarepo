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



.modalDialogObserve {
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






.modalDialogObserve:target {
	opacity:1;
	pointer-events: auto;
}

.modalDialogObserve > div {
	width: 400px;
	position: relative;
	margin: 10% auto;
	padding: 5px 20px 13px 20px;
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



.closeObserve {
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

.closeObserve:hover { background: #00d9ff; }






  </style>

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
	        seconds,
	        text,
	        lastWord;
	    function timer() {
	        // get the number of seconds that have elapsed since 
	        // startTimer() was called
	        diff = duration - (((Date.now() - start) / 1000) | 0);

	        // does the same job as parseInt truncates the float
	        days = (diff / 86400) | 0;
			hours =((diff- days*86400) / 3600) | 0;
	        minutes = ((diff - hours*3600 - days*86400) /60) | 0 ;
	        seconds = (diff % 60) | 0;

			text = "L'asta si chiude tra ";
	        if(days>0){
	        	text = days + " giorni";
	        	if(days==1){
	        		text = days + " giorno";
	        	}
	        }
	        
	        minutes = minutes < 10 ? "0" + minutes : minutes;
	        seconds = seconds < 10 ? "0" + seconds : seconds;
	        hours = hours < 10 ? "0" + hours : hours;
	        
	        if(diff<3600){
	        	hours ="";
	        }else{
	        	hours = hours + "h:"
	        }
	        if(diff<60){
	        	minutes ="";
	        }else{
	        	minutes = minutes + "m:"
	        }
	        
	        var finish = false;
	        
	        if(diff <= 0){
	        	finish = true;
	        }else{
	        	seconds = seconds + "s"
	        }
	        
	        
	        text = text +  " " + hours +  minutes +  seconds ;
	        
	        if(finish){
	        	text  = "Asta terminata!";
	        	
	        }

// 	        if (diff <= 0) {
// 	            // add one second so that the count down starts at the full duration
// 	            // example 05:00 not 04:59
// // 	            start = Date.now() + 1000;
// 	        	text = "Asta terminata!";
// 	        }
	        display.textContent = text;  
	    };
	    // we don't want to wait a full second before the timer starts
	    timer();
	    setInterval(timer, 1000);
	}

	window.onload = function () {
	    var fiveMinutes = ${expiringSeconds},
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
			<c:if test="${not empty astaService.testPhaseMessage}">
				<div class="inner" style="background-color:#DDDDDD;">
					<b>${astaService.testPhaseMessage}</b>
				</div>
			</c:if>

			<c:url var="urlIconObserve" value="img/icons/observe.png" />
			<div class="links">
				<a href="#openModalObserve"><img style="width:35px;margin-left:150px" src="${urlIconObserve}" />
					Osserva oggetto</a>
			</div>

			<div id="openModalObserve" class="modalDialogObserve">
				<div>
					<a href="#closeObserve" title="Close" class="closeObserve">X</a>
					<h2>Osserva Oggetto</h2>
					<form:form id="myFormModal" method="post" action="observeItem.html"
						commandName="userObserver">
						
						<form:hidden path="user.password"/>
						<form:hidden path="item.name"/>
						<form:hidden path="item.id"/>
<%-- 						<form:hidden path="relaunches"/> --%>
<%-- 						<form:hidden path="expiringSeconds"/> --%>

						<div class="data n1">
							<label for="name">Nome</label>
							<form:input type="text" class="form-control" path="user.name"
								id="name" placeholder="name" disabled="true"/>


						</div>
						
						<div class="data n2">
							<label for="lastName">Cognome</label>
							<form:input type="text" class="form-control" path="user.lastName"
								id="lastName" placeholder="lastName" disabled="true"/>

						</div>
						
						<div class="data n3">
							<label for="email">Email</label>
							<form:input type="text" class="form-control" path="user.email"
								id="email" placeholder="email" />

							<c:if test="${not empty emailMessage}">
								<div class="errorMessage" style="color: red;">
									${emailMessage}</div>
							</c:if>

						</div>

						<button class="button login">Osserva</button>

					</form:form>
				</div>
			</div>

			<div class="inner registrationPage">

				<form:form id="myForm" method="post" action="relaunchItem.html"
					commandName="relaunch">
					
					<form:hidden path="username"/>
					<form:hidden path="item.id" />
					<table>
 					
 						<tr>
							<td colspan="2"><h2>
									<span id="time"/></h2>&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="2" style="font-weight: bold;">Se il rilancio avviene negli ultimi 3 minuti, l'orario di fine
							 asta verr� prolungato di ulteriori 3 minuti, per consentire a chiunque di 
							 poter rilanciare.</td>
						
						</tr>
						<tr><td><br/></td>
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
							<td>
								&euro; <fmt:formatNumber value="${item.baseAuctionPrice}"
									  maxFractionDigits="2" />
							</td>
						</tr>
						<tr>
							<td>Scadenza</td>
							<td><fmt:formatDate value="${item.expiringDate}"
									pattern="dd/MM/yyyy HH:mm:ss" /></td>
						</tr>
						<tr>
							<td>Miglior Rilancio</td>
							<td><c:choose>
							<c:when test="${not empty item.bestRelaunch.username}">
								&euro; <fmt:formatNumber value="${item.bestRelaunch.amount}"
										maxFractionDigits="2" />
								(<b>${item.bestRelaunch.username}</b> <fmt:formatDate
										value="${item.bestRelaunch.date}" pattern="dd/MM/yyyy HH:mm:ss" />)
								</c:when>
								<c:otherwise>
									Nessun rilancio, il tuo pu� essere il primo!
								</c:otherwise>
								</c:choose>
								</td>
						</tr>
						<tr>
							<td >
									La tua Offerta
									

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
						<tbody>
								<tr>
									<c:forEach items="${item.images}" var="image" varStatus="status">
											<c:url var="urlThumb" value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.thumbName}" />
											<c:url var="url" value="image.html?imageid=${image.id}&itemid=${image.item.id}&imagename=${image.name}" />
												<a href="#openModal${status.index}"><img style="margin:10px;" src="${urlThumb}" 
 														title="${image.description}" /></a>
												<div id="openModal${status.index}" class="modalDialog">
													<div>
														<a  href="#close" title="Close" class="close">X</a>
														<img style="max-width: 800px; max-height: 500px" src="${url}" 
 														title="${image.description}" />
													</div>
												</div>
											</td>
									</c:forEach>
								</tr>
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
