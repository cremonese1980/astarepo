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
		<div class="welcomeUser">
				<c:if test="${not empty user.name}">Ciao ${user.name}!</c:if>
		</div>
		
		<div class="links">
			<a style="font-size:12px" href="loginAdmin.html">Admin</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="index.html">Home |</a>
			<a href="itemlist.html"> Asta</a>
		</div>
		<div style="clear:both;"></div>
	</div>
</div>

<div class="section2">
	<div class="inner">
		<div class="welcomeUser">
			Totale raccolto &euro; ${astaService.totalOffers}
		</div>
	</div>
	
	<div class="sectionNews">
	</div>
</div>