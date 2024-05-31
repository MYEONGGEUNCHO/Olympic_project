package kr.co.olympic.member;


public interface MemberService {
	
	int regist(MemberVO vo);
	int emailCheck(String email);
	MemberVO login(MemberVO vo);
	int findPwd(MemberVO vo);
	int pwdCheck(String pwd);
	MemberVO detail(MemberVO vo);
	int update(MemberVO vo);
	int delete(MemberVO vo);
	int buy_membership(MemberVO vo);
	CouponVO coupon_list(MemberVO vo);
	
}
