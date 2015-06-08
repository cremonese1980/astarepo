<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="section1">
	<div class="inner">	
		<span class="questions">Domande?</span>
		<span class="phone">02 123456 <em>(9- 18, Lun - Ven)</em></span>		
		<span class="mail"><a href="mailto:astaweb.server@gmail.com" style="color: #fff">astaweb.server@gmail.com</a></span>
		<span class="clear"></span>
	</div>
</div>
<div class="section2">
		<div class="inner estimated isDesktop"></div>
	<div class="inner">
		<div class="socialShare">
<!-- 			<a class="facebook" href='linkFace' target="_blank">&#xF09A;</a> -->
<!-- 			<a class="twitter" href='link tw' target="_blank">&#xF099;</a>     -->
		</div>	
		<div class="links">
			<c:url var="url" value="/index.html" /> 
			<a href="${url}">Home</a> &nbsp;&nbsp;|&nbsp;&nbsp;
			<c:url var="url" value="/results.html" /> 
			<a href="${url}">Risultati Asta</a> &nbsp;&nbsp;|&nbsp;&nbsp;
			<c:url var="url" value="/hello.html" /> 
			<a href="${url}">Ciao Rocco!</a>
		</div>	
		<div class="logos isDesktop">
			
		</div>
		<div class="info">In questo sito troverai elenco e foto dei
			dispositivi di protezione individuale di Rocco, potrai rilanciare per
			aggiudicarti molti di quelli che sono stati i suoi strumenti di
			lavoro. Precisiamo che i dpi in asta hanno valore affettivo e non
			sono da considerarsi materiale di sicurezza da utilizzare.
			L'iniziativa ha scopo benefico: il ricavato sarà interamente devoluto
			a Gabrio ed Alice.</div>
	</div>
</div>
