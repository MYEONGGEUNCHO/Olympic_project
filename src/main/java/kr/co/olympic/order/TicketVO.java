package kr.co.olympic.order;

import java.sql.Timestamp;
import java.util.UUID;

import lombok.Data;

@Data
public class TicketVO {
	private String ticket_no;
	private int price;
	private String member_no;
	private String order_no;
	private String cancel_state;
	private String seat_info;
	private int item_no;
	private int game_id;
	
	// TicketVO 객체를 생성할 때 UUID를 자동으로 생성하도록 하는 생성자
    public TicketVO() {
        this.ticket_no = UUID.randomUUID().toString();
    }
    
    @Override
    public String toString() {
        return "TicketVO{" +
                "ticket_no='" + ticket_no + '\'' +
                ", price=" + price +
                ", member_no='" + member_no + '\'' +
                ", order_no='" + order_no + '\'' +
                ", cancel_state='" + cancel_state + '\'' +
                ", seat_info='" + seat_info + '\'' +
                ", item_no=" + item_no +
                ", game_id=" + game_id +
                '}';
    }
}
