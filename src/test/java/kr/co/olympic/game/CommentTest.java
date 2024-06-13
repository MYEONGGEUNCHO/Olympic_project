package kr.co.olympic.game;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class CommentTest {
	@Autowired
	private GameMapper mapper;
	
	@Test
	public void commentTest() {
		Map<String, Object> map = new HashMap<>();
		map.put("regdate", new Timestamp(System.currentTimeMillis()));
        map.put("content", "This is a test comment.");
        map.put("game_id", 1);  // 실제 존재하는 game_id로 설정
        map.put("member_no", "1");  // 실제 존재하는 member_no로 설정
        
        int result = mapper.createComment(map);
        assertEquals(1, result);

        log.info("Comment created successfully.");
	}
	
	@Test
	public void listComment() {
		CommentVO vo = new CommentVO();
		
		vo.setComment_no(1);
		
		List<CommentVO> comments = mapper.listComment(vo);
		assertNotNull(comments);
        assertFalse(comments.isEmpty());

        comments.forEach(comment -> log.info("Comment: " + comment));
	}
}
