package it.astaweb.schedule;

import it.astaweb.model.Item;
import it.astaweb.service.AstaService;
import it.astaweb.service.EmailService;
import it.astaweb.utils.ItemStatus;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ItemProcess implements Serializable {
	private static final long serialVersionUID = 1321092592770467192L;
	
	@Autowired
	AstaService astaService;
	
	@Autowired
	EmailService emailService;

	public ItemProcess() {
//		System.out.println("EjemploSchedule construido");
	}
	
	@Scheduled(fixedRate=300000)
	public void presellTosell(){		
		
		List<Item> itemPreSell =  astaService.findAllItemByStatus(ItemStatus.PRE_SELL);
		
		System.out.println("Oggetti in pre-vendita **********************************");
		for (Iterator<Item> iterator = itemPreSell.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			System.out.println(item);
			if(item.getFromDate().before(new Date())){
				System.out.println("L'oggetto " + item + " è appena stato messo in vendita");
				item.setStatus(ItemStatus.ON_SELL);
				astaService.updateItem(item);
			}
			
		}
		System.out.println("Fine Oggetti in pre-vendita **********************************");
	}
	
	@Scheduled(fixedRate=20000)
	public void soldout(){		
		
		emailService.send();
		
		List<Item> itemPreSell =  astaService.findAllItemByStatus(ItemStatus.ON_SELL);
		
		System.out.println("Oggetti in vendita **********************************");
		for (Iterator<Item> iterator = itemPreSell.iterator(); iterator.hasNext();) {
			Item item = iterator.next();
			System.out.println(item);
			if(item.getExpiringDate().before(new Date())){
				System.out.println("L'oggetto " + item + " è appena scaduto");
				if(item.getBestRelaunch()!=null && item.getBestRelaunch().compareTo(item.getBaseAuctionPrice())>=0){
					System.out.println("Venduto!");
					item.setStatus(ItemStatus.SOLD_OUT);
				}else{
					/* TODO gestire gli invenduti..
					 */
					System.out.println("Non venduto... :( ");
					item.setStatus(ItemStatus.PRE_SELL);
				}
				astaService.updateItem(item);
			}
			
		}
		System.out.println("Fine Oggetti in vendita **********************************");
	}
	
//	@Scheduled(cron="*/5 * * * * MON-FRI")
//	public void mostrarLogin(){
//		String user = System.getProperty("user.name");
//		String so = System.getProperty("os.name");
//		System.out.println("Usuario: " + user +
//				", S.O.: " + so +
//				", Hora: " + new Date());
//	}

}
