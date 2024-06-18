package kr.co.olympic.order;

import java.sql.Timestamp;
import java.util.UUID;

import lombok.Data;

@Data
public class OrderVO {
	private String order_no;
    private Timestamp buy_date;
    private String state;
    private String member_no;
    private int item_no;
    private int game_id;
    private String coupon_no;
    private String imp_uid;
    private int real_price;
    private int original_price;
    private int point;
    private String member_email;
    private int is_paid;
    private int is_canceled;
    private int is_refunded;
    
    // Order 객체를 생성할 때 UUID를 자동으로 생성하도록 하는 생성자
    public OrderVO() {
        this.order_no = UUID.randomUUID().toString();
    }
}
