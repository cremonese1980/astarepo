<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<div class="section1">
	<div class="inner">
		<div class="welcomeUser">
			<c:choose>
				<c:when test="${not empty user.name}">Ciao ${user.name}!</c:when>
				<c:otherwise><c:if test="${not empty player.name}">Ciao ${player.name}!</c:if></c:otherwise>
			</c:choose>
		</div>
		
		<div class="links">
			<a href="index.html">Home |</a>
			<a href="loginAdmin.html">Admin |</a>
			<a href="itemlist.html">Asta</a>
		</div>
		<div style="clear:both;"></div>
	</div>
</div>

<div class="section2">
	<div class="inner">
		<div class="welcomeUser">
			Totale raccolto &euro;: ${astaService.totalOffers}
		</div>
	</div>
</div>