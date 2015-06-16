package it.astaweb.schedule;

import it.astaweb.model.Item;
import it.astaweb.model.ItemNews;
import it.astaweb.service.AstaService;
import it.astaweb.service.EmailService;
import it.astaweb.service.PropertyService;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.ItemNewsStatus;
import it.astaweb.utils.ItemStatus;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ItemProcess implements Serializable {
	
	private static final long serialVersionUID = 1321092592770467192L;
	
	private static final Log LOG = LogFactory.getLog(ItemProcess.class);

	
	@Autowired
	AstaService astaService;
	
	@Autowired
	EmailService emailService;
	
	@Autowired
	PropertyService propertyService;
	
	/*
	 * Variabili portate fuori
	 */
	private List<Item> itemPreSell;
	private List<Item> itemOnSell;
	private List<ItemNews> news;
	private Date now;
	
	public ItemProcess() {
	}
	
	@Scheduled(fixedRate=60000)
	public void presellTosell(){		
		
		itemPreSell =  astaService.findAllItemByStatus(ItemStatus.PRE_SELL);
		
		LOG.info("Oggetti in pre-vendita **********************************");
		for (Iterator<Item> iterator = itemPreSell.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			LOG.info(item);
			if(item.getFromDate().before(CalendarUtils.currentTimeInItaly()) &&
					item.getExpiringDate().after(CalendarUtils.currentTimeInItaly())){
				LOG.info("L'oggetto " + item + " è appena stato messo in vendita");
				item.setStatus(ItemStatus.ON_SELL);
				astaService.updateItem(item);
				try {
					emailService.sendOnSell(item);
				} catch (Exception e) {
					System.out.println("Errore nell'invio della mail " + e.getMessage());
				}
			}
			
		}
		LOG.info("Fine Oggetti in pre-vendita **********************************\n");
		
		itemOnSell =  astaService.findAllItemByStatus(ItemStatus.ON_SELL);
		
		LOG.info("Oggetti in vendita **********************************");
		for (Iterator<Item> iterator = itemOnSell.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			LOG.info(item);
			Date now = CalendarUtils.currentTimeInItaly();
			if(item.getExpiringDate().before(now)){
				long diff = (now.getTime() - item.getExpiringDate().getTime())/1000;
				//Se la differenza è inferiore a 30 secondi, per evitare conflitti con eventuali rilanci, lascio perdere
				if(diff<=30){
					System.out.println("L'oggetto " + item + " è scaduto da meno di 30 secondi, lo lascio in vendita per evitare sovrapposizioni coi rilanci");
					continue;
				}
				astaService.setExpired(item);
				
			}
			
		}
		LOG.info("Fine Oggetti in vendita **********************************");
		Runtime.getRuntime().gc();
	}
	
	@Scheduled(fixedRate=60000,initialDelay=30000)
	public void sendItemNews(){	
		
		news = astaService.findAllItemNews();
		now = CalendarUtils.currentTimeInItaly();
		
		for (Iterator<ItemNews> iterator = news.iterator(); iterator.hasNext();) {
			ItemNews itemNews = iterator.next();
			
			if(itemNews.getItem().getExpiringDate().before(now) && itemNews.getStatus()!= ItemNewsStatus.SENT){
				sendNews(itemNews, now, true);
			}else{
				if(itemNews.getStatus()== ItemNewsStatus.TO_SEND ||itemNews.getStatus()== ItemNewsStatus.TO_SEND_AGAIN){
					sendNews(itemNews, now, false);
				}
			}
			
		}
		
		Runtime.getRuntime().gc();
		
	}

	private void sendNews(ItemNews itemNews, Date now, boolean expired) {
		try {
			if(expired){
				
				emailService.sendExpired(itemNews);
			}else{
				emailService.sendRelaunch(itemNews);
			}
			itemNews.setSentDate(now);
			itemNews.setStatus(ItemNewsStatus.SENT);
			astaService.saveItemNews(itemNews);
		} catch (Exception e) {
			System.err.println(e.getMessage());
			itemNews.setStatus(ItemNewsStatus.TO_SEND_AGAIN);
			astaService.saveItemNews(itemNews);
		}
	}
	
	
//	@Scheduled(cron="*/5 * * * * MON-FRI")
//	public void mostrarLogin(){
//		String user = System.getProperty("user.name");
//		String so = System.getProperty("os.name");
//		LOG.info("Usuario: " + user +
//				", S.O.: " + so +
//				", Hora: " + new Date());
//	}

}
