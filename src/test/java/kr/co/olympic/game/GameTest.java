package kr.co.olympic.game;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
public class GameTest {

    @Autowired
    GameMapper mapper;
    
    // 경기 전체 리스트
    @Test
    public void listGame() {
    	List<GameVO> list = mapper.listGame();
    	assertNotNull(list);
        assertFalse(list.isEmpty());
        list.forEach(game -> log.info("Game in list: " + game));
    }
    // 경기 날짜별 리스트
    @Test
    public void listByDate() {
    	GameVO vo = new GameVO();
    	
        vo.setKorea_date(Timestamp.valueOf("2024-06-09")); // 조회할 한국 날짜

        List<GameVO> list = mapper.listByDate(vo);
        assertNotNull(list);
        assertFalse(list.isEmpty());
        list.forEach(game -> log.info("Game for date " + vo.getKorea_date() + ": " + game));
    }
    
    // 경기 종목별 리스트
    @Test
    public void listByGame() {
    	GameVO vo = new GameVO();
    	vo.setSport_name("양궁");
    	
    	List<GameVO> list = mapper.listByGame(vo);
    	assertNotNull(list);
    	assertFalse(list.isEmpty());
    	list.forEach(game -> log.info("Game for sport " + vo.getSport_name() + ": " + game));
    }
    
    // 경기 생성
    @Test
    public void createGame() {
    	
    	GameVO vo = new GameVO();
    	
    	// Timestamp객체 생성
    	Timestamp time = new Timestamp(System.currentTimeMillis());    	
    	
//    	vo.setGame_id(1);
    	vo.setSport_name("양궁");
    	vo.setCountry1_name(null);
    	vo.setCountry2_name(null);
    	vo.setTournament(null);
    	vo.setCountry(null);
    	vo.setCountry1_flag(null);
    	vo.setCountry2_flag(null);
    	vo.setStadium_name(null);
    	vo.setParis_date(time);
    	vo.setParis_time(time);
    	vo.setKorea_date(time);
    	vo.setKorea_time(time);
    	vo.setSport_code("arc");
    	vo.setStadium_no(1);
    	
    	mapper.createGame(vo);
    }
    
    // 경기 상세조회
    @Test
    public void detailGame() {
    	GameVO vo = new GameVO();
    	vo.setGame_id(1);
    	GameVO result = mapper.detailGame(vo);
    	assertNotNull(result);
        log.info("Game read: " + result);
    }
    
    // 경기 수정
    @Test
    public void updateGame() {
        GameVO vo = new GameVO();
        vo.setGame_id(1);
        vo.setSport_name("수정된 스포츠명");
        vo.setCountry1_name(null);
        vo.setCountry2_name(null);
        vo.setTournament(null);
        vo.setCountry(null);
        vo.setCountry1_flag(null);
        vo.setCountry2_flag(null);
        vo.setStadium_name("수정된 경기장명");
        vo.setParis_date(null);
        vo.setParis_time(null);
        vo.setKorea_date(null);
        vo.setKorea_time(null);
        vo.setSport_code("test");
        vo.setStadium_no(2);

        int result = mapper.updateGame(vo);
        assertTrue(result == 1); // 업데이트 성공 여부 확인
    }
    
    
    // 경기 삭제
    @Test
    public void deleteGame() {
        GameVO vo = new GameVO();
        vo.setGame_id(1);

        int result = mapper.deleteGame(vo);
        assertTrue(result == 1); // 삭제 성공 여부 확인
    }
    
}
