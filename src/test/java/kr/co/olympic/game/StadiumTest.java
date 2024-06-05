package kr.co.olympic.game;

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
	
	@Test
	public void createStadium() {
		StadiumVO vo = new StadiumVO();
		vo.setStadium_name("K2");
		vo.setStadium_img_url(null);
		vo.setStadium_url("naver.com");
		vo.setStadium_position("옆집");
		vo.setA_seat_quantity(5000);
		vo.setB_seat_quantity(5000);
		vo.setC_seat_quantity(5000);
		vo.setD_seat_quantity(5000);
		vo.setVip_seat_quantity(5000);
		
		mapper.createStadium(vo);
	}
}
