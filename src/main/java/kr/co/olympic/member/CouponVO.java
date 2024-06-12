package kr.co.olympic.member;

import java.sql.Timestamp;
import java.util.UUID;

import lombok.Data;

@Data
public class CouponVO {

	private String coupon_no;
	private String content;
	private int discount;
	private String member_no;
	private boolean used;
	private Timestamp use_date;
	
}
