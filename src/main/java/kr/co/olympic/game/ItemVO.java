package kr.co.olympic.game;

import lombok.Data;

@Data
public class ItemVO {
	private int item_no;
	private int a_seat_sold;
	private int b_seat_sold;
	private int c_seat_sold;
	private int d_seat_sold;
	private int vip_seat_sold;
	private boolean state;
	private boolean korean_advancement;
	private int a_seat_price;
	private int b_seat_price;
	private int c_seat_price;
	private int d_seat_price;
	private int vip_seat_price;
	private int game_id;
	
	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchType;
	private String searchWord;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값
	
	public ItemVO() {
		this.page = 1;
	}
	
	public int getStartIdx() {
		return (page-1) * 10;
	}
}
