<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
	
	<%-------------------------------------------------- TITLE --------------------------------------------------------%>
	<title><template:get key="head.title">Asta Online!</template:get></title>
	
	<meta name="keywords" content="asta,benefica" />
	<meta name="description" content="Asta benefica per..." />
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width">
	
	<%-------------------------------------------------- INCLUDE CSS --------------------------------------------------------%>
	<%@ include file="includeCss.jsp" %>
	
	<%-------------------------------------------------- INCLUDE JAVASCRIPT --------------------------------------------------------%>
	<%@ include file="includeJavascript.jsp" %>
	
	
	<noscript><style>#wrapperMain .inner.opacity {opacity:1;} #loadingIcon {display:none;} #ticker {display:none;}</style></noscript>
	
	
</head>

<c:set var="cssMainClass"></c:set>
<body class="commonOverride ${cssMainClass}">
	
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
		<jsp:include page="header.html" />
	</div>	
	

	<div id="wrapperMain">		
						

		
	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>		
	<div id="wrapperFooter">
		<jsp:include page="footer.html" />
	</div>
</body>

</html>
