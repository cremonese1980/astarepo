package it.astaweb.service;


public interface ObserveService {
	
	String sendCode(String iditem, String email);

	String observe(String iditem, String email, String code);
	
	String forget(String iditem, String email, String code);
	
}
