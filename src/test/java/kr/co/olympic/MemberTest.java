package kr.co.olympic;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.olympic.member.MemberMapper;
import kr.co.olympic.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration
public class MemberTest {
	
	@Autowired
	MemberMapper mapper;
	
	@Test
	public void regist() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test2@gmail.com");
		vo.setPwd("test1234");
		vo.setName("test2");
		mapper.regist(vo);
	}

	@Test
	public void login() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test@gmail.com");
		vo.setPwd("20011010");
		log.info(mapper.login(vo));
	}
	
	@Test
	public void emailCheck() {
		String email = "test@gmail.com";
		mapper.emailCheck(email);
	}
	
	@Test
	public void findPwd() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test@gmail.com");
		vo.setBirthday("20011010");
		mapper.findPwd(vo);
	}
	
	@Test
	public void pwdCheck() {
		String pwd = "20010102";
		System.out.println(mapper.pwdCheck(pwd));
	}
	
	@Test
	public void detail() {
		MemberVO vo = new MemberVO();
		vo.setMember_no(1);
		mapper.detail(vo);
	}
	@Test
	public void update() {
		MemberVO vo = new MemberVO();
		vo.setMember_no(5);
		vo.setPwd("test12345");
		mapper.update(vo);
	}
	@Test
	public void buy_membership() {
		MemberVO vo = new MemberVO();
		vo.setMember_no(5);
		System.out.println(mapper.buy_membership(vo));
	}
	@Test
	public void coupon_list() {
		MemberVO vo = new MemberVO();
		vo.setMember_no(5);
		mapper.coupon_list(vo);
	}
	
}
