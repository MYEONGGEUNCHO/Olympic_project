package kr.co.olympic.qna;

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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
@Log4j
public class QnaMapperTest {
	@Autowired
	private QnaMapper qnaMapper;

	
	@Test
	public void write() {
		QnaVO vo = new QnaVO();
		vo.setType(1);
		vo.setContent("내용임");
		vo.setTitle("제목임");
		vo.setMember_no("3333");
		qnaMapper.write(vo);
	}
	
	// type 0: 게임, 1: 일반, 2: 결제, 3: 티켓 문의
	// game_id :
	// member_no : 있으면 무조건 해당하는 유저
	@Test
	public void list() {
		Map<String, Integer> map = new HashMap<>();
		map.put("game_id", null);
		map.put("member_no", null);
		map.put("type", null);

		List<QnaVO> result = qnaMapper.list(map);

		log.debug(result);
	}
	@Test
	public void count() {
		Map<String, Integer> map = new HashMap<>();
		map.put("game_id", null);
		map.put("member_no", null);
		map.put("type", null);

		int result = qnaMapper.count(map);

		log.debug(result);	
	}
	@Test
	public void detail() {
		QnaVO vo = qnaMapper.detail(12);
		updateReadCnt();
		log.debug(vo);
	}
	
	@Test
	public void updateReadCnt() {
		qnaMapper.updateReadCnt(12);
	}
	
	/*
	 * 실제로는 로그인한 유저의 memberVO를 받아오고
	 * 해당 memberVO의 state를 체크해서 3인 경우에만 답변 작성
	 * */
//	@Test
//	public void reply() {
//		MemberVO user = new MemberVO();
//		MemberVO admin = new MemberVO();
//		// 0번 회원, 3번 어드민
//		user.setMember_no(10);
//		user.setState(0);
//		user.setName("유저 테스트");
//		admin.setMember_no(20);
//		admin.setState(3);
//		admin.setName("어드민 테스트");
//		QnaVO vo = new QnaVO();
//		vo.setMember_no(admin.getMember_no());
//		vo.setQna_no(1);
//		vo.setReply("답변 테스트2 진행");
//		if(user.getState() == 3) {
//			qnaMapper.reply(vo);			
//		} else {
//			System.out.println("어드민이 아닙니다.");
//		}
//	}

}
