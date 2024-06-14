package kr.co.olympic.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.olympic.member.MemberVO;


@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@GetMapping("/order/order.do")
	public String login() {
		return "/order/index";
	}
	
	@GetMapping("/order/test_temp.do")
	public String start_test() {
		return "/order/test_temp";
	}
	
	@GetMapping("/order/finish.do")
	public String end_test() {
		return "/order/finish";
	}
	
	@PostMapping("/order/initOrder")
	public String initOrder(@ModelAttribute PaymentVO paymentVO, HttpSession session, RedirectAttributes redirectAttributes) {
	    // 세션에서 MemberVO 객체 가져오기
	    MemberVO member = (MemberVO) session.getAttribute("member");

	    // 테스트용 임시값 설정
	    if (member == null) {
	        member = new MemberVO();
	        member.setMember_no("1");
	        member.setName("홍길동");
	        member.setEmail("test@test.com");
	        member.setPhone("010-1234-4321");
	        session.setAttribute("member", member);
	    }
	    
	    PaymentVO tempPay = paymentVO;
	    tempPay.setTotal_price(tempPay.calculateTotalPrice());
	    
	    // 회원 여부 검증
	    if (member == null) {
	        return "redirect:/login";
	    }

	    // 리다이렉트 속성에 데이터 추가
	    redirectAttributes.addFlashAttribute("member", member);
	    redirectAttributes.addFlashAttribute("payment", tempPay);
	    redirectAttributes.addFlashAttribute("impKey", orderService.getImpCode());

	    // 결제 정보 화면으로 리다이렉트
	    return "redirect:/order/order.do";
	}
	
	@PostMapping("/order/insertPay")
    public ResponseEntity<Map<String, Object>> createOrderByPaymentVO(@RequestBody PaymentVO paymentVO,HttpSession session) {
		// 세션에서 MemberVO 객체 가져오기
	    MemberVO member = (MemberVO) session.getAttribute("member");

	    // 테스트용 임시값 설정
	    if (member == null) {
	        member = new MemberVO();
	        member.setMember_no("1");
	        member.setName("홍길동");
	        member.setEmail("test@test.com");
	        member.setPhone("010-1234-4321");
	        session.setAttribute("member", member);
	    }
	    // 이때 최초로 주문건 생성(UUID 생성시점)
		OrderVO orderVO = new OrderVO();
		orderVO.setMember_no(member.getEmail());
		orderVO.setItem_no(paymentVO.getItem_no());
		orderVO.setGame_id(paymentVO.getGame_id());
		orderVO.setCoupon_no(10);
		orderVO.setOriginal_price(paymentVO.getTotal_price());
		orderVO.setReal_price(paymentVO.getTotal_price());
		orderVO.setPoint(100);
		
		// 생성한 주문건을 DB에 저장 
		OrderVO insertedOrder = orderService.insert(orderVO);
		
		Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("order", insertedOrder);
	    responseMap.put("payment", paymentVO);
	    responseMap.put("member", member);

	    try {
	        return new ResponseEntity<>(responseMap, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
    }
	
	@PostMapping("/order/auth")
    public ResponseEntity<String> validatePayment(@RequestBody Map<String, Object> data, HttpSession session) {
        // 포트원으로부터 받은 imp_uid, DB에 저장할때 사용한 order_no를 가져온다. 
		String imp_uid = (String) data.get("imp_uid");
	    String order_no = (String) data.get("order_no");
	    
	    // paymentData 처리
	    Map<String, Object> paymentDataMap = (Map<String, Object>) data.get("paymentData");
	    PaymentVO paymentData = new PaymentVO();
	    paymentData.setGame_id((Integer) paymentDataMap.get("game_id"));
	    paymentData.setItem_no((Integer) paymentDataMap.get("item_no"));
	    paymentData.setContent((String) paymentDataMap.get("content"));
	    paymentData.setA_seat_price((Integer) paymentDataMap.get("a_seat_price"));
	    paymentData.setB_seat_price((Integer) paymentDataMap.get("b_seat_price"));
	    paymentData.setC_seat_price((Integer) paymentDataMap.get("c_seat_price"));
	    paymentData.setD_seat_price((Integer) paymentDataMap.get("d_seat_price"));
	    paymentData.setVip_seat_price((Integer) paymentDataMap.get("vip_seat_price"));
	    paymentData.setA_seat_sold((Integer) paymentDataMap.get("a_seat_sold"));
	    paymentData.setB_seat_sold((Integer) paymentDataMap.get("b_seat_sold"));
	    paymentData.setC_seat_sold((Integer) paymentDataMap.get("c_seat_sold"));
	    paymentData.setD_seat_sold((Integer) paymentDataMap.get("d_seat_sold"));
	    paymentData.setVip_seat_sold((Integer) paymentDataMap.get("vip_seat_sold"));
	    paymentData.setCoupon_no((String) paymentDataMap.get("coupon_no"));
	    paymentData.setTotal_price((Integer) paymentDataMap.get("total_price"));
	    
	    // 세션에서 MemberVO 객체 가져오기
	    MemberVO member = (MemberVO) session.getAttribute("member");

	    // 테스트용 임시값 설정
	    if (member == null) {
	        member = new MemberVO();
	        member.setMember_no("1");
	        member.setName("홍길동");
	        member.setEmail("test@test.com");
	        member.setPhone("010-1234-4321");
	        session.setAttribute("member", member);
	    }
	    //System.out.println("paymentData : "+paymentData.toString());
	    //System.out.println("멤버 데이터 : "+member.toString());
	    
        //currentOrder은 order_no과 상관없이 포트원으로 부터 결제요청에 대한 응답으로 받은 imp_uid로 주문객체를 찾는다. 
        //현 상황 : 서버DB(imp_uid가 없는 즉, 결제 버튼을 누르기 직전의 주문 객체를 가지고 있다.)
        // rsp.imp_uid : 위의 서버DB에 저장된 객체를 포함해서 아임 포트로 결제 요청한 리턴 imp_uid 이다. 
        // 1. 일단 전달받은 imp_uid를 , 전달받은 order_no에 해당하는 주문에 insert 해주어야 한다. 
        // 1-1. order_no에 해당하는 orderVo 객체를 DB에서 찾아서 targetOrder 객체로 셋팅 
        OrderVO targetOrder = orderService.getOrderByOrderNo(order_no);
        // 1-2. 찾은 주문객체의 db에 imp_uid 셋팅하기 
        targetOrder.setImp_uid(imp_uid);
        // 1-3. imp_uid가 설정된 주문객체를 DB에 저장(uid만 업데이트 하면됨)
        OrderVO updatedOrder = orderService.insertUid(targetOrder);
        // 여기 까지 하면 이제 임시상태의 주문 객체에 imp_uid가 설정된 채로 DB에 존재하게 됨 
        // 따라서 아래와 같이 imp_uid로 조회가 가능해짐  
        OrderVO currentOrder = orderService.getOrderByImpUid(imp_uid);
        
        if (currentOrder == null) {
            return new ResponseEntity<>("Order not found", HttpStatus.BAD_REQUEST);
        }
        
        currentOrder.setOrder_no(order_no);
        boolean isValid = orderService.validatePayment(currentOrder);
        if (isValid) {
        	
        	//TODO 2 : 리스트<티켓> = orderService.createTicket(Map<String,Object> map);
        	// map 에는 OrderVo currentOrder,MemberVO member,PaymentVO paymentData 이렇게 3개의 객체를 모두 담는다. 
            Map<String, Object> ticketDataMap = new HashMap<>();
            ticketDataMap.put("order", currentOrder);
            ticketDataMap.put("member", member);
            ticketDataMap.put("payment", paymentData);
            List<TicketVO> ticketList = orderService.insertTicket(ticketDataMap);
            
            // TODO 3 : totalPrice의 1% 만큼 현재 회원의 point 컬럼에 증가시켜주기 
            
            // TODO 4 : 사용한 쿠폰을 쿠폰DB에서 coupon_no로 찾아서 상태를 used로 변경해주기 
            
            return new ResponseEntity<>("결제 유효성 검사 완료", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("결제 유효성 검사 실패", HttpStatus.BAD_REQUEST);
        }
    }
	
	@PostMapping("/order/insert")
    public ResponseEntity<OrderVO> createOrder(@RequestBody OrderVO orderVO) {
		OrderVO insertedOrder = orderService.insert(orderVO);
		try {
			return new ResponseEntity<>(insertedOrder, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
    }
	
	
	
	@PostMapping("/order/insert_uid")
    public ResponseEntity<OrderVO> insertUid(@RequestBody OrderVO orderVO) {
		OrderVO updatedOrder = orderService.insertUid(orderVO);
		try {
			return new ResponseEntity<>(updatedOrder, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
    }
	
	
	
}
