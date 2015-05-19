package it.gab.asta.web.context;

import it.gab.asta.support.displaytag.DisplayTagSupport;

import java.net.MalformedURLException;

/**
 * Container listener that startup/shutdown all the necessary application
 * components (like log factory).
 */
public final class WebServletListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent event) {
		// Free memory.
		// System.gc();

		String contextPath = getContextPath(event.getServletContext());
		DisplayTagSupport.setUserProperties(contextPath);
	}

	public void contextDestroyed(ServletContextEvent event) {
		// Realese logs
		ClassLoader contextClassLoader = Thread.currentThread().getContextClassLoader();
		LogFactory.release(contextClassLoader);

		// Free memory.
		System.gc();
	}

	/**
	 * Ricava il ContextPath della servlet a partire dalla URL.
	 * Il path e' ricavato come ultima parte della URL tra due slash. 
	 */
	private String getContextPath(ServletContext ctx) {
		String path;
		try {
			path = ctx.getResource("/").getPath();
		} catch (MalformedURLException e) {
			throw new RuntimeException(e);
		}
		int lastSlash = path.lastIndexOf("/");
		int prevSlash = path.lastIndexOf("/", lastSlash - 1);
		String contextPath = path.substring(prevSlash, lastSlash + 1);
		return contextPath;
	}
}
