package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemServiceImpl implements ItemService {

    private final ItemMapper itemMapper;

    @Autowired
    public ItemServiceImpl(ItemMapper itemMapper) {
        this.itemMapper = itemMapper;
    }

    @Override
    public int createItem(ItemVO item) {
        return itemMapper.createItem(item);
    }

    @Override
    public List<ItemVO> listItem() {
        return itemMapper.listItem();
    }

    @Override
    public ItemVO detailItem(ItemVO item) {
        return itemMapper.detailItem(item);
    }

    @Override
    public int updateItem(ItemVO item) {
        return itemMapper.updateItem(item);
    }

    @Override
    public int deleteItem(ItemVO item) {
        return itemMapper.deleteItem(item);
    }
}
