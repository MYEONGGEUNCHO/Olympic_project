package kr.co.olympic.member;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

public interface MemberService {
	
	int regist(MemberVO vo);
	int emailCheck(String email);
	MemberVO login(MemberVO vo);
	MemberVO checkEmail(MemberVO vo);
	int findPwd(MemberVO vo);
	int pwdCheck(String pwd);
	MemberVO detail(MemberVO vo);
	int update(MemberVO vo);
	int delete(MemberVO vo);
	int buy_membership(MemberVO vo);
	CouponVO coupon_list(MemberVO vo);
	
	// 메일 내용 작성
    MimeMessage creatMessage(String to) throws MessagingException, UnsupportedEncodingException;

    // 랜덤 인증코드 생성
    String createKey();

    // 메일 발송
    String sendSimpleMessage(String to) throws Exception;
	
}
