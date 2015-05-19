package it.gab.asta.support.displaytag;

import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.displaytag.properties.TableProperties;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;
import org.springframework.util.CollectionUtils;

/**
 * Display taglib utilities.
 */
public class DisplayTagSupport {

	// protected static final Log logger =
	// LogFactory.getLog(DisplayTagSupport.class);

	public final static String SORT_ORDER_DESCENDING = "DESC";

	public final static String SORT_ORDER_ASCENDING = "ASC";

	/** Default placeholder prefix: "${" */
	private static final String PLACEHOLDER_PREFIX = "${";

	/** Default placeholder suffix: "}" */
	private static final String PLACEHOLDER_SUFFIX = "}";

	/**
	 * Initialize the customized properties of the displaytag tag library. This
	 * class load the displaytag.properties file to allow a replacement of some
	 * of the display taglib properties.
	 * 
	 * @param contextPath	The web context path to locate resource.
	 */
	public static final Properties setUserProperties(String contextPath) {
		Properties props = new Properties();
		try {
			props.load(DisplayTagSupport.class.getResourceAsStream("displaytag.properties"));
			if (!CollectionUtils.isEmpty(props)) {
				for (Object key : props.keySet()) {
					String property = (String) props.getProperty(key.toString());
					// Verifica se la property contiene un qualunque placeholder
					if (StringUtils.isNotEmpty(property) && property.indexOf(PLACEHOLDER_PREFIX) >= 0) {
						String placeholder = PLACEHOLDER_PREFIX + "contextPath" + PLACEHOLDER_SUFFIX;
						property = property.replace((CharSequence)placeholder, (CharSequence)contextPath);
						props.setProperty(key.toString(), property);
					}
				}
			}
			TableProperties.setUserProperties(props);
			return props;
		} catch (Exception e) {
			throw new RuntimeException("Unable to load displaytag.properties", e);
		}
	}

	/**
	 * Restituisce il parametro della request che rappresenta la colonna di
	 * ordinamento selezionata, <code>null</code> se il parametro non e' stato
	 * impostato.
	 */
	public static final String getSortColumnParam(HttpServletRequest request,
			String tableId) {
		ParamEncoder paramEncoder = new ParamEncoder(tableId);
		String sortColumn = request.getParameter(paramEncoder.encodeParameterName(TableTagParameters.PARAMETER_SORT));
		return (StringUtils.isEmpty(sortColumn) ? null : sortColumn);
	}

	/**
	 * Restituisce il parametro della request che rappresenta il criterio di
	 * ordinamento selezionato, <code>null</code> se il parametro non e' stato
	 * impostato.
	 */
	public static final String getSortOrderParam(HttpServletRequest request,
			String tableId) {
		ParamEncoder paramEncoder = new ParamEncoder(tableId);
		String sortOrder = request.getParameter(paramEncoder.encodeParameterName(TableTagParameters.PARAMETER_ORDER));
		if (StringUtils.isNotEmpty(sortOrder)) {
			if ("1".equals(sortOrder)) {
				return SORT_ORDER_ASCENDING;
			}
			return SORT_ORDER_DESCENDING;
		}
		return null;
	}

	/**
	 * Restituisce il parametro della request che rappresenta il numero di
	 * pagina selezionato, <code>0</code> se il parametro non e' stato
	 * impostato.
	 */
	public static final Integer getPageNumber(HttpServletRequest request,
			String tableId) {
		ParamEncoder paramEncoder = new ParamEncoder(tableId);
		String pageNumber = request.getParameter(paramEncoder.encodeParameterName(TableTagParameters.PARAMETER_PAGE));
		if (StringUtils.isEmpty(pageNumber)) {
			return null;
		}
		return new Integer(pageNumber);
	}
}
