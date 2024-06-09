package kr.co.olympic.game;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration
public class ItemTest {
	@Autowired
	ItemMapper mapper;
	
	// 상품 생성 테스트
    @Test
    public void createItem() {
        ItemVO vo = new ItemVO();
        vo.setA_seat_sold(100);
        vo.setB_seat_sold(200);
        vo.setC_seat_sold(300);
        vo.setD_seat_sold(400);
        vo.setVip_seat_sold(50);
        vo.setState(true);
        vo.set_korean(true);
        vo.setA_seat_price(1000);
        vo.setB_seat_price(2000);
        vo.setC_seat_price(3000);
        vo.setD_seat_price(4000);
        vo.setVip_seat_price(5000);
        vo.setGame_id(1);

        mapper.createItem(vo);
        assertNotNull(1);
        log.info("Item created with ID: " + vo.getItem_no());
    }
    
    // 상품 리스트 조회 테스트
    @Test
    public void listItem() {
        List<ItemVO> list = mapper.listItem();
        assertNotNull(list);
        assertFalse(list.isEmpty());
        list.forEach(item -> log.info("Item in list: " + item));
    }
    
 // 상품 상세 조회 테스트
    @Test
    public void detailItem() {
        ItemVO vo = new ItemVO();
        vo.setItem_no(1); // Assuming ID 1 exists for testing
        ItemVO retrievedItem = mapper.detailItem(vo);
        assertNotNull(retrievedItem);
        log.info("Item read: " + retrievedItem);
    }
    
 // 상품 수정 테스트
    @Test
    public void updateItem() {
        ItemVO vo = new ItemVO();
        vo.setItem_no(1); // Assuming ID 1 exists for testing
        vo.setA_seat_sold(150);
        vo.setB_seat_sold(250);
        vo.setC_seat_sold(350);
        vo.setD_seat_sold(450);
        vo.setVip_seat_sold(55);
        vo.setState(false);
        vo.set_korean(false);
        vo.setA_seat_price(1100);
        vo.setB_seat_price(2200);
        vo.setC_seat_price(3300);
        vo.setD_seat_price(4400);
        vo.setVip_seat_price(5500);
        vo.setGame_id(2);

        int updatedRows = mapper.updateItem(vo);
        assertEquals(1, updatedRows);
        log.info("Item updated: " + vo);
    }
    
    // 상품 삭제 테스트
    @Test
    public void deleteItem() {
        ItemVO vo = new ItemVO();
        vo.setItem_no(1); // Assuming ID 1 exists for testing

        mapper.deleteItem(vo);
        log.info("Item deleted: " + vo.getItem_no());
    }
}
