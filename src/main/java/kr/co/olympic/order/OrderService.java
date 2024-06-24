package kr.co.olympic.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberVO;

public interface OrderService {
	//주문정보 저장 
	OrderVO insert(OrderVO vo);
	//imp_uid 저장 
	OrderVO insertUid(OrderVO vo);
	//주문번호로 주문객체 조회 
	OrderVO getOrderByOrderNo(String order_no);
	//imp_uid로 주문객체 조회 
	OrderVO getOrderByImpUid(String imp_uid);
	
	//주문정보 업데이트
	int update(OrderVO vo);
	//주문정보 삭제 
	int delete(OrderVO no);
	//주문정보 상태 paid 로 업데이트 
    void updateOrderStateToPaid(OrderVO order);
    
	
	//회원 객체로 전체 주문 개수 조회 
    int getTotalOrdersByMember(MemberVO member);
    //회원객체로 주문 리스트 조회 
	List<OrderVO> getOrdersByMember(MemberVO vo);
	//회원객체로 페이징 처리된 최신순 주문 내역 조회 메서드
    List<OrderVO> getOrdersByMemberPaged(@Param("member") MemberVO member, @Param("offset") int offset, @Param("limit") int limit);
	
    //티켓 만들고 한번에 DB 저장 
	List<TicketVO> insertTicket(Map<String, Object> ticketDataMap);
    TicketVO createTicket(TicketVO ticketVO);
    //주문번호로 티켓 리스트 조회 
    List<TicketVO> getTicketsByOrderNo(String order_no);
    //회원 객체로 티켓 리스트 조회
    List<TicketVO> getTicketsByMemberNo(MemberVO vo);
    
    //쿠폰 번호로 쿠폰 할인율 조회 
    int getCouponDiscount(String coupon_no);
    //회원 객체로 유효한 쿠폰 확인
    List<CouponVO> getPossibleCouponList(MemberVO vo);
    //회원 객체로 모든 쿠폰 이력 확인 
  	List<CouponVO> getAllCouponList(MemberVO vo);
    //쿠폰 상태 사용함으로 변경
    void setCouponUsed(String coupon_no);
    
    PaymentVO preparePaymentVO(MemberVO member, PaymentVO paymentVO);
  	//포인트 객체 DB 저장 
    void insertPoint(PointVO pointVO);
    // 포인트 추가 메서드
    void addPoint(String memberNo, int point);
    //회원객체로 포인트 건 조회 
    List<PointVO> getPointsByMemberNo(MemberVO member);
    //회원객체로 잔여 포인트 확인 
    int getTotalAvailablePoints(MemberVO member);
    
    //결제 유효성 검사 
	boolean validatePayment(OrderVO vo);
	//imp_uid 조회하기 
	String getImpCode();
	
	List<OrderDTO> listOrder(MemberVO vo);
	//잔여 좌석 판매가능여부 확인하기 
	Map<String, Boolean> checkSeatAvailability(PaymentVO paymentVO);
	//잔여 좌석 개수 확인하기 
	Map<String, Integer> countSeatAvailability(PaymentVO paymentVO);
	//좌석 판매량 증가시키기  
	void updateSeatSoldCount(PaymentVO paymentVO);
	//좌석 돌려놓기 
	void releaseSeats(PaymentVO paymentVO);
	
	void recordEntryTime(MemberVO member, PaymentVO payment);
	
	void releaseUnpaidSeats();
	
	void rollbackSeatCounts(MemberVO member, PaymentVO payment);
	
	List<PaymentVO> getExpiredReservations();
	
	void updateReservationToConfirmed(Map<String, Object> params);
	
	void cleanupExpiredReservations(int item_no);

	int cancelOrder(OrderVO vo);
	
	List<OrderDTO> listcancelOrder(MemberVO vo);
}
