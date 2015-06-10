package it.astaweb.service;

import it.astaweb.model.ItemNews;
import it.astaweb.repository.ConfigurationRepository;
import it.astaweb.repository.ItemNewsRepository;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.PostConstruct;

import org.hibernate.annotations.Synchronize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("observeService")
public class ObserveServiceImpl implements ObserveService{
	
	private static Map<String, String> toVerifyCodes;
	private static Map<String, String> verifiedCodes;
	
	private static Random random;
	
	@Autowired(required = true)
	private ConfigurationRepository configurationRepository;
	
	@Autowired(required = true)
	private ItemNewsRepository itemNewsRepository;
	
	@Autowired(required = true)
	private AstaService astaService;
	
	@Autowired(required = true)
	EmailService emailService;
	
	@PostConstruct
	public void init(){
		random = new Random();
		toVerifyCodes = new HashMap<String, String>();
		verifiedCodes = new HashMap<String, String>();
	}
	
	@Override
	public String sendCode(String iditem, String email) {
		
		ItemNews itemNews = itemNewsRepository.findNewsByItem(Integer.parseInt(iditem));
		
		if(itemNews.getCcList().contains(email)){
			return "L'indirizzo email "  + email + " sta già osservando questo oggetto";
		}

		String code = generateCode();
		String result = "ok";
		
		try {
			emailService.sendCode(astaService.findItemById(Integer.parseInt(iditem)),email,code);
			toVerifyCodes.put(email, code);
			
		} catch (Exception e) {
			e.printStackTrace();
			result = e.getMessage();
		}
		
		return result;
	}

	@Override
	public synchronized String observe(String iditem, String email, String code) {
		
		
		String codeToVerify = toVerifyCodes.get(email);
		
		if(codeToVerify == null || code == null || !codeToVerify.equals(code.trim())){
			return "Codice errato, riprova";
		}
		
		toVerifyCodes.remove(email);
		verifiedCodes.put(email, code);
		
		ItemNews itemNews = itemNewsRepository.findNewsByItem(Integer.parseInt(iditem));
		itemNews.setCcList(itemNews.getCcList() + "," + email);
		itemNewsRepository.save(itemNews);
		
		return "ok";
		
	}


	@Override
	public String forget(String iditem, String email, String code) {
		return "ko";
		
	}

	private static String generateCode() {
		int randomInt = random.nextInt(99999);		
		String code = "" +randomInt;
		int len = code.length();
		String res = "";
		
		for (int i = len; i < 5; i++) {
			res+="0";
		}
		return res + code;
		
	}

	
	
	

}
