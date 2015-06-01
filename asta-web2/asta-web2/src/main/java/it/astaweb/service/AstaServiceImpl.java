package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.Relaunch;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.repository.ItemRepository;
import it.astaweb.repository.RelaunchRepository;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("astaService")
public class AstaServiceImpl implements AstaService {
	
	private static final Log LOG = LogFactory.getLog(AstaServiceImpl.class);

	@Autowired(required = true)
	private ItemRepository itemRepository;

	@Autowired(required = true)
	private ItemImageRepository itemImageRepository;
	
	@Autowired(required = true)
	private RelaunchRepository relaunchRepository;
	
	private BigDecimal totalOffer;
	
	@PostConstruct
	private void init(){
		
		totalOffer = itemRepository.getTotalOffer(); 				
		totalOffer = totalOffer == null? new BigDecimal(0): totalOffer;
		System.out.println("AstaService inizializzato con un total offer = € " + totalOffer.doubleValue());
		LOG.info("AstaService inizializzato con un total offer = € " + totalOffer.doubleValue());
	}

	@Transactional
	public Item saveItem(Item item) {
		return itemRepository.save(item);
	}

	public Item findItemByName(String name) {
		Item item = itemRepository.findByName(name);
		return item;
	}

	public List<Item> findAllItem() {
		List<Item> list = itemRepository.findAll(new Sort(Direction.ASC, "name"));

		return list;
	}

	@Transactional
	@Override
	public void updateItem(Item item) {
		itemRepository.saveAndFlush(item);

	}

	@Transactional
	@Override
	public void addImage(ItemImage image) {
		itemImageRepository.save(image);
	}

	@Override
	public List<ItemImage> findAllImagesByItem(Integer idItem) {
		return itemImageRepository.findAllImagesByItem(idItem);
	}

	@Override
	public List<ItemImage> findAllImages() {
		return itemImageRepository.findAll();
	}

	
	@Override
	public Item findItemById(Integer id) {
		return itemRepository.findOne(id);
	}

	@Transactional
	@Override
	public void deleteItem(Item item) {
		itemImageRepository.delete(item.getImages());
		itemRepository.delete(item.getId());
		
	}

	@Override
	public Item findItemByIdAndFetchImages(Integer id) {
		return itemRepository.findByIdAndFetchImages(id);
	}

	@Transactional
	@Override
	public void deleteItemImage(ItemImage itemImage) {
		itemImageRepository.delete(itemImage.getId());
		
	}

	@Override
	public ItemImage findImageById(Integer id) {
		return itemImageRepository.findOne(id);
	}

	@Override
	public List<Item>  findAllItemByStatus(ItemStatus status) {
		return itemRepository.findAllByStatus(status);
		
	}

	@Override
	@Transactional
	public synchronized void relaunch(Item item, BigDecimal offer, Date now, String username) {
		
		BigDecimal delta = offer.subtract(item.getBestRelaunch());
		
		item.setBestRelaunch(offer);
		Relaunch relaunch = new Relaunch();
		relaunch.setDate(now);
		relaunch.setItem(item);
		relaunch.setUsername(username);
		
		itemRepository.save(item);
		relaunchRepository.save(relaunch);
		
		updateTotal(delta);
		
	}

	@Override
	public BigDecimal getTotalOffers() {
		return totalOffer;
	}
	
	private synchronized void updateTotal(BigDecimal delta){
		totalOffer.add(delta);
	}
	

}
