package kr.co.olympic.game;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Before;
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
    private GameMapper gameMapper;
    
    // 테스트를 위한 회원과 게임 ID
    private MemberVO member;
    private GameVO game1;
    private GameVO game2;

    // 테스트 전에 실행할 설정
    @Before
    public void setUp() {
        // 테스트를 위한 초기화 작업
        member = new MemberVO();
        member.setMember_no("test_member");

        game1 = new GameVO();
        game1.setGame_id(1);

        game2 = new GameVO();
        game2.setGame_id(2);
    }

    // 선호하는 게임 추가 테스트
//    @Test
//    public void testAddFavoriteGame() {
//        int result = favoriteGameMapper.addFavoriteGame(member);
//        assertEquals(1, result);
//        log.info("Favorite game added successfully.");
//    }

    // 선호하는 게임 목록 조회 테스트
//    @Test
//    public void testGetFavoriteGamesByMember() {
//        // 선호하는 게임 추가
//        favoriteGameMapper.addFavoriteGame(member);
//
//        // 선호하는 게임 조회
//        List<GameVO> favoriteGames = favoriteGameMapper.getFavoriteGamesByMember(member.getMember_no());
//        assertNotNull(favoriteGames);
//        assertFalse(favoriteGames.isEmpty());
//
//        log.info("Favorite games for member " + member.getMember_no() + ":");
//        for (GameVO game : favoriteGames) {
//            log.info(game);
//        }
//    }

    // 선호하는 게임 삭제 테스트
//    @Test
//    public void testDeleteFavoriteGame() {
//        // 선호하는 게임 추가
//        GameMapper.createFavorite(member);
//
//        // 선호하는 게임 삭제
//        int result = favoriteGameMapper.deleteFavoriteGame(member, game1);
//        assertEquals(1, result);
//        log.info("Favorite game deleted successfully.");
//    }

}
