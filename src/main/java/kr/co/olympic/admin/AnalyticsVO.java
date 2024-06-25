package kr.co.olympic.admin;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AnalyticsVO {
	private int sale_count;
	private int cancel_count;
	private int total_price;
	private int game_id;
	private Timestamp buy_date;
	private Timestamp cancel_date;	
}
