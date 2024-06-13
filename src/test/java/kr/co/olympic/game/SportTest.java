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
public class SportTest {
	@Autowired
	SportMapper mapper;
	
	@Test
	public void createSport() {
		SportVO vo = new SportVO();
		vo.setSport_code("test2");
		vo.setSport_name("test2");
		vo.setSport_pictogram("test2");
		vo.setTitle_image(null);
		vo.setLink(null);
		vo.setSport_info(null);
		vo.setSport_rule(null);
		vo.setSport_history(null);
		
		mapper.createSport(vo);
	}
	
	// 종목 리스트 조회 테스트
    @Test
    public void listSport() {
    	SportVO vo = new SportVO();
        List<SportVO> list = mapper.listSport(vo);
        assertNotNull(list);
        assertFalse(list.isEmpty());
        list.forEach(sport -> log.info("Sport in list: " + sport));
    }

    // 종목 상세 조회 테스트
    @Test
    public void detailSport() {
        SportVO vo = new SportVO();
        vo.setSport_code("test1");
        SportVO result = mapper.detailSport(vo);
        assertNotNull(result);
        log.info("Sport read: " + result);
    }
    
 // 종목 수정 테스트
    @Test
    public void updateSport() {
        SportVO vo = new SportVO();
        vo.setSport_code("test1");
        vo.setSport_name("Updated Name");
        vo.setTitle_image("updated_url");
        vo.setLink("updated_naver.com");
        vo.setSport_info("updated info");
        vo.setSport_rule("updated rule");
        vo.setSport_history("updated history");

        int updatedRows = mapper.updateSport(vo);
        assertEquals(1, updatedRows);
        log.info("Sport updated: " + vo);
    }

    // 종목 삭제 테스트
    @Test
    public void deleteSport() {
        SportVO vo = new SportVO();
        vo.setSport_code("test1");

        int deletedRows = mapper.deleteSport(vo);
        assertEquals(1, deletedRows);
        log.info("Sport deleted with code: " + vo.getSport_code());
    }
}
