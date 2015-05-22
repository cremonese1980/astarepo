package it.astaweb.repository;

import it.astaweb.model.Item;
import it.astaweb.repository.ItemRepository;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

//@ContextConfiguration(locations={"classpath:/it/astaweb/servletConfig.xml"})

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:servletConfig.xml"})
@WebAppConfiguration
public class ItemRepositoryTest {
	
	
	private  ItemRepository itemRepository;
	
	@Autowired(required=true)
	private ApplicationContext applicationContext;
	
	

	@org.junit.Before
	public void setUp() throws Exception {
		itemRepository = (ItemRepository)applicationContext.getBean("itemRepository");
	}

	@Test
	public void testFindByName() {
		Item item = itemRepository.findByName("");
		assert("martello".equals(item.getName()));
//		fail("Not yet implemented");
	}

	@Test
	public void testFindAll() {
//		fail("Not yet implemented");
	}

	@Test
	public void testSaveIterableOfS() {
//		fail("Not yet implemented");
	}

	@Test
	public void testSaveAndFlush() {
//		fail("Not yet implemented");
	}


}
