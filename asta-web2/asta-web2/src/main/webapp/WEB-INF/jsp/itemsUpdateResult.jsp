<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<input type="hidden" id="itemMessage" value="${itemMessage}"/>
<input type="hidden" id="updatedItemList" value="${updatedItemList}"/>
<input type="hidden" id="updPageLife" value="${pageLife}"/>
<input type="hidden" id="updIdList" value="${idList}"/>


<c:forEach items="${updatedItemList}" var="item">
	
	<input type="hidden" id="updItem${item.id}" value="${item.id}"/>
	<input type="hidden" id="updUsername${item.id}" value="${item.bestRelaunch.username}"/>
	<input type="hidden" id="updDate${item.id}" value="<fmt:formatDate value="${item.bestRelaunch.date}" 
											pattern="dd/MM/yyyy HH:mm:ss"/>"/>
	<input type="hidden" id="updAmount${item.id}" value="${item.bestRelaunch.amount}"/>
	<input type="hidden" id="updExpiringDate${item.id}" value="<fmt:formatDate value="${item.expiringDate}" 
											pattern="dd/MM/yyyy HH:mm:ss"/>"/>


</c:forEach>