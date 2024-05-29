package kr.co.olympic.member;

import java.util.List;

import kr.co.olympic.game.GameVO;

public class MemberVO {
	private String name;
	/* 생략 */
	// 관심 목록
	private List<GameVO> favorite_game;
	private List<CouponVO> coupon;

}
