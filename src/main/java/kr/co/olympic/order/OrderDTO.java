package kr.co.olympic.order;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	private String member_no;
	private String order_no;
	private Date buy_date;
	private String sport_name;
	private String tournament;
	private String stadium_name;
	private Date korea_date;
	private String korea_time;
	private int ticket_count;
	private int is_paid;
	private int is_canceled;
	private int is_refunded;
	private Date cancel_date;
	
	
	private String imp_uid;
}