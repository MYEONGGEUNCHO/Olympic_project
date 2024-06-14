package kr.co.olympic.order;

import java.util.List;
import java.util.Map;

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
}
