<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>

<html>
<head>
	
	<%-------------------------------------------------- TITLE --------------------------------------------------------%>
	
	<meta name="keywords" content="asta,benefica" />
	<meta name="description" content="Asta benefica per..." />
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width">
	
	<%-------------------------------------------------- INCLUDE CSS --------------------------------------------------------%>
	<%@ include file="includeCss.jsp" %>
	
	<%-------------------------------------------------- INCLUDE JAVASCRIPT --------------------------------------------------------%>
	<%@ include file="includeJavascript.jsp" %>
	
	
	<title>Asta Online</title>
	
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
			<span>Partecipa all'<strong>asta</strong>!</span>
			<em>Scegli un prodotto ${contextPath}</em>	
			
			<%-- ################################### CAROUSEL SLIDER ##################################### --%>
			<script type="text/javascript">
				var num = 0, scrollPartner = {};
				var setNum = function() {
					var wWidth = $(window).width();
					num = (wWidth>=620) ? Math.floor((wWidth - 150 )/191) : Math.floor((wWidth - 80 )/101);
					num = (num>5) ? 5 : num;
				};
				$(document).ready(function() {			
					setNum();
					scrollPartner = $(".support .carousel").scroller({
						scrollDirection: "horizontal",
		                scrollByElement: { tag: "li", showedNum: num, scrollNum: num, active: true }
					}).data("scroller");
					$(window).resize(function() {
						setNum();
						scrollPartner.options.scrollByElement.showedNum = num;
						scrollPartner.options.scrollByElement.scrollNum = num;
						scrollPartner.refreshScroller();
					});			
				});
			</script>	
			<c:set var="hpBanners" value="${itemlist}"/>
			<div class="carousel-container">
				<div class="carousel">
					<ul>
						<c:set var="slotCount" value="0" />
						<c:set var="carousel"><fmt:message key="public.carousel.order" /></c:set>
						<c:forEach items="${itemlist}" var="item">
									<li>
<%-- 										<c:set var="url" value="${f:getAffiliateSiteURL(dashboardService,hpBanners[slotCount])}" /> --%>
<%-- 										<c:url var="logoUrl" value="${onesite.logo}"/> --%>
<%-- 										<a href="${url}/lotto.htm"><img src="${logoUrl}" alt="${onesite.partnerName}" title="${onesite.partnerName}"/></a> --%>
<%-- 										<c:set var="slotCount" value="${slotCount+1}" /> --%>
											${item.name}
									</li>
<!-- 									<li> -->
<%-- 										<a href='<fmt:message key="public.carousel.${item}" />' target="_blank"><img src="${web}${domainInfoService.imgFolder}/carousel/${item}.png" /></a> --%>
<!-- 									</li> -->
						</c:forEach>
					</ul>
				</div>
			</div>	
		
	</div>

	<%-------------------------------------------------- FOOTER --------------------------------------------------------%>		
	<div id="wrapperFooter">
		<jsp:include page="footer.jsp" />
	</div>
</body>

</html>
