package it.astaweb;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.access.BeanFactoryLocator;
import org.springframework.beans.factory.access.BeanFactoryReference;
import org.springframework.context.access.ContextSingletonBeanFactoryLocator;

public final class SingletonBeanFactory implements DisposableBean {
	
	private final Map<String, BeanFactoryReference> cache;
	
	public SingletonBeanFactory() {
		this.cache = new HashMap<String, BeanFactoryReference>();
	}
	
	@Override
	public void destroy() {
		Collection<BeanFactoryReference> values;
		synchronized (cache) {
			/* create a copy of the cached values */
			values = new ArrayList<BeanFactoryReference>(cache.values());
			/* clear the cache */
			cache.clear();
		}
		/* release all the bean factory references */
		for (BeanFactoryReference reference : values)
			reference.release();
	}
	
	public BeanFactory getBeanFactory(String factoryKey) {
		BeanFactoryReference reference;
		synchronized (cache) {
			reference = cache.get(factoryKey);
			if (reference == null) {
				BeanFactoryLocator locator = ContextSingletonBeanFactoryLocator.getInstance();
				reference = locator.useBeanFactory(factoryKey);
				cache.put(factoryKey, reference);
			}
		}
		return reference.getFactory();
	}
	
}

