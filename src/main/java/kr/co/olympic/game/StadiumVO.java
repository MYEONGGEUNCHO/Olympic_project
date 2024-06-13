package kr.co.olympic.game;

import lombok.Data;

@Data
public class StadiumVO {
	private int stadium_no;
	private String stadium_name;
	private String stadium_img_url;
	private String stadium_url;
	private String stadium_en_name;
	private String stadium_position;
	private int a_seat_quantity;
	private int b_seat_quantity;
	private int c_seat_quantity;
	private int d_seat_quantity;
	private int vip_seat_quantity;
	
	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchType;
	private String searchWord;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값
	
	public StadiumVO() {
		this.page = 1;
	}
	
	public int getStartIdx() {
		return (page-1) * 10;
	}
}
