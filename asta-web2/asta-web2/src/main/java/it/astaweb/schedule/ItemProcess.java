package it.astaweb.schedule;

import it.astaweb.model.Item;
import it.astaweb.service.AstaService;
import it.astaweb.service.EmailService;
import it.astaweb.service.PropertyService;
import it.astaweb.utils.CalendarUtils;
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

	public ItemProcess() {
	}
	
	@Scheduled(fixedRate=60000)
	public void presellTosell(){		
		
		List<Item> itemPreSell =  astaService.findAllItemByStatus(ItemStatus.PRE_SELL);
		
		LOG.info("Oggetti in pre-vendita **********************************");
		for (Iterator<Item> iterator = itemPreSell.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			LOG.info(item);
			if(item.getFromDate().before(CalendarUtils.currentTimeInItaly())){
				LOG.info("L'oggetto " + item + " è appena stato messo in vendita");
				item.setStatus(ItemStatus.ON_SELL);
				astaService.updateItem(item);
			}
			
		}
		LOG.info("Fine Oggetti in pre-vendita **********************************\n");
		
		List<Item> itemOnSell =  astaService.findAllItemByStatus(ItemStatus.ON_SELL);
		
		LOG.info("Oggetti in vendita **********************************");
		for (Iterator<Item> iterator = itemOnSell.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			LOG.info(item);
			Date now = CalendarUtils.currentTimeInItaly();
			if(item.getExpiringDate().before(now)){
				long diff = (now.getTime() - item.getExpiringDate().getTime())/1000;
				//Se la differenza è inferiore a 30 secondi, per evitare conflitti con eventuali rilanci, lascio perdere
				if(diff<=30){
					LOG.info("L'oggetto " + item + " è scaduto da meno di 30 secondi, lo lascio in vendita per evitare sovrapposizioni coi rilanci");
					continue;
				}
				astaService.setExpired(item);
			}
			
		}
		LOG.info("Fine Oggetti in vendita **********************************");
	}
	
//	@Scheduled(fixedRate=20000)
//	public void soldout(){		
//		
//		
//		List<Item> itemPreSell =  astaService.findAllItemByStatus(ItemStatus.ON_SELL);
//		
//		LOG.info("Oggetti in vendita **********************************");
//		for (Iterator<Item> iterator = itemPreSell.iterator(); iterator.hasNext();) {
//			Item item = iterator.next();
//			LOG.info(item);
//			if(item.getExpiringDate().before(new Date())){
//				LOG.info("L'oggetto " + item + " è appena scaduto");
//				if(item.getBestRelaunch()!=null && item.getBestRelaunch().compareTo(item.getBaseAuctionPrice())>=0){
//					LOG.info("Venduto!");
//					item.setStatus(ItemStatus.SOLD_OUT);
//				}else{
//					/* TODO gestire gli invenduti..
//					 */
//					LOG.info("Non venduto... :( ");
//					item.setStatus(ItemStatus.PRE_SELL);
//				}
//				astaService.updateItem(item);
//			}
//			
//		}
//		LOG.info("Fine Oggetti in vendita **********************************");
//	}
	
//	@Scheduled(cron="*/5 * * * * MON-FRI")
//	public void mostrarLogin(){
//		String user = System.getProperty("user.name");
//		String so = System.getProperty("os.name");
//		LOG.info("Usuario: " + user +
//				", S.O.: " + so +
//				", Hora: " + new Date());
//	}

}
