<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올림픽 경기 일정</title>
<link rel="stylesheet" type="text/css" href="../css/game_detail.css" />

<script src="https://maps.googleapis.com/maps/api/js?key=${apikey}"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<script src="../js/game-detail.js"></script>
<script>
    console.log("${game}")
</script>
</head>
<body>
	<!--  타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<%@include file="/WEB-INF/views/common/modals.jsp"%>
	<!--  헤더 하단 현재 경로 노출 -->
	<%@include file="/WEB-INF/views/common/breadcrumb.jsp"%>
	<!--  메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<c:set var="a_seat_able" value="${game.stadium.a_seat_quantity - game.item.a_seat_sold}" />
	<c:set var="b_seat_able" value="${game.stadium.b_seat_quantity - game.item.b_seat_sold}" />
	<c:set var="c_seat_able" value="${game.stadium.c_seat_quantity - game.item.c_seat_sold}" />
	<c:set var="d_seat_able" value="${game.stadium.d_seat_quantity - game.item.d_seat_sold}" />
	<c:set var="vip_seat_able" value="${game.stadium.vip_seat_quantity - game.item.vip_seat_sold}" />
	<section>
		<!-- PRODUCT -->
		<section>
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="row">
							<div class="col-12 col-md-6">
								<div id="left_card">
									<div id="black_container"></div>
									<!-- 경기 이름 -->
									<div class="row mb-1">
										<div class="col d-flex flex-column ">
											<!-- 토너먼트 정보 -->
											<div id="game_info">
												<a class="text-muted" href="./index.do"> ${game.tournament}</a>
												<h3 class="mb-2">${game.sport_name}</h3>
												<div class="d-flex justify-content-center">
													<c:if test="${game.country1_name != ''}">
														<span>${game.country1_name}</span>
													</c:if>
													<c:if test="${game.country1_name == ''}">
														<span id="unknown_country">?</span>
													</c:if>
													&nbsp; VS &nbsp;
													<c:if test="${game.country2_name != ''}">
														<span>${game.country2_name}</span>
													</c:if>
													<c:if test="${game.country2_name == ''}">
														<span id="unknown_country">?</span>
													</c:if>
												</div>
											</div>
										</div>
									</div>

									<!-- 경기 대표 이미지 -->
									<img style="width: 100%;" src="${game.sport.title_image}" alt="">
								</div>
								<!-- 국가 정보 -->
								<div class="d-flex justify-content-evenly align-items-center mt-10">
									<c:if test="${game.country1_flag != ''}">

										<img src="${game.country1_flag}" alt="국가1" id="flag">
									</c:if>
									<c:if test="${game.country1_flag == ''}">
										<div id="unknown_flag">?</div>
									</c:if>
									VS
									<c:if test="${game.country2_flag != ''}">
										<img src="${game.country2_flag}" alt="국가2" id="flag">
									</c:if>
									<c:if test="${game.country2_flag == ''}">
										<div id="unknown_flag">?</div>
									</c:if>
								</div>
							</div>
							<div class="col-12 col-md-6 ps-lg-10">
								<h4>날짜</h4>
								<p>${game.korea_date}, ${game.korea_time}</p>
								<h4>경기장</h4>
								<span>📍${game.stadium_name}(${game.stadium.stadium_position})</span>

								<div id="map" style="width: 100%; height: 300px;"></div>
								<img style="width: 100%;" src="${game.stadium.stadium_img_url}" alt="">


							</div>
							<!--결제 선택 부분-->
							<form id="paymentForm" action="/olympic/order/initOrder" method="post">

								<div class="col-12 pt-3 pb-7 mb-7 bg-light d-flex flex-column">
									<div id="payment_header" class="d-flex flex-row fs-6 pb-2 mb-3 border-bottom border-2">
										<div class="ps-2 col-5 fw-bolder">좌석 선택</div>
										<div class="ps-2 col-7 fw-bolder">선택 정보 확인</div>
									</div>
									<div id="payment_content" class="d-flex">

										<!-- 좌석 선택-->
										<div id="seat_choice" class="col-5 d-flex flex-column">
											<div id="a_seat" class="d-flex justify-content-around align-items-baseline">
												<c:if test="${a_seat_able > 0}">
													<label class="fs-sm ms-1" for="a_seat_price">
														CAT A
														<span>(${a_seat_able}/${game.stadium.a_seat_quantity})</span>
													</label>
													<span class="ms-1 fs-5 fw-bolder text-primary" id="a_seat_price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${game.item.a_seat_price}" />
														<span class="fs-sm fw-normal text-body">원</span>

													</span>

												</c:if>
											</div>
											<div id="b_seat" class="d-flex justify-content-around align-items-baseline">
												<c:if test="${b_seat_able > 0 }">
													<label class="fs-sm ms-1" for="b_seat_price">
														CAT B
														<span>(${b_seat_able}/${game.stadium.b_seat_quantity})</span>
													</label>
													<span class="ms-1 fs-5 fw-bolder text-primary" id="b_seat_price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${game.item.b_seat_price}" />
														<span class="fs-sm fw-normal text-body">원</span>
													</span>
												</c:if>
											</div>
											<div id="c_seat" class="d-flex justify-content-around align-items-baseline">
												<c:if test="${c_seat_able > 0 }">
													<label class="fs-sm ms-1" for="c_seat_price">
														CAT C

														<span>(${c_seat_able}/${game.stadium.c_seat_quantity})</span>
													</label>
													<span class="ms-1 fs-5 fw-bolder text-primary" id="c_seat_price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${game.item.c_seat_price}" />
														<span class="fs-sm fw-normal text-body">원</span>
													</span>
												</c:if>
											</div>
											<div id="d_seat" class="d-flex justify-content-around align-items-baseline">
												<c:if test="${d_seat_able > 0 }">
													<label class="fs-sm ms-1" for="d_seat_price">
														CAT D
														<span>(${d_seat_able}/${game.stadium.d_seat_quantity})</span>

													</label>
													<span class="ms-1 fs-5 fw-bolder text-primary" id="d_seat_price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${game.item.d_seat_price}" />
														<span class="fs-sm fw-normal text-body">원</span>
													</span>
												</c:if>
											</div>
											<div id="vip_seat" class="d-flex justify-content-around align-items-baseline">
												<c:if test="${vip_seat_able > 0 }">
													<label class="fs-sm ms-1" for="vip_seat_price">
														VIP
														<span>(${vip_seat_able}/${game.stadium.vip_seat_quantity})</span>

													</label>
													<span class="ms-1 fs-5 fw-bolder text-primary" id="vip_seat_price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${game.item.vip_seat_price}" />
														<span class="fs-sm fw-normal text-body">원</span>
													</span>
												</c:if>
											</div>
										</div>
										<!-- 선택한 정보 확인 -->
										<div class="col-7 d-flex flex-column" id="choice_result">
											<!-- 동적 생성 -->
										</div>
										<input type="hidden" id="member_no" name="member_no" value="${login.member_no}">
										<input type="hidden" id="game_id" name="game_id" value="${game.game_id}">
										<input type="hidden" id="item_no" name="item_no" value="${game.item.item_no}">
										<input type="hidden" id="stadium_no" name="stadium_no" value="${game.stadium_no}">
										<input type="hidden" id="stadium_pos" name="stadium_pos" value="${game.stadium.stadium_position}">
										<input type="hidden" id="content" name="content" value="${game.tournament}">
										<input type="hidden" id="a_seat_price_info" name="a_seat_price" value="${game.item.a_seat_price}">
										<input type="hidden" id="b_seat_price_info" name="b_seat_price" value="${game.item.b_seat_price}">
										<input type="hidden" id="c_seat_price_info" name="c_seat_price" value="${game.item.c_seat_price}">
										<input type="hidden" id="d_seat_price_info" name="d_seat_price" value="${game.item.d_seat_price}">
										<input type="hidden" id="vip_seat_price_info" name="vip_seat_price" value="${game.item.vip_seat_price}">
										<input type="hidden" id="a_seat_cnt" name="a_seat_cnt" value="0">
										<input type="hidden" id="b_seat_cnt" name="b_seat_cnt" value="0">
										<input type="hidden" id="c_seat_cnt" name="c_seat_cnt" value="0">
										<input type="hidden" id="d_seat_cnt" name="d_seat_cnt" value="0">
										<input type="hidden" id="vip_seat_cnt" name="vip_seat_cnt" value="0">
									</div>


								</div>
								<div class="pb-5 text-end">
									합계 금액 :
									<span id="choice_sum">0</span>
									원
								</div>
								<div class="row gx-5 mb-7">
									<div class="col-12 col-lg">

										<!-- Submit -->
										<button type="submit" class="btn w-100 btn-dark mb-2">
											구매하기 <i class="fe fe-shopping-cart ms-2"></i>
										</button>

									</div>
									<!-- 									<div class="col-12 col-lg-auto"> -->

									<!-- 										Wishlist -->
									<%-- 										<button type="button" class="btn btn-outline-dark w-100 mb-2" data-toggle="button" onclick="add_favorite(${game.game_id});"> --%>
									<!-- 											관심 등록 <i class="fe fe-heart ms-2"></i> -->
									<!-- 										</button> -->

									<!-- 									</div> -->
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- 		댓글 부분 -->
		<section class="pt-11">
			<div class="container">
				<div class="row">
					<h4>댓글</h4>
					<div id="listComment"></div>
					<input type="text" id="commentContent">
					<button id="createComment" type="button">댓글 등록</button>
				</div>
			</div>
		</section>
		<!-- 게시글 상세 설명 -->
		<section class="pt-11">
			<div class="container">
				<div class="row">
					<div class="col-12">

						<!-- Nav -->
						<div class="nav nav-tabs nav-overflow justify-content-start justify-content-md-center border-bottom">
							<a class="nav-link active" data-bs-toggle="tab" href="#descriptionTab"> Description </a>
							<a class="nav-link" data-bs-toggle="tab" href="#sizeTab"> Size & Fit </a>
							<a class="nav-link" data-bs-toggle="tab" href="#shippingTab"> Shipping & Return </a>
						</div>

						<!-- Content -->
						<div class="tab-content">
							<div class="tab-pane fade show active" id="descriptionTab">
								<div class="row justify-content-center py-9">
									<div class="col-12 col-lg-10 col-xl-8">
										<div class="row">
											<h4>종목 정보</h4>
											<p>${game.sport_name}</p>
											<p>종목 설명</p>
											<p>${game.sport.sport_info}</p>
											<p>종목 규칙</p>
											<p>${game.sport.sport_rule}</p>
											<p>올림픽 역사</p>
											<p>${game.sport.sport_history}</p>

										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="sizeTab">
								<div class="row justify-content-center py-9">
									<div class="col-12 col-lg-10 col-xl-8">
										<div class="row">
											<div class="col-12 col-md-6">

												<!-- Text -->
												<p class="mb-4">
													<strong>Fitting information:</strong>
												</p>

												<!-- List -->
												<ul class="mb-md-0 text-gray-500">
													<li>Upon seas hath every years have whose subdue creeping they're it were.</li>
													<li>Make great day bearing.</li>
													<li>For the moveth is days don't said days.</li>
												</ul>

											</div>
											<div class="col-12 col-md-6">

												<!-- Text -->
												<p class="mb-4">
													<strong>Model measurements:</strong>
												</p>

												<!-- List -->
												<ul class="list-unstyled text-gray-500">
													<li>Height: 1.80 m</li>
													<li>Bust/Chest: 89 cm</li>
													<li>Hips: 91 cm</li>
													<li>Waist: 65 cm</li>
													<li>Model size: M</li>
												</ul>

												<!-- Size -->
												<p class="mb-0">
													<img src="assets/img/icons/icon-ruler.svg" alt="..." class="img-fluid">
													<a class="text-reset text-decoration-underline ms-3" data-bs-toggle="modal" href="#modalSizeChart">Size chart</a>
												</p>

											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="shippingTab">
								<div class="row justify-content-center py-9">
									<div class="col-12 col-lg-10 col-xl-8">

										<!-- Table -->
										<div class="table-responsive">
											<table class="table table-bordered table-sm table-hover">
												<thead>
													<tr>
														<th>Shipping Options</th>
														<th>Delivery Time</th>
														<th>Price</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Standard Shipping</td>
														<td>Delivery in 5 - 7 working days</td>
														<td>$8.00</td>
													</tr>
													<tr>
														<td>Express Shipping</td>
														<td>Delivery in 3 - 5 working days</td>
														<td>$12.00</td>
													</tr>
													<tr>
														<td>1 - 2 day Shipping</td>
														<td>Delivery in 1 - 2 working days</td>
														<td>$12.00</td>
													</tr>
													<tr>
														<td>Free Shipping</td>
														<td>Living won't the He one every subdue meat replenish face was you morning firmament darkness.</td>
														<td>$0.00</td>
													</tr>
												</tbody>
											</table>
										</div>

										<!-- Caption -->
										<p class="mb-0 text-gray-500">
											May, life blessed night so creature likeness their, for.
											<a class="text-body text-decoration-underline" href="#!">Find out more</a>
										</p>

									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>
		<section class="py-11">
			<div class="container">
				<h4>문의 사항</h4>
				<%@include file="./qna_list.jsp"%>
			</div>
		</section>
		<!-- 푸터  -->
		<%@include file="/WEB-INF/views/common/footer.jsp"%>
	</section>
</body>
</html>
