<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	<%@ include file="includeCss.jsp" %>
	
	<%-------------------------------------------------- INCLUDE JAVASCRIPT --------------------------------------------------------%>
	<%@ include file="includeJavascript.jsp" %>
	
	
	<title>Ciao Rocco!</title>
	
</head>

<body class="commonOverride becomeFundraiser support">
	
	<c:set var="showBackToTop"></c:set>
	<c:if test="${showBackToTop=='true'}">
		<div class="button backToTop">BACK TO TOP</div>
		<script>			
			$(".backToTop").on("click",function () {$("#wrapperMain").scrollToMe(500);});
	    	$(window).scroll(function(e) {
				if ($(window).scrollTop()>400) {$(".backToTop").fadeIn();
				} else {$(".backToTop").fadeOut();}
			});
		</script>			
	</c:if>
	
	
	<%-------------------------------------------------- HEADER --------------------------------------------------------%>
	<div id="wrapperHeader">		
		<jsp:include page="header.jsp" />
	</div>	
	

	<div id="wrapperMain">		
		<div class="inner support banner">
		
		</div>
		
	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>		
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
