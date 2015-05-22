<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="section1">
	<div class="inner">	
		<span class="questions">Domande?</span>
		<span class="phone">02 123456 <em>(9- 18, Lun - Ven)</em></span>		
		<span class="mail"><a href="mailto:info@crewroom.it" style="color: #fff">info@crewroom.it</a></span>
		<span class="clear"></span>
	</div>
</div>
<div class="section2">
		<div class="inner estimated isDesktop"></div>
	<div class="inner">
		<div class="socialShare">
			<a class="facebook" href='linkFace' target="_blank">&#xF09A;</a>
			<a class="twitter" href='link tw' target="_blank">&#xF099;</a>    
		</div>	
		<div class="links">
			<c:url var="url" value="/index.html" /> 
			<a href="${url}">Home</a> &nbsp;&nbsp;|&nbsp;&nbsp;
			<c:url var="url" value="/results.htm" /> 
			<a href="${url}">Results</a> &nbsp;&nbsp;|&nbsp;&nbsp;
			<c:url var="url" value="/becomeAPartner.htm" /> 
			<a href="${url}">Become a Partner</a>
		</div>	
		<div class="logos isDesktop">
			
		</div>
		<div class="info">
			Info
			
		</div>
	</div>
</div>
