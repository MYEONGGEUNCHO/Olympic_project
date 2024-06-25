<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="/olympic/dist/assets/favicon/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/olympic/dist/assets/css/libs.bundle.css" />
    <link rel="stylesheet" href="/olympic/dist/assets/css/theme.bundle.css" />
    <script src="../js/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script> const IMP_KEY = "${impKey}"; </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/order.js"></script>
    <style>
    	#timer-container {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    justify-content: center;
		    margin-top: 10px;
		}
		
		.progress-bar {
		    background-color: red;
		    animation: countdown 180s linear forwards;
		}
		
		@keyframes countdown {
		    from { width: 100%; }
		    to { width: 0%; }
		}
		
		#countdown {
		    font-size: 20px;
		    color: red;
		    margin-bottom: 10px;
		}
    </style>
    <title>결제 정보</title>
</head>
<body>
    <!-- 공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
    <%@include file="../common/modals.jsp"%>
    <!-- 타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <%@include file="../common/header.jsp"%>
    <!-- 헤더 하단 현재 경로 노출 -->
    <%@include file="../common/breadcrumb.jsp"%>

    <!-- 타이머를 표시할 요소 추가 -->
    <!-- <div id="countdown" style="font-size: 20px; color: red; margin-bottom: 20px;"></div> -->

    <section class="pt-7 pb-12">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h3 class="mb-4">결제 정보</h3>
                    <p class="mb-10">아래의 결제 정보를 확인해주세요.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-md-7">
                    <!-- Form -->
                    <form>
                        <!-- Heading -->
                        <h6 class="mb-7">구매자 정보</h6>
                        <!-- Billing details -->
                        <div class="row mb-9">
                            <div class="col-12 col-md-6">
                                <div class="form-group">
                                    <label class="form-label">이름</label>
                                    <input class="form-control form-control-sm" type="text" value="${member.name}" readonly>
                                </div>
                            </div>
                            <div class="col-12 col-md-6">
                                <div class="form-group">
                                    <label class="form-label">이메일</label>
                                    <input class="form-control form-control-sm" type="text" value="${member.email}" readonly>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">전화번호</label>
                                    <input class="form-control form-control-sm" type="text" value="${member.phone}" readonly>
                                </div>
                            </div>
                        </div>

                        <!-- Coupon selection -->
                        <h6 class="mb-7">쿠폰 선택</h6>
                        <div class="mb-9">
                            <select id="coupon_select" class="form-select">
                                <option value="">쿠폰을 선택하세요</option>
                                <c:forEach var="coupon" items="${payment.coupon_list}">
                                    <option value="${coupon.coupon_no}" data-discount="${coupon.discount}">${coupon.content} (${coupon.discount}% 할인)</option>
                                </c:forEach>
                            </select>
                            <button type="button" id="apply_coupon" class="btn btn-outline-dark mt-3">쿠폰 적용</button>
                            <button type="button" id="remove_coupon" class="btn btn-outline-dark mt-3">쿠폰 선택 안함</button>
                        </div>

                        <!-- Payment method -->
                        <h6 class="mb-7">결제 수단 선택</h6>
                        <div class="list-group list-group-sm mb-7">
                            <div class="list-group-item">
                                <div class="form-check custom-radio">
                                    <input class="form-check-input" id="checkoutPaymentKakaoPay" name="payment" type="radio" checked>
                                    <label class="form-check-label fs-sm text-body text-nowrap" for="checkoutPaymentKakaoPay">
                                        <img src="/olympic/img/payment/payment_icon_yellow_small.png" alt="KakaoPay Icon" style="height: 100%; margin-right: 10px;">
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Agreement -->
                        <div class="mb-7">
                            <div class="form-check">
                                <input class="form-check-input" id="agreement" type="checkbox" required>
                                <label class="form-check-label fs-sm" for="agreement">구매자 동의</label>
                            </div>
                            <p class="text-muted fs-sm mt-1">본 계약을 체결하는 것은 당사의<a class="text-reset text-decoration-underline ms-3" data-bs-toggle="modal" href="#modalTerms">상품 예약에 관한 약관</a>에 동의하는 것을 의미합니다.</p>
                        </div>
                        
                        <div id="timer-container" class="d-flex flex-column align-items-center">
						    <div id="countdown" style="font-size: 20px; color: red;"></div>
						    <div class="progress mt-2" style="width: 100%; height: 20px;">
						        <div id="progress-bar" class="progress-bar" role="progressbar" style="width: 100%;"></div>
						    </div>
						</div>

                        <!-- Hidden fields -->
                        <input type="hidden" id="hidden_buyer_name" value="${member.name}">
                        <input type="hidden" id="hidden_buyer_email" value="${member.email}">
                        <input type="hidden" id="hidden_buyer_phone" value="${member.phone}">
                        <input type="hidden" id="hidden_game_id" value="${payment.game_id}">
                        <input type="hidden" id="hidden_item_no" value="${payment.item_no}">
                        <input type="hidden" id="hidden_stadium_no" value="${payment.stadium_no}">
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
                    </form>
                </div>
                <div class="col-12 col-md-5 col-lg-4 offset-lg-1">
                    <!-- Order Items -->
                    <h6 class="mb-7">예매 정보 확인</h6>
                    <hr class="my-7">
                    <ul class="list-group list-group-lg list-group-flush-y list-group-flush-x mb-7">
                        <c:if test="${payment.a_seat_sold > 0}">
                            <li class="list-group-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <!-- Title -->
                                        <p class="mb-4 fs-sm fw-bold">
                                            A좌석 <br>
                                            <span class="text-muted"><fmt:formatNumber value="${payment.a_seat_price}" type="number" groupingUsed="true"/>원</span>
                                        </p>
                                        <!-- Text -->
                                        <div class="fs-sm text-muted">
                                            개수: ${payment.a_seat_sold}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${payment.b_seat_sold > 0}">
                            <li class="list-group-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <!-- Title -->
                                        <p class="mb-4 fs-sm fw-bold">
                                            B좌석 <br>
                                            <span class="text-muted"><fmt:formatNumber value="${payment.b_seat_price}" type="number" groupingUsed="true"/>원</span>
                                        </p>
                                        <!-- Text -->
                                        <div class="fs-sm text-muted">
                                            개수: ${payment.b_seat_sold}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${payment.c_seat_sold > 0}">
                            <li class="list-group-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <!-- Title -->
                                        <p class="mb-4 fs-sm fw-bold">
                                            C좌석 <br>
                                            <span class="text-muted"><fmt:formatNumber value="${payment.c_seat_price}" type="number" groupingUsed="true"/>원</span>
                                        </p>
                                        <!-- Text -->
                                        <div class="fs-sm text-muted">
                                            개수: ${payment.c_seat_sold}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${payment.d_seat_sold > 0}">
                            <li class="list-group-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <!-- Title -->
                                        <p class="mb-4 fs-sm fw-bold">
                                            D좌석 <br>
                                            <span class="text-muted"><fmt:formatNumber value="${payment.d_seat_price}" type="number" groupingUsed="true"/>원</span>
                                        </p>
                                        <!-- Text -->
                                        <div class="fs-sm text-muted">
                                            개수: ${payment.d_seat_sold}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${payment.vip_seat_sold > 0}">
                            <li class="list-group-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <!-- Title -->
                                        <p class="mb-4 fs-sm fw-bold">
                                            VIP좌석 <br>
                                            <span class="text-muted"><fmt:formatNumber value="${payment.vip_seat_price}" type="number" groupingUsed="true"/>원</span>
                                        </p>
                                        <!-- Text -->
                                        <div class="fs-sm text-muted">
                                            개수: ${payment.vip_seat_sold}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                    </ul>

                    <!-- Order Summary -->
                    <div class="card mb-9 bg-light">
                        <div class="card-body">
                            <ul class="list-group list-group-sm list-group-flush-y list-group-flush-x">
                                <li class="list-group-item d-flex">
                                    <span>금액</span> <span class="ms-auto fs-sm" id="total_price"><fmt:formatNumber value="${payment.total_price}" type="number" groupingUsed="true"/>원</span>
                                </li>
                                <li class="list-group-item d-flex">
                                    <span>쿠폰 할인 금액</span> <span class="ms-auto fs-sm" id="coupon_discount">0원</span>
                                </li>
                                <li class="list-group-item d-flex fs-lg fw-bold">
                                    <span>결제 금액</span> <span class="ms-auto" id="final_price"><fmt:formatNumber value="${payment.total_price}" type="number" groupingUsed="true"/>원</span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- 결제 요청 버튼 -->
                    <button id="payButton" class="btn w-100 btn-dark" disabled>결제 요청</button>
                    
                </div>
            </div>
        </div>
    </section>
    
    <!-- 약관 모달 -->
    <div class="modal fade" id="modalTerms" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
    
          <!-- Close -->
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            <i class="fe fe-x" aria-hidden="true"></i>
          </button>
    
          <!-- Header-->
          <div class="modal-header lh-fixed fs-lg">
            <strong class="mx-auto">상품 예약에 관한 약관</strong>
          </div>
    
          <!-- Body -->
          <div class="modal-body border-bottom">
            <p>상품 예약에 관한 약관입니다. 본 계약을 체결하는 것은 당사의 '상품 예약에 관한 약관'에 동의하는 것을 의미합니다. 고객님께서는 다음의 내용을 유의하시기 바랍니다.</p>
            <p>1. 예약 변경 및 취소는 예약 확정 후 24시간 이내에만 가능합니다. 이후에는 취소 및 변경이 불가합니다.</p>
            <p>2. 상품 예약 금액은 전액 선불로 결제되어야 하며, 결제가 완료되어야 예약이 확정됩니다.</p>
            <p>3. 예약 확정 후 발생하는 모든 추가 비용은 고객님의 부담입니다.</p>
            <p>4. 본 약관은 회사의 정책에 따라 언제든지 변경될 수 있으며, 변경된 약관은 웹사이트를 통해 공지됩니다.</p>
            <p>5. 기타 상세한 사항은 고객 서비스 센터를 통해 문의하시기 바랍니다.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 푸터 -->
    <%@include file="../common/footer.jsp"%>

     <script>
        $(document).ready(function() {
            function formatNumber(num) {
                return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원';
            }

            // 쿠폰 적용 버튼 클릭 시
            $('#apply_coupon').click(function() {
                var discount = $('#coupon_select option:selected').data('discount') || 0;
                var totalPrice = parseInt($('#total_price').text().replace(/[^0-9]/g, ''));
                var discountAmount = totalPrice * (discount / 100);
                var finalPrice = totalPrice - discountAmount;
                
				$('#total_price').text(formatNumber(totalPrice));
                $('#coupon_discount').text(formatNumber(discountAmount));
                $('#final_price').text(formatNumber(finalPrice));
            });

            // 쿠폰 선택 안함 버튼 클릭 시
            $('#remove_coupon').click(function() {
                $('#coupon_select').val('');
                var totalPrice = parseInt($('#total_price').text().replace(/[^0-9]/g, ''));
				
                $('#total_price').text(formatNumber(totalPrice));
                $('#coupon_discount').text('0원');
                $('#final_price').text(formatNumber(totalPrice));
            });

            // 예매자 동의 체크박스 클릭 시
            $('#agreement').change(function() {
                if ($(this).is(':checked')) {
                    $('#payButton').prop('disabled', false);
                } else {
                    $('#payButton').prop('disabled', true);
                }
            });
        });
    </script>
</body>
</html>
