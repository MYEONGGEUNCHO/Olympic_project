package kr.co.olympic.game;

import java.util.List;

public interface ItemService {
    int createItem(ItemVO item);
    List<ItemVO> listItem();
    ItemVO detailItem(ItemVO item);
    int updateItem(ItemVO item);
    int deleteItem(ItemVO item);
}
