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
public class SportTest {
	@Autowired
	SportMapper mapper;
	
	@Test
	public void createSport() {
		SportVO vo = new SportVO();
		vo.setSport_code("test1");
		vo.setSport_name("test1");
		vo.setTitle_image(null);
		vo.setLink(null);
		vo.setSport_info(null);
		vo.setSport_rule(null);
		vo.setSport_history(null);
		
		mapper.createSport(vo);
	}
}
