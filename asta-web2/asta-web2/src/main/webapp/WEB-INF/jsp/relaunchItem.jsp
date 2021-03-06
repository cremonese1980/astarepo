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
	width: 550px;
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

<script>

function rotateAndPaintImage ( context, image, angleInRad , positionX, positionY, axisX, axisY ) {
	
	  context.translate( positionX, positionY );
	  context.rotate( angleInRad );
	  context.drawImage( image, -axisX, -axisY );
	  context.rotate( -angleInRad );
	  context.translate( -positionX, -positionY );
	}
	
function prepareImage(){
	var TO_RADIANS = Math.PI/180; 
	ctx = document.getElementById("canvasDiv").getContext("2d");
	var imgSprite = new Image();
	imgSprite.src = "img/icons/redroundarrow.png";
	
	

	// rotate 45� image "imgSprite", based on its rotation axis located at x=20,y=30 and draw it on context "ctx" of the canvas on coordinates x=200,y=100
	rotateAndPaintImage ( ctx, imgSprite, 45*TO_RADIANS, 200, 100, 20, 30 );
}
	


function init(){
    setTimeout("update()", 2000);
}

function sendCode()
{

	var emailAddress = document.getElementById('email').value;
	var itemid = document.getElementById('itemid').value;
	var xmlhttp;    
	if (emailAddress==""){
  		document.getElementById("txtHint").innerHTML="Inserisci un indirizzo email";
  		return;
  	}
	if (window.XMLHttpRequest)
  	{// code for IE7+, Firefox, Chrome, Opera, Safari
  	xmlhttp=new XMLHttpRequest();
  	}
	else
  	{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function()
  	{	
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
    	{
    		document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
    		var statusCode = document.getElementById('statusCode').value;
    		if(statusCode=="ok"){
			    document.getElementById('btnObserve').style.display = "block";
			    document.getElementById('btnSendCode').style.display = "none";
			    document.getElementById('boxVerificationCode').style.display = "block";
			    document.getElementById('email').readOnly = 'readOnly';
		    }
  			else{
			  document.getElementById("txtHint").innerHTML= xmlhttp.responseText;
		  }
    	}
  	}
	document.getElementById("txtHint").innerHTML= "Invio email in corso......";
	xmlhttp.open("GET","sendCode.html?email="+emailAddress+"&itemid="+itemid,false);
	xmlhttp.send();
}

/*
 * OBSERVE ITEM
 */
function observeItem()
{

	var emailAddress = document.getElementById('email').value;
	var verificationCode = document.getElementById('verificationCode').value;
	var itemid = document.getElementById('itemid').value;
	var xmlhttp;    
 
	 if (verificationCode=="")
	 {
		 document.getElementById("txtHint").innerHTML="Inserisci il codice di verifica ricevuto";
		 return;
	 }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	 	 xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
			    document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
			    var statusCode = document.getElementById('statusCode').value;
			    if(statusCode=="ok"){
				    document.getElementById('btnObserve').style.display = "none";
				    document.getElementById('closeDialog').style.display = "block";
				    document.getElementById('verificationCode').readOnly = 'readOnly';
			// 	    document.getElementById('btnSendCode').style.display = "none";
			// 	    document.getElementById('boxVerificationCode').style.display = "block";
			    }
			  else{
				  document.getElementById("txtHint").innerHTML= xmlhttp.responseText;
			  }
		    }
	  }
	document.getElementById("txtHint").innerHTML= "Verificando il codice......";
	xmlhttp.open("GET","observeItem.html?email="+emailAddress+"&itemid="+itemid+"&code="+verificationCode,false);
	xmlhttp.send();
}


</script>

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
	        lastWord,
	        stop;
	      
	    var newDuration=document.getElementById("idExpiringSeconds").value;
	    var funcRunning = setInterval(timer, 1000);
	    
	     function timer() {
	        // get the number of seconds that have elapsed since 
	        // startTimer() was called
	        
	        stop = document.getElementById("idStopOld").value;
	        if(stop=='true'){
// 	        	alert('stopped');
	        	document.getElementById("idStopOld").value = 'false';
	        	clearInterval(funcRunning);
	        	
	        }
	        
	        
// 	        alert(duration);
	        diff = newDuration - (((Date.now() - start) / 1000) | 0);

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
	        	hours = hours + "h:";
	        }
	        if(diff<60){
	        	minutes ="";
	        }else{
	        	minutes = minutes + "m:";
	        }
	        
	        var finish = false;
	        
	        if(diff <= 0){
	        	finish = true;
	        }else{
	        	seconds = seconds + "s";
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
// 	    timer();
	    
	};
	
	function updateItem(startDate){
		
		var itemid = document.getElementById('itemid').value;
		var xmlhttpBis;
		
		if (window.XMLHttpRequest)
		  {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttpBis=new XMLHttpRequest();
		  }
		else
		  {// code for IE6, IE5
			xmlhttpBis=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		xmlhttpBis.onreadystatechange=function()
		  {
			  if (xmlhttpBis.readyState==4 && xmlhttpBis.status==200)
			    {
				    document.getElementById("updateItemContent").innerHTML=xmlhttpBis.responseText;
// 				    alert(xmlhttpBis.responseText);
				    var itemMessage = document.getElementById('itemMessage').value;
				    if(itemMessage!=null && itemMessage!=''){
				    	
				    document.getElementById("divTextItem").style.display = 'block';
				    document.getElementById("textItem").innerHTML = itemMessage;
				    document.getElementById("idAmount").innerHTML = document.getElementById('updAmount').value;
				    document.getElementById("idUsername").innerHTML= document.getElementById('updUsername').value;
				    document.getElementById("idDate").innerHTML = document.getElementById('updDate').value;
				    document.getElementById("idExpiringDate").innerHTML = document.getElementById('updExpiringDate').value;
				    document.getElementById("idTdRelaunch").style.color='red';
				    document.getElementById("idPageLife").innerHTML = document.getElementById('updPageLife').value;
				    
// 				    document.getElementById("newExpiringSeconds").innerHTML = document.getElementById('updExpiringSeconds').value;
// 				    document.getElementById("labNewExpiringSeconds").innerHTML = document.getElementById('updExpiringSeconds').value;
				    
				    document.getElementById("idExpiringSeconds").value = document.getElementById('updExpiringSeconds').value;
				    var fiveMinutes = document.getElementById("idExpiringSeconds").value,
			        display = document.querySelector('#time');
				    document.getElementById("idStopOld").value = 'true';
				    waitSeconds(1500);
			    	startTimer(fiveMinutes, display);
				    }
				    
// 				    alert(document.getElementById('updExpiringSeconds').value);
				    
			    }
		  };
		xmlhttpBis.open("GET","updateItem.html?itemid="+itemid+"&nowDate="+ startDate,true);
		xmlhttpBis.send();

	};
	
	function startFunction(nowDate) {
//     	alert('prima chiamata: ' + nowDate);
        setInterval(function(){ updateItem(nowDate); }, 30000);
	};
	
	function waitSeconds(iMilliSeconds) {
	    var counter= 0
	        , start = new Date().getTime()
	        , end = 0;
	    while (counter < iMilliSeconds) {
	        end = new Date().getTime();
	        counter = end - start;
	    }
	};

	window.onload = function () {
	    var fiveMinutes = document.getElementById("idExpiringSeconds").value,
	        display = document.querySelector('#time');
	    
	    
	    startTimer(fiveMinutes, display);

	    startFunction(document.getElementById("idPageLife").value);
	    
	    
	    
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
				<div class="inner" style="background-color:#DDDDDD;">
					<span style="font-size:12px">${astaService.testPhaseMessage}</span>
					
					<div id="updateItemContent" style="display:none"></div>
<%-- 					<span>Exp sec ${expiringSeconds}</span> --%>
<!-- 					<span id="labNewExpiringSeconds"></span> -->
					
					<input type="hidden" id="idExpiringSeconds" value="${expiringSeconds}" />
<!-- 					<input type="hidden" id="newExpiringSeconds"></span> -->
					<input type="hidden" id="idPageLife" value="${pageLife}">
					<input type="hidden" id="idStopOld" value="false" />
					
					<img src="img/icons/attention_icon2.png" style="display:none;"/>
					<div  class="error" style="color:red;padding:15px;margin-left:20px;display:none" id="divTextItem">
						<img style="width:25px" src="img/icons/attention_icon2.png"/>&nbsp;&nbsp;<span id="textItem"></span>
					</div>
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
						<form:hidden path="item.description"/>
						<form:hidden path="item.baseAuctionPrice"/>
						<form:hidden path="item.expiringDate"/>
						<form:hidden path="item.fromDate"/>
						<form:hidden path="item.bestRelaunch.id"/>
						<form:hidden path="expiringSeconds"/>

						<div class="data n1">
							<label style="margin-left:40px" for="name">Nome</label>
							<form:input type="text" class="form-control" path="user.name" style="margin-left:111px;width:250px;"
								id="name" placeholder="name" readonly="true"/>


						</div>
						
						<div class="data n2">
							<label style="margin-left:40px" for="lastName">Cognome</label>
							<form:input type="text" class="form-control" path="user.lastName" style="margin-left:80px;width:250px;"
								id="lastName" placeholder="lastName" readonly="true"/>

						</div>
						
						<div class="data n3">
							<label style="margin-left:40px" for="email">Email</label>
							<form:input type="text" class="form-control" path="user.email" style="margin-left:113px;width:250px;"
								id="email" placeholder="email" />

							<c:if test="${not empty emailMessage}">
								<div class="errorMessage" style="color: red;">
									${emailMessage}</div>
							</c:if>

						</div>
						<div id="boxVerificationCode" class="data n4" style="display:none">
							<label style="margin-left:40px" for="verificationCode">Codice Verifica</label>
							<form:input type="text" class="form-control" path="verificationCode" style="margin-left:35px;width:250px;"
								id="verificationCode" placeholder="Inserisci il Codice ricevuto" />

								<div class="errorMessage" style="color: red;">
									${emailMessage}</div>

						</div>
						<div class="error" style="color:red;padding:15px;margin-left:50px;" id="txtHint"></div>

					</form:form>
						<button id="btnObserve" class="button login" style="display:none" onclick="observeItem()">Osserva</button>
						<button id="btnSendCode" class="button login" onclick="sendCode()">Invia codice verifica</button>
						<a id="closeDialog" href="#closeObserve" title="Chiudi"  style="display:none;color:black;text-align:center;font-size:22px;">Torna a rilanciare</a>
				</div>
			</div>

			<div class="inner registrationPage">

				<form:form id="myForm" method="post" action="relaunchItem.html"
					commandName="relaunch">
					
					
					<form:hidden path="username"/>
					<form:hidden id="itemid" path="item.id" />
					<table>
 					
 						<tr>
							<td colspan="2">

								<h2 style="padding:5px;height:14px;">
									<span id="time" /> 
								</h2>
								<h1 style="padding:2px;height:34px;">
								<c:url var="urlIconObserve" value="img/icons/observe.png" />
								<a style="color: #00a5e2"
										href="#openModalObserve">Osserva oggetto<img
										style="width: 52px; margin-left:12px;margin-bottom:-14px"
										src="${urlIconObserve}" /> </a></h1>

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
							<td><span id="idExpiringDate"><fmt:formatDate  value="${item.expiringDate}"
									pattern="dd/MM/yyyy HH:mm:ss" /></span></td>
						</tr>
						<tr>
							<td>Miglior Rilancio</td>
							<td id="idTdRelaunch"><c:choose>
							<c:when test="${not empty item.bestRelaunch.username}">
								<b>&euro; <span id="idAmount"><fmt:formatNumber  value="${item.bestRelaunch.amount}"
										maxFractionDigits="2" /></span></b>
								(<span id="idUsername"><b >${item.bestRelaunch.username}</b></span> 
								 <span id="idDate"><fmt:formatDate
										 value="${item.bestRelaunch.date}" pattern="dd/MM/yyyy HH:mm:ss" /></span>)
								</c:when>
								<c:otherwise>
									Nessun rilancio, il tuo pu� essere il primo!
								</c:otherwise>
								</c:choose>
								</td>
						</tr>
						<!-- END SUBSTITUTE BY AJAX -->
						
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
							<td>	
									<button class="button login">Rilancia</button>
							</td>
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
									</c:forEach>
								</tr>
						</tbody>
					</table>

				</div>
				</c:if>
		</div>
		<div class="inner">&nbsp;</div>
		<div class="section2" style="background-color: #F8F8F8;">
			<div class="inner">
				<c:if test="${not empty item.relaunches}">
					<div class="pageTitle" style="font-size:24px;margin-left:24px;"> Storico rilanci</div>
					<div class="inner">
						<table class="commonOverride registrationPage"
							style="border: 1px solid #F8F8F8">
							<tbody>
								<c:forEach items="${item.relaunches}" var="relaunch"
									varStatus="status">
									<tr>
										<td width="45%"><fmt:formatDate
										 			value="${relaunch.date}" pattern="dd/MM/yyyy HH:mm:ss" /> </td>
											
										<td width="49%"> ${relaunch.username} </td>
											<td> <b>&euro;
										 	<fmt:formatNumber  value="${relaunch.amount}" maxFractionDigits="2" /></b></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</div>
		</div>

	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
