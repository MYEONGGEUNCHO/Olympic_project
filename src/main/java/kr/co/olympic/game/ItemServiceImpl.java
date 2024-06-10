package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	private ItemMapper mapper;

    @Override
    public int createItem(ItemVO item) {
        return mapper.createItem(item);
    }

    @Override
    public List<ItemVO> listItem() {
        return mapper.listItem();
    }

    @Override
    public ItemVO detailItem(ItemVO item) {
        return mapper.detailItem(item);
    }

    @Override
    public int updateItem(ItemVO item) {
        return mapper.updateItem(item);
    }

    @Override
    public int deleteItem(ItemVO item) {
        return mapper.deleteItem(item);
    }
}
