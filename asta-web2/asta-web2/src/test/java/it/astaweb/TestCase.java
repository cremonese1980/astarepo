package it.astaweb;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.ResourceBundleMessageSource;

public abstract class TestCase {
	
	protected static final Log LOG = LogFactory.getLog(TestCase.class);
	
	protected static ApplicationContext ac = null;
	
//	private static SingletonBeanFactory factory;
	
	static {
		
		
	}
	
	public static void close() {
	}
	
	/**
	 * @return the springContext
	 */
	public static void main(String[] args) {
		ac = new ClassPathXmlApplicationContext(
                "it/astaweb/servletConfig.xml");
		ResourceBundleMessageSource ms =(ResourceBundleMessageSource)  ac.getBean("messageSource");
		
		System.out.println(ms.getClass());
		
	}
	
}
