package kr.co.olympic.order;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	
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
		System.out.println("OrderServieImpl 의 insert 메서드");
		mapper.insertOrder(vo);
		return mapper.getOrderById(vo.getOrder_no());
	}
	
	@Override
	public OrderVO insertUid(OrderVO vo) {
		System.out.println("OrderServieImpl 의 insertUid 메서드");
		mapper.insertUid(vo);
		return mapper.getOrderById(vo.getOrder_no());
	}
	
	@Override
	public OrderVO getOrderByImpUid(String imp_uid) {
		System.out.println("OrderServieImpl 의 getOrderByImpUid 메서드");
		return mapper.getOrderByImpUid(imp_uid);
	}
	
	@Override
	public OrderVO getOrderByOrderNo(String order_no) {
		System.out.println("OrderServieImpl 의 getOrderByOrderNo 메서드");
		return mapper.getOrderById(order_no);
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
            orderVO.setMember_no((String) responseBody.get("buyer_email"));
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
            		paidOrder.getMember_no().equals(myOrder.getMember_no());
        }
       
    }

}
