package it.gab.asta.support.displaytag;

import java.util.Iterator;
import java.util.Map;

import org.springframework.webflow.core.collection.ParameterMap;
import org.springframework.webflow.core.collection.SharedAttributeMap;
import org.springframework.webflow.definition.StateDefinition;
import org.springframework.webflow.execution.FlowExecutionListenerAdapter;
import org.springframework.webflow.execution.RequestContext;
import org.springframework.webflow.execution.View;

/**
 * Listener utilizzato per la memorizzazione dei parametri di paging & sorting
 * della DisplayTag. Evita che i parametri rimangano in sessione e li sposta
 * nel contesto del flow, al fine di non riutilizzarli per sbaglio in pagine
 * differenti.
 */
public final class DisplayTagStatusExecutionListener extends FlowExecutionListenerAdapter {
	
	private final String PARAM_DISPLAY_STATUS = "_displayTagStatus_";
	
	//private final Log logger = LogFactory.getLog(this.getClass());
	
	@Override
	public void viewRendering(RequestContext context, View view, StateDefinition viewState) {
		restoreStatusInSession(context);
	}

	@Override
	public void viewRendered(RequestContext context, View view,	StateDefinition viewState) {
		backupStatusInFlow(context);
	}
	
	/**
	 * Verifica se esistono i parametri della DisplayTag nella request: se
	 * presenti anche nella sessione allora li rimuove, effettuandone un
	 * backup nel contesto del flow. 
	 */
	private void backupStatusInFlow(RequestContext context) {
		DisplatTagStatus status = null;
		// Ricava gli attributi in sessione
		ParameterMap requestParams = context.getRequestParameters();
		SharedAttributeMap sessionAttrs = context.getExternalContext().getSessionMap();
		// Si cercano i parametri della taglib nella request
		for (Iterator<?> iterator = requestParams.asMap().keySet().iterator(); iterator.hasNext();) {
			String attrKey = (String)iterator.next();
			if (DisplatTagStatus.matchParameterName(attrKey)) {
				// Rimuove, se presente, l'attributo dalla sessione
				Object param = sessionAttrs.extract(attrKey);
				if (param != null) { 
					if (status == null) {
						status = new DisplatTagStatus();
					}
					// Aggiunge l'attributo allo status
					status.addParameter(attrKey, param);
				}
			}
		}
		// Se esisteva uno stato in sessione, allora lo memorizza nel flow
		if (status != null) {
			context.getFlowScope().put(PARAM_DISPLAY_STATUS, status);
			/*if (logger.isDebugEnabled()) {
				logger.debug("Backup " + PARAM_DISPLAY_STATUS + "=" + status.getParameters());
			}*/
		}
	}
	
	/**
	 * Verifica se esiste il backup di uno stato della DisplayTag nel flow:
	 * in tal caso ripristina i parametri nella sessione. 
	 */
	private void restoreStatusInSession(RequestContext context) {
		DisplatTagStatus status = (DisplatTagStatus)context.getFlowScope().get(PARAM_DISPLAY_STATUS);
		if (status != null) {
			Map<String, Object> params = status.getParameters();
			/*if (logger.isDebugEnabled()) {
				logger.debug("Restore " + PARAM_DISPLAY_STATUS + "=" + params);
			}*/
			SharedAttributeMap sessionAttrs = context.getExternalContext().getSessionMap();
			for (Iterator<String> iterator = params.keySet().iterator(); iterator.hasNext();) {
				String paramName = (String)iterator.next();
				sessionAttrs.put(paramName, params.get(paramName));
			}
		}
	}
}
