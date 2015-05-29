package it.astaweb;

import it.astaweb.model.Item;
import it.astaweb.repository.ItemRepository;

import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

//@ContextConfiguration(locations={"classpath:/it/astaweb/servletConfig.xml"})

public class ItemRepositoryTest {
	

	private ItemRepository itemRepository;

	@org.junit.Before
	public void setUp() throws Exception {
		
		AnnotationConfigApplicationContext ac = new AnnotationConfigApplicationContext();
		ac.scan("it.astaweb");
		ac.refresh();
		
		
		itemRepository = (ItemRepository)ac.getBean("itemRepository");
		ac.close();
		
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
