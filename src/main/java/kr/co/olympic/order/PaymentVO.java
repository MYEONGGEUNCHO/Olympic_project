package kr.co.olympic.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberService;
import kr.co.olympic.member.MemberVO;
import lombok.Data;
@Data
public class PaymentVO {
	
	@Autowired
    private MemberService memberService;
	
	private int game_id; //추후 티켓 발행등에 사용할 경기 식별자 
	private int item_no; // 상품번호
	private String content; // 결제 요청시 '상품명'으로 사용할 경기상세
	
	private int a_seat_price; //사용자가 경기상세에서 선택한 좌석들의 가격과, 선택수량 정보 
	private int b_seat_price;
	private int c_seat_price;
	private int d_seat_price;
	private int vip_seat_price;
	private int a_seat_sold;
	private int b_seat_sold;
	private int c_seat_sold;
	private int d_seat_sold;
	private int vip_seat_sold;
	
	private List<CouponVO> coupon_list; //memberVO를 통해서 보유한 쿠폰 리스트 가져오기 
	private String coupon_no; // 가져온 쿠폰 리스트 중에서 선택한 쿠폰을 결제 과정에 전달하는 변수 
	
	private int total_price; // 경기 상세에서 선택한 좌석 정보들로 계산된 total_price
	
	public List<CouponVO> updateCouponList(MemberVO vo) {
		System.out.println("updateCouponList 진입 : "+ vo.toString());
        List<CouponVO> couponList = memberService.coupon_list(vo);
        System.out.println(coupon_list.toString());
        this.coupon_list = couponList;
        System.out.println(this.coupon_list.toString());
        return couponList;
    }
	
	public int calculateTotalPrice() {
        int totalPrice = 0;
        totalPrice += a_seat_price * a_seat_sold;
        totalPrice += b_seat_price * b_seat_sold;
        totalPrice += c_seat_price * c_seat_sold;
        totalPrice += d_seat_price * d_seat_sold;
        totalPrice += vip_seat_price * vip_seat_sold;
        return totalPrice;
    }
	
	
}
