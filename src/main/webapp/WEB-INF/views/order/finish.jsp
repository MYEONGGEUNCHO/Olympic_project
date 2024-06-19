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
    
</head>
<body>
    <!--  공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
    <%@include file="../common/modals.jsp"%>
    <!--  타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <%@include file="../common/header.jsp"%>
    <!--  헤더 하단 현재 경로 노출 -->
    <%@include file="../common/breadcrumb.jsp"%>
    <h2>티켓 정보</h2>
    <p>결제가 완료되었습니다.</p>
    <table>
        <thead>
            <tr>
                <th>티켓 번호</th>
                <th>가격</th>
                <th>좌석 정보</th>
                <th>게임 ID</th>
                <th>상품 번호</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ticket" items="${ticketList}">
                <tr>
                    <td>${ticket.ticket_no}</td>
                    <td>${ticket.price}</td>
                    <td>${ticket.seat_info}</td>
                    <td>${ticket.game_id}</td>
                    <td>${ticket.item_no}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- 푸터  -->
    <%@include file="../common/footer.jsp"%>
</body>
</html>
