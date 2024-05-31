package kr.co.olympic.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public int regist(MemberVO vo) {
		//회원가입 실패하면 0 성공하면 1
		return mapper.regist(vo) == 0? 0 : 1;
	}

	@Override
	public int emailCheck(String email) {
		return mapper.emailCheck(email);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	@Override
	public int findPwd(MemberVO vo) {
		return mapper.findPwd(vo);
	}

	@Override
	public int pwdCheck(String pwd) {
		return mapper.pwdCheck(pwd) == 0? 0 : 1;
	}

	@Override
	public MemberVO detail(MemberVO vo) {
		return mapper.detail(vo);
	}

	@Override
	public int update(MemberVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(MemberVO vo) {
		return mapper.delete(vo);
	}

	@Override
	public int buy_membership(MemberVO vo) {
		return mapper.buy_membership(vo);
	}

	@Override
	public CouponVO coupon_list(MemberVO vo) {
		return mapper.coupon_list(vo);
	}

}
