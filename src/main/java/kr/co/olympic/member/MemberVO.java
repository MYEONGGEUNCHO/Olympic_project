package kr.co.olympic.member;

import java.sql.Timestamp;
import java.util.List;

import kr.co.olympic.game.GameVO;
import lombok.Data;

@Data
public class MemberVO {
	
	//회원 목록
	private int member_no;
	private String email;
	private String pwd;
	private String name;
	private String phone;
	private String birthday;
	private Timestamp credate;
	private String membership;
	private int point;
	private int state;  //0:가입 1: 탈퇴 2: 계정 잠김? 3: 관리자?
	
	// 관심 목록
	private List<GameVO> favorite_game;
	//쿠폰 목록
	private List<CouponVO> coupon;

}
