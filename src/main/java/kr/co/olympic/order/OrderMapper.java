package kr.co.olympic.order;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import kr.co.olympic.member.MemberVO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {
	void insertOrder(OrderVO order);
	void insertUid(OrderVO order);
    OrderVO getOrderById(String order_no);
    OrderVO getOrderByImpUid(String imp_uid);
    List<OrderVO> getOrdersByMember(int member_no);
    void updateOrder(OrderVO order);
    void deleteOrder(String order_no);
    void updateOrderStateToPaid(OrderVO order);
    void insertTicket(TicketVO ticketVO);
    

    // 페이징 처리된 최신순 주문 내역 조회 메서드
    List<OrderVO> getOrdersByMemberPaged(@Param("member") MemberVO member, @Param("offset") int offset, @Param("limit") int limit);
    
    int getTotalOrdersByMember(@Param("member") MemberVO member);
    List<TicketVO> getTicketsByOrderNo(String order_no);
    List<TicketVO> getTicketsByMemberNo(String member_no);
}