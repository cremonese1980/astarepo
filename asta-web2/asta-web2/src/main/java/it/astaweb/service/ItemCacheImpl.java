package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.repository.ItemRepository;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service("itemCache")
public class ItemCacheImpl implements ItemCache {
	
	private BigDecimal totalOffer;
	
	Map<Integer, Item> itemCache;
	
	@Autowired(required = true)
	private ItemRepository itemRepository;
	
	@PostConstruct
	private void init(){
		totalOffer = itemRepository.getTotalOffer();
		
		refresh();
		
	}
	
	

	private void initDb(List<Item> itemList,
			Map<Integer, Item> itemCache) {
		
		for (Iterator<Item> iterator = itemList.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			
			if(itemCache.get(item.getId())==null){
				itemCache.put(item.getId(), item);
			}
			
		}
		
	}

	@Override
	public BigDecimal getTotalOffer() {
		return this.totalOffer;
	}

	@Override
	public void saveItem(Item item) {
		if(item.getBestRelaunch()!=null && item.getBestRelaunch().getId()==null){
			item.setBestRelaunch(null);
		}
		itemRepository.save(item);		
		refresh();

	}

	@Override
	public List<Item> findAllItem(Sort sort) {
		
		List<Item> itemList = new ArrayList<Item>(itemCache.values());
		
		Collections.sort(itemList);
		return itemList;
	}

	@Override
	public void deleteItem(Integer id) {
		itemRepository.delete(id);
		refresh();

	}

	@Override
	public Item findItemById(Integer id) {
		
		return itemCache.get(id);
	}

	@Override
	public List<Item> findAllItemByStatus(ItemStatus status) {

		List<Item> itemList = new ArrayList<Item>();
		
		for (Iterator<Integer> iterator = itemCache.keySet().iterator(); iterator.hasNext();) {
			Integer id = iterator.next();
			
			Item item = itemCache.get(id);
			
			if(item.getStatus()==status){
				itemList.add(item);
				
			}
			
		}
		Collections.sort(itemList);
		return itemList;
	}

//	@Override
//	public List<Item> findAllItemByStatusJoinImages(ItemStatus status) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public Item findItemByIdAndFetchImagesFetchRelaunches(Integer id) {
		return itemCache.get(id);
	}



	@Override
	public synchronized void refresh() {
		itemCache = Collections.synchronizedMap(new HashMap<Integer, Item>());
		List<Item> itemList = itemRepository.findAllJoinImagesJoinRelaunches();		
		initDb(itemList, itemCache);
		
	}

}
