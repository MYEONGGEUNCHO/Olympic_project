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
public class StadiumTest {
	@Autowired
	StadiumMapper mapper;
	
	// 경기장 생성
	@Test
	public void createStadium() {
		StadiumVO vo = new StadiumVO();
		vo.setStadium_name("K3");
		vo.setStadium_img_url(null);
		vo.setStadium_url("naver.com");
		vo.setStadium_position("옆집");
		vo.setA_seat_quantity(5000);
		vo.setB_seat_quantity(5000);
		vo.setC_seat_quantity(5000);
		vo.setD_seat_quantity(5000);
		vo.setVip_seat_quantity(5000);
		
		mapper.createStadium(vo);
		assertNotNull(vo.getStadium_no());
		log.info("Stadium created with ID: " + vo.getStadium_no());
	}
	
	// 경기장 리스트
	@Test
	public void listStadium() {
		StadiumVO vo = new StadiumVO();
		List<StadiumVO> list = mapper.listStadium(vo);
		assertNotNull(list);
		assertFalse(list.isEmpty());
		list.forEach(stadium -> log.info("Stadium in list: " + stadium));
	}
	
	// 경기장 상세
	@Test
    public void detailStadium() {
        StadiumVO vo = new StadiumVO();
        vo.setStadium_no(1); // Assuming ID 1 exists for testing
        StadiumVO result = mapper.detailStadium(vo);
        assertNotNull(result);
        log.info("Stadium read: " + result);
    }
	
	// 경기장 수정
	@Test
	public void updateStadium() {
		StadiumVO vo = new StadiumVO();
		vo.setStadium_no(1); // Assuming ID 1 exists for testing
		vo.setStadium_name("Updated Name");
		vo.setStadium_img_url("updated_url");
		vo.setStadium_url("updated_naver.com");
		vo.setStadium_position("updated position");
		vo.setA_seat_quantity(6000);
		vo.setB_seat_quantity(6000);
		vo.setC_seat_quantity(6000);
		vo.setD_seat_quantity(6000);
		vo.setVip_seat_quantity(6000);

		int updatedRows = mapper.updateStadium(vo);
		assertEquals(1, updatedRows);
		log.info("Stadium updated: " + vo);
	}
	
	// 경기장 삭제
	@Test
    public void deleteStadium() {
        StadiumVO vo = new StadiumVO();
        vo.setStadium_no(1); // Assuming ID 1 exists for testing

        int deletedRows = mapper.deleteStadium(vo);
        assertEquals(1, deletedRows);
        log.info("Stadium deleted with ID: " + vo.getStadium_no());
    }
}
