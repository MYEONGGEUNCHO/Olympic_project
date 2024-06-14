package kr.co.olympic.order;

import java.util.List;
import java.util.Map;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberVO;

public interface OrderService {
	OrderVO insert(OrderVO vo);
	OrderVO insertUid(OrderVO vo);
	OrderVO getOrderByImpUid(String imp_uid);
	OrderVO getOrderByOrderNo(String order_no);
	int update(OrderVO vo);
	int delete(OrderVO no);
	boolean validatePayment(OrderVO vo);
	String getImpCode();
	List<TicketVO> insertTicket(Map<String, Object> ticketDataMap);
    TicketVO createTicket(TicketVO ticketVO);
    List<TicketVO> getTicketsByOrderNo(String order_no);
    List<TicketVO> getTicketsByMemberNo(String member_no);
    int getCouponDiscount(String coupon_no);
    PaymentVO preparePaymentVO(MemberVO member, PaymentVO paymentVO);
    void insertPoint(PointVO pointVO);
    void setCouponUsed(String coupon_no);
    List<CouponVO> getPossibleCouponList(MemberVO vo);
    int getTotalAvailablePoints(String member_no);
}
