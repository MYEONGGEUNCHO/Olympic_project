package kr.co.olympic.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.olympic.game.GameVO;

@Mapper
public interface MemberMapper {
	
	// 가입
	int regist(MemberVO vo);
	// 이메일 중복체크
	int emailCheck(String email);
	// 로그인
	MemberVO login(MemberVO vo);
	//이름, 이메일 유효성 검사
	MemberVO checkEmail(MemberVO vo);
	//비밀번호 찾기
	int findPwd(MemberVO vo);
	//비밀번호 확인
	int pwdCheck(MemberVO vo);
	// 회원정보 조회
	MemberVO detail(MemberVO vo);
	// 회원정보 수정
	int update(MemberVO vo);
	//회원 탈퇴
	int delete(MemberVO vo);
	//멤버십 구매
	int buy_membership(MemberVO vo);
	//쿠폰 확인
	List<CouponVO> coupon_list(MemberVO vo);
	//쿠폰 발급
	int insert_coupon(CouponVO vo);
	// 관심 경기 리스트
	List<GameVO> listFavorite(MemberVO vo);
	
	//관심 목록 확인
	//GameVO favorite_list(MemberVO vo);
	

}