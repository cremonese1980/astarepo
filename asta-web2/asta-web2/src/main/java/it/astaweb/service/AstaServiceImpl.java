package it.astaweb.service;

import it.astaweb.exceptions.ObjectExpiredException;
import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.Relaunch;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.repository.ItemRepository;
import it.astaweb.repository.RelaunchRepository;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.Constants;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.persistence.metamodel.StaticMetamodel;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
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
	
	@Autowired
	PropertyService propertyService;
	
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
		relaunchRepository.delete(item.getRelaunches());
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
	public List<Item>  findAllItemByStatusJoinImages(ItemStatus status) {
		return itemRepository.findAllByStatusJoinImages(status);
		
	}

	@Override
	@Transactional
	public synchronized void relaunch(Relaunch relaunch) throws ObjectExpiredException {
		
		long diff = (relaunch.getItem().getExpiringDate().getTime() - relaunch.getDate().getTime())/1000;
		//Se l'oggetto è scaduto, cambio lo stato sul db. Il metodo è sincronizzato, e il processo non cambia stato se l'oggetto è scaduto da meno di 30 secondi.
		if(diff<0){
			setExpired(relaunch.getItem());
			throw new ObjectExpiredException();
		}
		
		BigDecimal delta = relaunch.getItem().getBestRelaunch()!=null? relaunch.getAmount().subtract(relaunch.getItem().getBestRelaunch()):relaunch.getAmount();		
		relaunch.getItem().setBestRelaunch(relaunch.getAmount());
		
		//Se il rilancio è avvenuto negli ultimi 3 minuti, l'asta viene protratta di ulteriori 3 minuti.
		long postpone = Long.parseLong(propertyService.getValue(Constants.PROPERTY_RELAUNCH_POSTPONE_SECONDS.getValue()));
		if(diff<= postpone){
			Calendar calendar = new GregorianCalendar();
			calendar.setTime(relaunch.getItem().getExpiringDate());
			calendar.add(Calendar.SECOND, (int)postpone);
			relaunch.getItem().setExpiringDate(calendar.getTime());
			System.out.println("Scadenza oggeto " + relaunch.getItem()  + " prolungata di 3 minuti");
		}
		
		itemRepository.save(relaunch.getItem());
		relaunchRepository.save(relaunch);
		
		updateTotal(delta);
		
	}

	@Override
	public synchronized  void setExpired(Item item) {
		LOG.info("L'oggetto " + item + " è appena scaduto...........");
		if(item.getBestRelaunch()!=null && item.getBestRelaunch().compareTo(item.getBaseAuctionPrice())>=0){
			LOG.info("...........Venduto!");
			item.setStatus(ItemStatus.SOLD_OUT);
		}else{
			LOG.info("...........Non venduto... :( \nAbbassiamo il prezzo del 20%");
			item.setStatus(ItemStatus.ON_SELL);
			item.setBaseAuctionPrice(item.getBaseAuctionPrice().multiply(new BigDecimal(0.8)));
			int minSellTime = Integer.parseInt(propertyService.getValue(Constants.PROPERTY_MIN_SELL_TIME_HOUR.getValue()));
			item.setExpiringDate(CalendarUtils.currentTimeInItalyAddHour(minSellTime));
		}
		updateItem(item);
	}

	@Override
	public BigDecimal getTotalOffers() {
		return totalOffer;
	}
	
	private synchronized void updateTotal(BigDecimal delta){
		totalOffer = totalOffer.add(delta);
	}

	@Override
	public Item findItemByIdAndFetchImagesFetchRelaunches(Integer id) {
		return itemRepository.findByIdAndFetchImagesFetchRelaunches(id);
	}

	@Override
	public Relaunch getBestRelaunch(Item item) {
		return relaunchRepository.getRelaunchesByItem(item.getId()).get(0);
	}
	

}
