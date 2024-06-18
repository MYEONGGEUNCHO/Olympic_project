package kr.co.olympic;


import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.olympic.member.MemberVO;
import kr.co.olympic.order.OrderMapper;
import kr.co.olympic.order.OrderVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration
public class OrderTest {

	@Autowired
    OrderMapper mapper;

    @Test
    public void insertOrderTest() {
        OrderVO order = new OrderVO();
        order.setBuy_date(new Timestamp(System.currentTimeMillis()));
        order.setState("ready");
        order.setMember_no("f57c671f-cf5a-4e20-a03a-8b895d625bb4");
        order.setItem_no(1);
        order.setGame_id(1);
        order.setCoupon_no("1");
        order.setImp_uid("imp_1234567890");
        order.setReal_price(10000);
        order.setOriginal_price(15000);
        order.setPoint(500);
        log.info("Insert 되기 전 Order: " + order);
        mapper.insertOrder(order);
    }

    @Test
    public void updateOrderTest() {
        OrderVO order = new OrderVO();
        order.setOrder_no("5ccf1d67-9105-4477-932e-184a5ba3d2ec");
        order.setState("paid");

        mapper.updateOrderStateToPaid(order);
    }

    @Test
    public void deleteOrderTest() {
        String orderNo = "f6b15762-8c1d-43ea-ab72-c53bcaeba371";
        OrderVO orderToDelete = mapper.getOrderById(orderNo);

        mapper.deleteOrder(orderNo);
    }
    
    @Test
    public void getMemberAvailablePoint() {
    	MemberVO member = new MemberVO();
        member.setMember_no("f57c671f-cf5a-4e20-a03a-8b895d625bb4");

        int temp = mapper.getTotalAvailablePoints(member);
        System.out.println(temp);
    }

    @Test
    public void getOrdersByMemberPagedTest() {
        MemberVO member = new MemberVO();
        member.setMember_no("1");

        int page = 1;
        int size = 10;
        int offset = (page - 1) * size;

        List<OrderVO> orders = mapper.getOrdersByMemberPaged(member, offset, size);
        orders.forEach(order -> log.info(order));
    }
    
    @Test
    public void listOrder() {
    	MemberVO member = new MemberVO();
    	member.setMember_no("test@test.com");
    	//mapper.listOrder(member);
    }
}
