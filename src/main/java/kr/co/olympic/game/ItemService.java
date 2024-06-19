package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

public interface ItemService {
	// 상품 생성
    int createItem(ItemVO item);
    // 상품 리스트
    Map<String, Object> listItem(ItemVO item);
    // 상품 상세
    ItemVO detailItem(GameVO game);
    // 상품 수정
    int updateItem(ItemVO item);
    // 상품 삭제
    int deleteItem(ItemVO item);
}
