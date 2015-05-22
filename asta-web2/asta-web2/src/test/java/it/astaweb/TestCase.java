package it.astaweb;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public abstract class TestCase {
	
	protected static final Log LOG = LogFactory.getLog(TestCase.class);
	
	protected static final ApplicationContext springContext = null;
	
	private static SingletonBeanFactory factory = new SingletonBeanFactory();
	
	static {
//		springContext = new ClassPathXmlApplicationContext(
//                new String[]{"../../../../main/webapp/WEB-INF/config/servletConfig.xml"});
	}
	
	public static void close() {
		factory.destroy();
	}
	
	/**
	 * @return the springContext
	 */
	public static ApplicationContext getApplicationContext() {
		return springContext;
	}
	
	public static void main(String[] args) {
		
	}
	
}
