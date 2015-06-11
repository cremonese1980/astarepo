<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>


.sectionNews {
  
  border: 1px dotted #DDDDDD;
  float: right;
  margin: 20px;
  margin-right: 150px;
  width: 300px;
  height: 130px;
}

	 
}
</style>

<div class="section1">
	<div class="inner">
		<div class="welcomeUser links">
				<c:if test="${not empty user.name}">
					Ciao ${user.name} !&nbsp;&nbsp;
					<a href="logout.html">Logout</a>
					
				</c:if>
		</div>
		
		<div class="links">
			<c:url var="urlIcon" value="img/public/auction_ico2.png" />
			<a href="itemlist.html"><img title="Vai all'asta!" style="width:30px" src="${urlIcon}"/> Asta</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="index.html">Home</a> | 
			<a style="font-size:12px" href="loginAdmin.html">Admin</a>
		</div>
		<div style="clear:both;"></div>
	</div>
</div>

<div class="section2">
	<div class="inner">
		<div class="welcomeUser">
			Totale raccolto &euro; <fmt:formatNumber value="${astaService.totalOffers}"
									  maxFractionDigits="2" />
		</div>
	</div>
	
	<div class="sectionNews">
	</div>
</div>