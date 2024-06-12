package kr.co.olympic;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.apache.ibatis.javassist.compiler.ast.Member;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.olympic.admin.AdminMapper;
import kr.co.olympic.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration
public class AdminTest {

	@Autowired
	AdminMapper mapper;
	
	@Test
	public void memberList() {
		log.info(mapper.memberList());
	}
	
	@Test
	public void updatemember() {
		MemberVO vo = new MemberVO();
		vo.setEmail("ywy2001@naver.com");
		vo.setState(0);
		vo.setPoint(400000);
		vo.setMembership("common");
		mapper.updateMember(vo);
	}
	
	@Test
	public void resetPwd() {
		MemberVO vo = new MemberVO();
		vo.setMember_no("b251770a-5f66-463d-a18f-d228eb0d8e54");
		mapper.resetMember(vo);
	}
}
