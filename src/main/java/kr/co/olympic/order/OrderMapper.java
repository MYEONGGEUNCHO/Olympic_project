package kr.co.olympic.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberVO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {
	//주문정보 저장 
	void insertOrder(OrderVO order);
	//imp_uid 저장 
	void insertUid(OrderVO order);
	//주문번호로 주문객체 조회 
    OrderVO getOrderById(String order_no);
    //imp_uid로 주문객체 조회 
    OrderVO getOrderByImpUid(String imp_uid);
    
    //주문정보 업데이트 
    void updateOrder(OrderVO order);
    //주문정보 삭제 
    void deleteOrder(String order_no);
    //주문정보 상태 paid 로 업데이트 
    void updateOrderStateToPaid(OrderVO order);
    
    // 회원 객체로 전체 주문 개수 조회 
    int getTotalOrdersByMember(MemberVO member);
    //회원객체로 주문 리스트 조회 
    List<OrderVO> getOrdersByMember(MemberVO vo);
    //회원객체로 페이징 처리된 최신순 주문 내역 조회 메서드
    List<OrderVO> getOrdersByMemberPaged(@Param("member") MemberVO member, @Param("offset") int offset, @Param("limit") int limit);
    
    //티켓 객체 DB에 저장
    void insertTicket(TicketVO ticketVO);
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
  	
  	//포인트 객체 DB 저장 
    void insertPoint(PointVO pointVO);
    // 포인트 회원 추가 메서드
    void addPoint(Map<String, Object> params);
    //회원객체로 포인트 건 조회 
    List<PointVO> getPointsByMemberNo(MemberVO member);
    //회원객체로 잔여 포인트 확인 
    int getTotalAvailablePoints(MemberVO member);
    //주문 상세 정보 조회
    List<OrderDTO> listOrder(MemberVO vo);
    //좌석수 증가 로직
    void updateSeatSoldCount(PaymentVO payment);
    //좌석수 되돌리기 
    void releaseSeatSold(PaymentVO paymentVO);
    
    //진입 시간 기록 
    void recordEntryTime(Map<String, Object> params);
    //유효시간 지났으면 알아서 삭제 
    void releaseUnpaidSeats();
    //결제 안된 좌석수 되돌리기 
    void rollbackSeatCounts(Map<String, Object> params);
    
    List<PaymentVO> getExpiredReservations();
    
    void updateReservationToConfirmed(Map<String, Object> params);
    
    List<PaymentVO> getExpiredReservationsByItemNo(int item_no);
    PaymentVO getTotalExpiredSeatCountsByItemNo(int item_no);
    void decreaseSeatSoldCount(Map<String, Object> params);
    void deleteExpiredReservationsByItemNo(int item_no);
    //결제 취소 처리 위한 메소드
	int isCanceledUpdate(OrderVO vo);
	int isRefundedUpdate(OrderVO vo);
	int cancelsTableUpdate(OrderVO vo);
}