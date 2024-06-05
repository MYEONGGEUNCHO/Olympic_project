package kr.co.olympic.order;

public interface OrderService {
	OrderVO insert(OrderVO vo);
	OrderVO insertUid(OrderVO vo);
	OrderVO getOrderByImpUid(String imp_uid);
	OrderVO getOrderByOrderNo(String order_no);
	int update(OrderVO vo);
	int delete(OrderVO no);
	boolean validatePayment(OrderVO vo);
	String getImpCode();
}
