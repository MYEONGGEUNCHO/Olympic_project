package kr.co.olympic.game;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ItemMapper {
	// 상품 생성
    int createItem(ItemVO item);
    // 상품 리스트 조회
    List<ItemVO> listItem(ItemVO item);
    // 상품 상세 조회
    ItemVO detailItem(ItemVO item);
    // 상품 수정
    int updateItem(ItemVO item);
    // 상품 삭제
    int deleteItem(ItemVO item);
    // 상품 수
    int count(ItemVO vo);
}
