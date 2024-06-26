<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="UTF-8">
    <script src="../js/jquery-3.7.1.min.js"></script>
    <style>
    	img.small {
            width: 33.33%; /* 현재 크기의 1/3 */
            height: auto;
        }
    </style>
    <script>
        $(document).ready(function() {
            // 마이페이지 버튼 클릭 이벤트
            $('#mypageButton').on('click', function() {
                window.location.href = '/olympic/member/order.do';
            });

            // 현재 URL의 쿼리스트링에서 order_no 값을 가져와서 표시
            const urlParams = new URLSearchParams(window.location.search);
            const orderNo = urlParams.get('order_no');
            if (orderNo) {
                $('#orderNoSpan').text(orderNo);
            }
        });
    </script>
</head>
<body>
    <!-- 공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
    <%@include file="../common/modals.jsp"%>
    <!-- 타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <%@include file="../common/header.jsp"%>
    <!-- 헤더 하단 현재 경로 노출 -->
    <%@include file="../common/breadcrumb.jsp"%>
    <!-- CONTENT -->
    <section class="py-12">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-10 col-lg-8 col-xl-6 text-center">

                    <!-- Icon -->
                    <div class="mb-7 fs-1">
                        <img src="/olympic/img/olympic.png" alt="Olympic Logo" class="small"/>
                    </div>

                    <!-- Heading -->
                    <h2 class="mb-5">결제가 완료되었습니다!</h2>

                    <!-- Text -->
                    <p class="mb-7 text-gray-500">
                        주문 번호: <span class="text-body text-decoration-underline" id="orderNoSpan">673290789</span><br> 
                        티켓과 상세내역은 "마이페이지 - 예매 내역"을 이용해주세요.
                    </p>

                    <!-- Button -->
                    <a id="mypageButton" class="btn btn-dark" href="#!">
                        마이페이지
                    </a>

                </div>
            </div>
        </div>
    </section>
    <!-- 푸터 -->
    <%@include file="../common/footer.jsp"%>
</body>
</html>
