package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.repository.ItemRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("astaService")
public class AstaServiceImpl implements AstaService{

  @Autowired(required=true)
  private ItemRepository itemRepository;

  @Transactional
  public Item saveItem(Item item) {
      return itemRepository.save(item);
  }

  public Item findItemByName(String name) {  
	  Item item = itemRepository.findByName(name);
      return item;       
  }

  public List<Item> findAllItem() {
	  List<Item> list = itemRepository.findAll();


      return list;
  }



}
