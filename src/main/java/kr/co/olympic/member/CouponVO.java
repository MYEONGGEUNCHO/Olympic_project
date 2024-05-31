package kr.co.olympic.member;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CouponVO {

	private int coupon_no;
	private String content;
	private int discount;
	private int member_no;
	private boolean used;
	private Timestamp use_date;
}
