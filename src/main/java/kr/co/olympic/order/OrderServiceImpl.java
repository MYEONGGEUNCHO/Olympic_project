package kr.co.olympic.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import kr.co.olympic.game.ItemService;
import kr.co.olympic.game.StadiumService;
import kr.co.olympic.game.StadiumVO;
import kr.co.olympic.game.ItemVO;
import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberService;
import kr.co.olympic.member.MemberVO;
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	
	@Autowired
    private MemberService memberService;
	
	@Autowired
	private StadiumService stadiumService;
	
	@Autowired
	private ItemService itemService;
	
	
	@Value("${order.api.key}")
    private String imp_key;

    @Value("${order.api.secret}")
    private String imp_secret;
    
    @Value("${order.api.code}")
    private String imp_code;
    
    @Override
    public String getImpCode() {
    	return this.imp_code;
    }

	@Override
	public OrderVO insert(OrderVO vo) {
		mapper.insertOrder(vo);
		return mapper.getOrderById(vo.getOrder_no());
	}
	
	@Override
	public OrderVO insertUid(OrderVO vo) {
		mapper.insertUid(vo);
		return mapper.getOrderById(vo.getOrder_no());
	}
	
	@Override
	public OrderVO getOrderByOrderNo(String order_no) {
		return mapper.getOrderById(order_no);
	}
	
	@Override
	public OrderVO getOrderByImpUid(String imp_uid) {
		return mapper.getOrderByImpUid(imp_uid);
	}
	
	@Override
	public int update(OrderVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(OrderVO no) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public void updateOrderStateToPaid(OrderVO order) {
		mapper.updateOrderStateToPaid(order);
	}
	

	@Override
	public int getTotalOrdersByMember(MemberVO member) {
		return mapper.getTotalOrdersByMember(member);
	}

	
	@Override
	public List<OrderVO> getOrdersByMember(MemberVO vo){
		return mapper.getOrdersByMember(vo);
	}
	
	@Override
	public List<OrderVO> getOrdersByMemberPaged(@Param("member") MemberVO member, 
			@Param("offset") int offset, @Param("limit") int limit){
		return mapper.getOrdersByMemberPaged(member, offset, limit);
	}
	
	@Override
    public List<TicketVO> insertTicket(Map<String, Object> ticketDataMap) {
        OrderVO order = (OrderVO) ticketDataMap.get("order");
        MemberVO member = (MemberVO) ticketDataMap.get("member");
        PaymentVO payment = (PaymentVO) ticketDataMap.get("payment");

        List<TicketVO> ticketList = new ArrayList<>();

        // A석 티켓 생성
        for (int i = 0; i < payment.getA_seat_sold(); i++) {
            TicketVO ticket = new TicketVO();
            ticket.setPrice(payment.getA_seat_price());
            ticket.setMember_no(member.getMember_no());
            ticket.setOrder_no(order.getOrder_no());
            ticket.setSeat_info("a_seat");
            ticket.setItem_no(payment.getItem_no());
            ticket.setGame_id(payment.getGame_id());
            ticketList.add(createTicket(ticket));
        }

        // B석 티켓 생성
        for (int i = 0; i < payment.getB_seat_sold(); i++) {
            TicketVO ticket = new TicketVO();
            ticket.setPrice(payment.getB_seat_price());
            ticket.setMember_no(member.getMember_no());
            ticket.setOrder_no(order.getOrder_no());
            ticket.setSeat_info("b_seat");
            ticket.setItem_no(payment.getItem_no());
            ticket.setGame_id(payment.getGame_id());
            ticketList.add(createTicket(ticket));
        }

        // C석 티켓 생성
        for (int i = 0; i < payment.getC_seat_sold(); i++) {
            TicketVO ticket = new TicketVO();
            ticket.setPrice(payment.getC_seat_price());
            ticket.setMember_no(member.getMember_no());
            ticket.setOrder_no(order.getOrder_no());
            ticket.setSeat_info("c_seat");
            ticket.setItem_no(payment.getItem_no());
            ticket.setGame_id(payment.getGame_id());
            ticketList.add(createTicket(ticket));
        }

        // D석 티켓 생성
        for (int i = 0; i < payment.getD_seat_sold(); i++) {
            TicketVO ticket = new TicketVO();
            ticket.setPrice(payment.getD_seat_price());
            ticket.setMember_no(member.getMember_no());
            ticket.setOrder_no(order.getOrder_no());
            ticket.setSeat_info("d_seat");
            ticket.setItem_no(payment.getItem_no());
            ticket.setGame_id(payment.getGame_id());
            ticketList.add(createTicket(ticket));
        }

        // VIP석 티켓 생성
        for (int i = 0; i < payment.getVip_seat_sold(); i++) {
            TicketVO ticket = new TicketVO();
            ticket.setPrice(payment.getVip_seat_price());
            ticket.setMember_no(member.getMember_no());
            ticket.setOrder_no(order.getOrder_no());
            ticket.setSeat_info("vip_seat");
            ticket.setItem_no(payment.getItem_no());
            ticket.setGame_id(payment.getGame_id());
            ticketList.add(createTicket(ticket));
        }
        //getTicketsByOrderNo(order.getOrder_no()).forEach(System.out::println);

        //getTicketsByMemberNo(member.getMember_no()).forEach(System.out::println);
        return ticketList;
    }
	
	
	@Override
    public TicketVO createTicket(TicketVO ticketVO) {
		mapper.insertTicket(ticketVO);
        return ticketVO;
    }
	
	@Override
    public List<TicketVO> getTicketsByOrderNo(String order_no) {
        return mapper.getTicketsByOrderNo(order_no);
    }
	
	@Override
    public List<TicketVO> getTicketsByMemberNo(MemberVO vo) {
        return mapper.getTicketsByMemberNo(vo);
    }
	

	@Override
	public int getCouponDiscount(String coupon_no) {
		return mapper.getCouponDiscount(coupon_no);
	}
	
	@Override
	public List<CouponVO> getPossibleCouponList(MemberVO vo){
		return mapper.getPossibleCouponList(vo);
	}
	

	@Override
	public List<CouponVO> getAllCouponList(MemberVO vo){
		return mapper.getAllCouponList(vo);
	}
	
	@Override
	public void setCouponUsed(String coupon_no) {
		mapper.setCouponUsed(coupon_no);
	}
	
	
	@Override
    public PaymentVO preparePaymentVO(MemberVO member, PaymentVO paymentVO) {
		paymentVO.setCoupon_list(getPossibleCouponList(member));
        return paymentVO;
    }
	
	@Override
	public void insertPoint(PointVO pointVO) {
		mapper.insertPoint(pointVO);
	}
	
	@Override
	public List<PointVO> getPointsByMemberNo(MemberVO member){
		return mapper.getPointsByMemberNo(member);
	}
	
	@Override
	public int getTotalAvailablePoints(MemberVO member) {
		return mapper.getTotalAvailablePoints(member);
	}
	
	public String getAccessToken() {
        if (imp_key == null || imp_secret == null) {
            throw new IllegalArgumentException("API key and secret must be set");
        }

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("imp_key", imp_key);
        requestBody.put("imp_secret", imp_secret);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<Map> response = restTemplate.exchange(
            "https://api.iamport.kr/users/getToken",
            HttpMethod.POST,
            entity,
            Map.class
        );

        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            Map<String, Object> responseBody = (Map<String, Object>) response.getBody().get("response");
            if (responseBody != null) {
                return (String) responseBody.get("access_token");
            } else {
                throw new RuntimeException("Failed to get access token: response body is null");
            }
        } else {
            throw new RuntimeException("Failed to get access token: " + response.getStatusCode());
        }
    }
	
	private OrderVO getPaymentInfo(String imp_uid, String accessToken) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<Map> response = restTemplate.exchange(
                "https://api.iamport.kr/payments/" + imp_uid, 
                HttpMethod.GET, 
                entity, 
                Map.class
            );

        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            Map<String, Object> responseBody = (Map<String, Object>) response.getBody().get("response");
            
            OrderVO orderVO = new OrderVO();
            orderVO.setImp_uid((String) responseBody.get("imp_uid"));
            orderVO.setOrder_no((String) responseBody.get("merchant_uid"));
            orderVO.setReal_price((Integer) responseBody.get("amount"));
            orderVO.setMember_email((String) responseBody.get("buyer_email"));
            return orderVO;
        } else {
            throw new RuntimeException("포트원 결제정보 조회 실패");
        }
    }
	
	@Override
    public boolean validatePayment(OrderVO vo) {
        // 액세스 토큰 발급
        String accessToken = getAccessToken();
        
        // 포트원 API를 통해 결제 정보 단건 조회 (paidOrder)
        OrderVO paidOrder = getPaymentInfo(vo.getImp_uid(), accessToken);
        
        if(paidOrder == null) {
        	return false;
        }else {
        	// DB에서 주문 정보 조회(myOrder)
            OrderVO myOrder = mapper.getOrderByImpUid(paidOrder.getImp_uid());

            // 유효성 검사
            return paidOrder.getReal_price() == myOrder.getReal_price() &&
            		paidOrder.getOrder_no().equals(myOrder.getOrder_no()) &&
            		paidOrder.getMember_email().equals(myOrder.getMember_email());
        }
       
    }
	
	@Override
	public Map<String, Boolean> checkSeatAvailability(PaymentVO paymentVO) {
		// 경기장 최대 좌석 수 조회
		StadiumVO stadiumVo = new StadiumVO();
		stadiumVo.setStadium_no(paymentVO.getStadium_no());
		StadiumVO stadiumVO = stadiumService.detailStadium(stadiumVo);
		        
		// 상품 판매된 좌석 수 조회
		ItemVO itemVo = new ItemVO();
		itemVo.setItem_no(paymentVO.getItem_no());
		ItemVO itemVO = itemService.detailItem(itemVo);
        
        Map<String, Boolean> seatAvailability = new HashMap<>();
        seatAvailability.put("A", stadiumVO.getA_seat_quantity() - itemVO.getA_seat_sold() >= paymentVO.getA_seat_sold());
        seatAvailability.put("B", stadiumVO.getB_seat_quantity() - itemVO.getB_seat_sold() >= paymentVO.getB_seat_sold());
        seatAvailability.put("C", stadiumVO.getC_seat_quantity() - itemVO.getC_seat_sold() >= paymentVO.getC_seat_sold());
        seatAvailability.put("D", stadiumVO.getD_seat_quantity() - itemVO.getD_seat_sold() >= paymentVO.getD_seat_sold());
        seatAvailability.put("VIP", stadiumVO.getVip_seat_quantity() - itemVO.getVip_seat_sold() >= paymentVO.getVip_seat_sold());
        
        return seatAvailability;
    }
	@Override
	public Map<String, Integer> countSeatAvailability(PaymentVO paymentVO) {
		// 경기장 최대 좌석 수 조회
		StadiumVO stadiumVo = new StadiumVO();
		stadiumVo.setStadium_no(paymentVO.getStadium_no());
        StadiumVO stadiumVO = stadiumService.detailStadium(stadiumVo);
        
        // 상품 판매된 좌석 수 조회
        ItemVO itemVo = new ItemVO();
        itemVo.setItem_no(paymentVO.getItem_no());
        ItemVO itemVO = itemService.detailItem(itemVo);
        
        Map<String, Integer> countSeatAvailability = new HashMap<>();
        countSeatAvailability.put("A", stadiumVO.getA_seat_quantity() - itemVO.getA_seat_sold());
        countSeatAvailability.put("B", stadiumVO.getB_seat_quantity() - itemVO.getB_seat_sold());
        countSeatAvailability.put("C", stadiumVO.getC_seat_quantity() - itemVO.getC_seat_sold());
        countSeatAvailability.put("D", stadiumVO.getD_seat_quantity() - itemVO.getD_seat_sold());
        countSeatAvailability.put("VIP", stadiumVO.getVip_seat_quantity() - itemVO.getVip_seat_sold());
        
        return countSeatAvailability;
    }
	// 좌석 수 증가 메서드 추가
    @Override
	public void updateSeatSoldCount(PaymentVO paymentVO) {
        mapper.updateSeatSoldCount(paymentVO);
    }
    // 좌석 수 감소(되돌리기 ) 메서드 추가 
    @Override
    public void releaseSeats(PaymentVO paymentVO) {
        mapper.releaseSeatSold(paymentVO);
    }
    
    @Override
    public void recordEntryTime(MemberVO member, PaymentVO payment) {
        Map<String, Object> params = new HashMap<>();
        params.put("member", member);
        params.put("payment", payment);
        mapper.recordEntryTime(params);
    }

    @Override
    public void releaseUnpaidSeats() {
    	mapper.releaseUnpaidSeats();
    }

    @Override
    public void rollbackSeatCounts(MemberVO member, PaymentVO payment) {
        Map<String, Object> params = new HashMap<>();
        params.put("member", member);
        params.put("payment", payment);
        mapper.rollbackSeatCounts(params);
    }
    
    @Override
    public List<PaymentVO> getExpiredReservations() {
        return mapper.getExpiredReservations();
    }
    
    @Scheduled(fixedRate = 60000) // 1분마다 실행
    @Transactional
    public void releaseExpiredSeatsScheduled(MemberVO member) {
        List<PaymentVO> expiredReservations = mapper.getExpiredReservations();
        Map<String, Object> params = new HashMap<>();
        params.put("member", member);
        
        for (PaymentVO reservation : expiredReservations) {
        	params.put("payment", reservation);
        	mapper.rollbackSeatCounts(params);
        }
        mapper.releaseUnpaidSeats();
    }
    @Override
    public void updateReservationToConfirmed(Map<String, Object> params) {
    	mapper.updateReservationToConfirmed(params);
    }

	@Override
	public List<OrderDTO> listOrder(MemberVO vo) {
		return mapper.listOrder(vo);
	}

}
