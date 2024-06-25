package kr.co.olympic.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.olympic.game.GameService;
import kr.co.olympic.game.GameVO;
import kr.co.olympic.member.MemberService;
import kr.co.olympic.member.MemberVO;

@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private GameService gameService;
	
	
	@GetMapping("/order/ticket_test.do")
	public String ticket_test(HttpSession session, Model model) {
		// 세션에서 MemberVO 객체 가져오기
	    MemberVO member = (MemberVO)session.getAttribute("login");
	    
	   	// 모델에 MemberVO 객체 추가
	    model.addAttribute("login", member);
	    //모델에 order 객체 추가 
	    List<OrderDTO> order = orderService.listOrder(member);
		model.addAttribute("order", order);
		return "/order/ticket_test";
	}
	
	
	@GetMapping("/order/getTicketDetails")
	public ResponseEntity<Map<String, Object>> getTicketDetails(@RequestParam("order_no") String orderNo) {
		Map<String, Object> response = new HashMap<>();
		try {
	      List<TicketVO> tickets = orderService.getTicketsByOrderNo(orderNo);	     
	      OrderVO order = orderService.getOrderByOrderNo(orderNo);
	      
	      Map<String, Object> map = new HashMap<>();
	      GameVO tGame = new GameVO();
	      tGame.setGame_id(order.getGame_id());
	      map.put("game", tGame);
	      GameVO game = gameService.detailGame(map);
	      
	      
	      response.put("tickets", tickets);
	      response.put("order", order);
	      response.put("game", game);
	      response.put("sport",game.getSport());
	      
	      return ResponseEntity.ok(response);
		} catch (Exception e) {
		  return ResponseEntity.status(500).body(Map.of("error", "티켓 상세 조회 실패"));
		}
	}
	
	@PostMapping("/order/checkAvailability")
	public ResponseEntity<Map<String, Boolean>> checkSeatAvailability(@RequestBody PaymentVO paymentVO) {
		Map<String, Boolean> seatAvailability = orderService.checkSeatAvailability(paymentVO);
		return ResponseEntity.ok(seatAvailability);
	}

	@GetMapping("/order/order.do")
	public String login(HttpSession session, Model model) {
		// 세션에서 MemberVO 객체 가져오기
		MemberVO member = (MemberVO) session.getAttribute("login");

		// 모델에 MemberVO 객체 추가
		model.addAttribute("login", member);
		return "/order/index";
	}

	@GetMapping("/order/cleanupExpiredReservations")
	public ResponseEntity<String> cleanupExpiredReservations(@RequestParam("item_no") int item_no) {
		try {
			orderService.cleanupExpiredReservations(item_no);
			return ResponseEntity.ok("Expired reservations cleaned up successfully.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred during cleanup.");
		}
	}

	@GetMapping("/order/test_temp.do")
	public String start_test(HttpSession session, Model model) {
		// 세션에서 MemberVO 객체 가져오기
		MemberVO member = (MemberVO) session.getAttribute("login");

		// 모델에 MemberVO 객체 추가
		model.addAttribute("login", member);
		return "/order/test_temp";
	}

	@GetMapping("/order/finish.do")
	public String showFinishPage(@RequestParam("order_no") String order_no, Model model) {
		List<TicketVO> ticketList = orderService.getTicketsByOrderNo(order_no);
		model.addAttribute("ticketList", ticketList);
		return "/order/finish";
	}

	@GetMapping("/order/getCouponDiscount.do")
	public int getCouponDiscount(String coupon_no) {
		return orderService.getCouponDiscount(coupon_no);
	}

	@PostMapping("/order/initOrder")
	public String initOrder(@ModelAttribute PaymentVO paymentVO, @RequestParam("a_seat_cnt") int aSeatCnt,
			@RequestParam("b_seat_cnt") int bSeatCnt, @RequestParam("c_seat_cnt") int cSeatCnt,
			@RequestParam("d_seat_cnt") int dSeatCnt, @RequestParam("vip_seat_cnt") int vipSeatCnt, HttpSession session,
			RedirectAttributes redirectAttributes) {

		// 세션에서 MemberVO 객체 가져오기
		MemberVO member = (MemberVO) session.getAttribute("login");

		// 회원 여부 검증
		if (member == null) {
			return "redirect:/login";
		}
		paymentVO.setA_seat_sold(aSeatCnt);
		paymentVO.setB_seat_sold(bSeatCnt);
		paymentVO.setC_seat_sold(cSeatCnt);
		paymentVO.setD_seat_sold(dSeatCnt);
		paymentVO.setVip_seat_sold(vipSeatCnt);

		Map<String, Boolean> seatAvailability = orderService.checkSeatAvailability(paymentVO);
		Map<String, Integer> countSeat = orderService.countSeatAvailability(paymentVO);

		// seatAvailability 출력
//		System.out.println("Seat Availability:");
//		seatAvailability
//				.forEach((key, value) -> System.out.println(key + ": " + (value ? "Available" : "Not Available")));

		// countSeat 출력
//		System.out.println("Seat Count:");
//		countSeat.forEach((key, value) -> System.out.println(key + ": " + value));

		if (seatAvailability.containsValue(false)) {
			// 좌석이 부족한 경우 메인 페이지로 리다이렉트
			redirectAttributes.addFlashAttribute("alertMessage", "선택한 좌석이 매진되었습니다. 다른 좌석을 선택해주세요.");
			return "redirect:/index.do";
		}

		// 사용자의 보유 쿠폰 리스트를 가져와서 PaymentVO에 설정하기 , 총 가격 계산해서 필드에 set
		PaymentVO tempPay = orderService.preparePaymentVO(member, paymentVO);
		tempPay.setTotal_price(tempPay.calculateTotalPrice());

		// 리다이렉트 속성에 데이터 추가
		redirectAttributes.addFlashAttribute("member", member);
		redirectAttributes.addFlashAttribute("payment", tempPay);
		redirectAttributes.addFlashAttribute("impKey", orderService.getImpCode());

		// 좌석이 충분한 경우에만 카운트업하기
		if (seatAvailability.values().stream().allMatch(available -> available)) {
			orderService.updateSeatSoldCount(paymentVO);
			// 임시 예약 테이블에 기록
			Map<String, Object> reservationParams = new HashMap<>();
			reservationParams.put("member", member);
			reservationParams.put("payment", paymentVO);
			orderService.recordEntryTime(member, paymentVO);
		}

		Map<String, Boolean> seatAvailability2 = orderService.checkSeatAvailability(paymentVO);
		Map<String, Integer> countSeat2 = orderService.countSeatAvailability(paymentVO);

		// seatAvailability 출력
//		System.out.println("Seat Availability2:");
//		seatAvailability2
//				.forEach((key, value) -> System.out.println(key + ": " + (value ? "Available" : "Not Available")));

		// countSeat 출력
//		System.out.println("Seat Count2:");
//		countSeat2.forEach((key, value) -> System.out.println(key + ": " + value));
		// 결제 정보 화면으로 리다이렉트
		return "redirect:/order/order.do";
	}

	// 결제 화면에서 결제 요청시 최초 동작하는 컨트롤러
	@PostMapping("/order/insertPay")
	public ResponseEntity<Map<String, Object>> createOrderByPaymentVO(@RequestBody PaymentVO paymentVO,
			HttpSession session) {
		// 세션에서 MemberVO 객체 가져오기
		MemberVO member = (MemberVO) session.getAttribute("login");

		// 이때 최초로 주문건 생성(UUID 생성시점)
		OrderVO orderVO = new OrderVO();
		orderVO.setMember_no(member.getMember_no());
		orderVO.setMember_email(member.getEmail());
		orderVO.setItem_no(paymentVO.getItem_no());
		orderVO.setGame_id(paymentVO.getGame_id());
		orderVO.setCoupon_no(paymentVO.getCoupon_no());
		orderVO.setOriginal_price(paymentVO.calculateTotalPrice());
		orderVO.setReal_price(paymentVO.getTotal_price());
		orderVO.setPoint((paymentVO.getTotal_price() / 100));
		orderVO.setIs_paid(0);
		orderVO.setIs_canceled(0);
		orderVO.setIs_refunded(0);

		// 생성한 주문건을 DB에 저장
		OrderVO insertedOrder = orderService.insert(orderVO);

		// 다시 order.js 파일의 비동기 함수로 res를 주기 위해 map에 정보 담기
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

	// order.js에서 포트원으로 결제요청 후 rsp로 imp_uid를 받아온뒤 다시 컨트롤러로 결제 유효성 검사 요청
	@PostMapping("/order/auth")
	public ResponseEntity<Map<String, String>> validatePayment(@RequestBody Map<String, Object> data,
			HttpSession session, RedirectAttributes redirectAttributes) {
		// 포트원으로부터 받은 imp_uid, DB에 저장할때 사용한 order_no를 가져온다.
		String imp_uid = (String) data.get("imp_uid");
		String order_no = (String) data.get("order_no");

		// paymentData 처리
		Map<String, Object> paymentDataMap = (Map<String, Object>) data.get("paymentData");
		PaymentVO paymentData = new PaymentVO();
		paymentData.setGame_id((Integer) paymentDataMap.get("game_id"));
		paymentData.setItem_no((Integer) paymentDataMap.get("item_no"));
		paymentData.setStadium_no((Integer) paymentDataMap.get("stadium_no"));
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
		MemberVO member = (MemberVO) session.getAttribute("login");

		// currentOrder은 order_no과 상관없이 포트원으로 부터 결제요청에 대한 응답으로 받은 imp_uid로 주문객체를 찾는다.
		// 현 상황 : 서버DB(imp_uid가 없는 즉, 결제 버튼을 누르기 직전의 주문 객체를 가지고 있다.)
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
			return new ResponseEntity<>(Map.of("message", "Order not found"), HttpStatus.BAD_REQUEST);
			// return new ResponseEntity<>("Order not found", HttpStatus.BAD_REQUEST);
		}

		currentOrder.setOrder_no(order_no);
		boolean isValid = orderService.validatePayment(currentOrder);
		if (isValid) {

			// TODO 2 : 리스트<티켓> = orderService.createTicket(Map<String,Object> map);
			// map 에는 OrderVo currentOrder,MemberVO member,PaymentVO paymentData 이렇게 3개의 객체를
			// 모두 담는다.
			Map<String, Object> ticketDataMap = new HashMap<>();
			ticketDataMap.put("order", currentOrder);
			ticketDataMap.put("member", member);
			ticketDataMap.put("payment", paymentData);
			List<TicketVO> ticketList = orderService.insertTicket(ticketDataMap);

			// TODO 3 : totalPrice의 1% 만큼 포인트객체 생성해서 DB에 저장하
			PointVO pointVO = new PointVO();
			pointVO.setContent(paymentData.getContent() + "적립 1%");
			pointVO.setMember_no(member.getMember_no());
			pointVO.setPoint(currentOrder.getPoint());
			pointVO.setUse(false); // false 가 적립건, true는 사용건
			orderService.insertPoint(pointVO);
			orderService.addPoint(member.getMember_no(), pointVO.getPoint());

			// TODO 4 : 사용한 쿠폰을 쿠폰DB에서 coupon_no로 찾아서 상태를 used로 변경해주기
			orderService.setCouponUsed(currentOrder.getCoupon_no());

			// TODO 5 : 결제 상태 paid로 DB 업데이트하기
			orderService.updateOrderStateToPaid(currentOrder);

			// TODO 7 : 임시 예약 테이블에 해당 item의 컬럼을 결제 완료로 변경해서 삭제되지 않도록하기
			Map<String, Object> reservationParams = new HashMap<>();
			reservationParams.put("member", member);
			reservationParams.put("payment", paymentData);
			orderService.updateReservationToConfirmed(reservationParams);

			return new ResponseEntity<>(Map.of("message", "결제 유효성 검사 완료", "order_no", order_no), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(Map.of("message", "결제 유효성 검사 실패"), HttpStatus.BAD_REQUEST);
		}
	}

	@PostMapping("/order/insert")
	public ResponseEntity<OrderVO> createOrder(@RequestBody OrderVO orderVO) {
		OrderVO insertedOrder = orderService.insert(orderVO);
		try {
			return new ResponseEntity<>(insertedOrder, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/order/insert_uid")
	public ResponseEntity<OrderVO> insertUid(@RequestBody OrderVO orderVO) {
		OrderVO updatedOrder = orderService.insertUid(orderVO);
		try {
			return new ResponseEntity<>(updatedOrder, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 받아야 하는 값: imp_uid, login정보
	@PostMapping("/order/cancel")
	public ResponseEntity<String> cancelOrder(@RequestBody OrderVO orderVO, HttpSession session, Model model) {
		MemberVO login = (MemberVO) session.getAttribute("login");
		String orderNo = orderVO.getOrder_no();
		OrderVO vo = orderService.getOrderByOrderNo(orderNo);
		
		System.out.println("컨트롤러 OrderVO:"+ vo);

        if (login == null) {
            return ResponseEntity.badRequest().body("로그인 후 이용하세요.");
        }
        try {
            int r = orderService.cancelOrder(vo);
            if (r == 0) {
                return ResponseEntity.badRequest().body("Order cancellation failed.");
            }
            if (r == 2) {
                return ResponseEntity.badRequest().body("This order has already been cancelled.");
            }
            return ResponseEntity.ok().body("Order cancellation successful");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

	}

}
