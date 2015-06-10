package it.astaweb.service;

import it.astaweb.exceptions.ObjectExpiredException;
import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.ItemNews;
import it.astaweb.model.Relaunch;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.repository.ItemNewsRepository;
import it.astaweb.repository.ItemRepository;
import it.astaweb.repository.RelaunchRepository;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.Constants;
import it.astaweb.utils.ItemNewsStatus;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
	private static final String DATE_PATTERN = "dd/MM/yyyy HH:mm:ss";

	@Autowired(required = true)
	private ItemRepository itemRepository;

	@Autowired(required = true)
	private ItemImageRepository itemImageRepository;
	
	@Autowired(required = true)
	private RelaunchRepository relaunchRepository;
	
	@Autowired(required = true)
	private ItemNewsRepository itemNewsRepository;
	
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
		boolean addNews = item.getId()==null ? true:false;
		itemRepository.save(item);
		
		if(addNews){
			itemNewsRepository
					.save(new ItemNews(propertyService
							.getValue(Constants.PROPERTY_BC_LIST_BASE
									.getValue()), item));
		}
		
		return item;
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
		itemNewsRepository.deleteByItem(item.getId());
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
		
		BigDecimal delta = relaunch.getItem().getBestRelaunch() != null ? relaunch
				.getAmount().subtract(relaunch.getItem().getBestRelaunch().getAmount())
				: relaunch.getAmount();		
		relaunch.getItem().setBestRelaunch(relaunch);
		
		//Se il rilancio è avvenuto negli ultimi 3 minuti, l'asta viene protratta di ulteriori 3 minuti.
		long postpone = Long.parseLong(propertyService.getValue(Constants.PROPERTY_RELAUNCH_POSTPONE_SECONDS.getValue()));
		if(diff<= postpone){
			Calendar calendar = new GregorianCalendar();
			calendar.setTime(relaunch.getItem().getExpiringDate());
			calendar.add(Calendar.SECOND, (int)postpone);
			relaunch.getItem().setExpiringDate(calendar.getTime());
			System.out.println("Scadenza oggeto " + relaunch.getItem()  + " prolungata di 3 minuti");
		}
		
		relaunchRepository.save(relaunch);
		itemRepository.save(relaunch.getItem());
		
		setNewsToBeSent(relaunch.getItem());
		
		updateTotal(delta);
		
	}

	private void setNewsToBeSent(Item item) {
		ItemNews itemNews = itemNewsRepository.findNewsByItem(item.getId());
		itemNews.setStatus(ItemNewsStatus.TO_SEND);
		itemNewsRepository.save(itemNews);
	}

	@Override
	@Transactional
	public synchronized  void setExpired(Item item) {
		LOG.info("L'oggetto " + item + " è appena scaduto...........");
		if(item.getBestRelaunch()!=null && item.getBestRelaunch().getAmount()!=null&&
				item.getBestRelaunch().getAmount().compareTo(item.getBaseAuctionPrice())>=0){
			LOG.info("...........Venduto!");
			item.setStatus(ItemStatus.SOLD_OUT);
			setNewsToBeSent(item);
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

	@Override
	public String getTestPhaseMessage() {
		
		DateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
		
		Date now = CalendarUtils.currentTimeInItaly();
		Calendar calendar = new GregorianCalendar();
		calendar.set(2015, Calendar.JUNE, 16, 21, 0,0);
		
		if(now.before(calendar.getTime())){
			return "Fase di test senza nessun valore, se non quello di un prezioso aiuto, " +
					"che terminerà in data " + dateFormat.format(calendar.getTime()) + ". Grazie!";
		}
		
		return "";
	}
	

}
