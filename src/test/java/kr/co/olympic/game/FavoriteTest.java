package kr.co.olympic.game;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.olympic.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration
public class FavoriteTest {
	@Autowired
    private GameMapper mapper;
	
	

    // 선호하는 게임 추가 테스트
    @Test
    public void CreateFavoriteGame() {
    	// Given
        
    	// When
        Map<String, Object> map = new HashMap<>();
        map.put("member_no", "3");
        map.put("game_id", 3);

        mapper.createFavorite(map);
    }

    // 선호 경기 삭제 테스트
    @Test
    public void deleteFavorite() {
    	Map<String, Object> map = new HashMap<>();
        map.put("member_no", "1");
        map.put("game_id", 1);

        mapper.deleteFavorite(map);
    }
}
