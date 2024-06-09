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
	private boolean is_korean;
	private int a_seat_price;
	private int b_seat_price;
	private int c_seat_price;
	private int d_seat_price;
	private int vip_seat_price;
	private int game_id;
}
