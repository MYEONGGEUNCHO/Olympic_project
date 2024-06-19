<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />

	<!-- Favicon -->
	<link rel="shortcut icon" href="/olympic/dist/assets/favicon/favicon.ico" type="image/x-icon" />
	
	<!-- Libs CSS -->
	<link rel="stylesheet" href="/olympic/dist/assets/css/libs.bundle.css" />
	
	<!-- Theme CSS -->
	<link rel="stylesheet" href="/olympic/dist/assets/css/theme.bundle.css" />
	<script src="../js/jquery-3.7.1.min.js"></script>
	    
    <title>결제 정보</title>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script> const IMP_KEY = "${impKey}"; </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/order.js"></script>
</head>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	
	<!-- 타이머를 표시할 요소 추가 -->
    <div id="countdown" style="font-size: 20px; color: red; margin-bottom: 20px;"></div>
    
    
    <h2>결제 정보</h2>
    <div>
        <p>구매자 이름: <span id="name">${member.name}</span></p>
        <p>이메일: <span id="email">${member.email}</span></p>
        <p>전화번호: <span id="phone">${member.phone}</span></p>
        <p>경기id: <span id="game_id">${payment.game_id}</span></p>
        <p>상품id: <span id="item_no">${payment.item_no}</span></p> 
        <p>상품상세: <span id="content">${payment.content}</span></p>
        <p>경기장 번호: <span id="stadium_no">${payment.stadium_no}</span></p>
        <p>예매 정보 확인:</p>
        <ul>
            <li>A좌석 가격: <span id="a_seat_price">${payment.a_seat_price}</span>원</li>
            <li>A좌석 개수: <span id="a_seat_sold">${payment.a_seat_sold}</span></li>
            <li>B좌석 가격: <span id="b_seat_price">${payment.b_seat_price}</span>원</li>
            <li>B좌석 개수: <span id="b_seat_sold">${payment.b_seat_sold}</span></li>
            <li>C좌석 가격: <span id="c_seat_price">${payment.c_seat_price}</span>원</li>
            <li>C좌석 개수: <span id="c_seat_sold">${payment.c_seat_sold}</span></li>
            <li>D좌석 가격: <span id="d_seat_price">${payment.d_seat_price}</span>원</li>
            <li>D좌석 개수: <span id="d_seat_sold">${payment.d_seat_sold}</span></li>
            <li>VIP좌석 가격: <span id="vip_seat_price">${payment.vip_seat_price}</span>원</li>
            <li>VIP좌석 개수: <span id="vip_seat_sold">${payment.vip_seat_sold}</span></li>
        </ul>
        <p>총 결제 금액: <span id="total_price">${payment.total_price}</span>원</p>
        
        <h3>쿠폰 선택</h3>
        <select id="coupon_select">
            <option value="">쿠폰을 선택하세요</option>
            <c:forEach var="coupon" items="${payment.coupon_list}">
                <option value="${coupon.coupon_no}" data-discount="${coupon.discount}">${coupon.content} (${coupon.discount}% 할인)</option>
            </c:forEach>
        </select>
        <button id="apply_coupon">쿠폰 적용</button>
        <button id="remove_coupon">쿠폰 선택 안함</button>
        
    </div>
    <button id="payButton">결제 요청</button>

    <!-- 히든 필드에 값을 저장 -->
    <input type="hidden" id="hidden_buyer_name" value="${member.name}">
    <input type="hidden" id="hidden_buyer_email" value="${member.email}">
    <input type="hidden" id="hidden_buyer_phone" value="${member.phone}">
    <input type="hidden" id="hidden_game_id" value="${payment.game_id}">
    <input type="hidden" id="hidden_item_no" value="${payment.item_no}">
    <input type="hidden" id="hidden_stadium_no" value="${payment.stadium_no }">
    <input type="hidden" id="hidden_content" value="${payment.content}">
    <input type="hidden" id="hidden_a_seat_price" value="${payment.a_seat_price}">
    <input type="hidden" id="hidden_a_seat_sold" value="${payment.a_seat_sold}">
    <input type="hidden" id="hidden_b_seat_price" value="${payment.b_seat_price}">
    <input type="hidden" id="hidden_b_seat_sold" value="${payment.b_seat_sold}">
    <input type="hidden" id="hidden_c_seat_price" value="${payment.c_seat_price}">
    <input type="hidden" id="hidden_c_seat_sold" value="${payment.c_seat_sold}">
    <input type="hidden" id="hidden_d_seat_price" value="${payment.d_seat_price}">
    <input type="hidden" id="hidden_d_seat_sold" value="${payment.d_seat_sold}">
    <input type="hidden" id="hidden_vip_seat_price" value="${payment.vip_seat_price}">
    <input type="hidden" id="hidden_vip_seat_sold" value="${payment.vip_seat_sold}">
    <input type="hidden" id="hidden_total_price" value="${payment.total_price}">
    <!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
	<script src="${pageContext.request.contextPath}/js/order.js"></script>
	
</body>
</html>
