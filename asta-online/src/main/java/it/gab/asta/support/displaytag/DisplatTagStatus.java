package it.gab.asta.support.displaytag;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Riconosce e memorizza i parametri di paging & sorting della DisplayTag.
 */
public final class DisplatTagStatus implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private static final Pattern paramPattern = Pattern.compile("d-\\d+-[ops]");
	
	HashMap<String, Object> statusParams = new HashMap<String, Object>();
	
	public static boolean matchParameterName(String str) {
		return paramPattern.matcher(str).matches();
	}

	public void addParameter(String paramName, Object paramValue) {
		statusParams.put(paramName, paramValue);
	}
	
	public Map<String, Object> getParameters() {
		return statusParams;
	}
}
