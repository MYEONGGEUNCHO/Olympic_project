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
}
