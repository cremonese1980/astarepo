package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.repository.ItemRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("astaService")
public class AstaServiceImpl implements AstaService {

	@Autowired(required = true)
	private ItemRepository itemRepository;

	@Autowired(required = true)
	private ItemImageRepository itemImageRepository;

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

	@Override
	public void updateItem(Item item) {
		itemRepository.saveAndFlush(item);

	}

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

	@Override
	public void deleteItem(Item item) {
		itemRepository.delete(item.getId());
		
	}

}
