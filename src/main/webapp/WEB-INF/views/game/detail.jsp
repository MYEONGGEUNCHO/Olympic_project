<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올림픽 경기 일정</title>
<style>
#unknown_flag {
	width: 100px;
	border-radius: 50%;
	height: 100px;
	background: gray;
	text-align: center;
	line-height: 100px;
	font-size: 60px;
}
</style>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
    console.log('${game}');
</script>
</head>
<body>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="/WEB-INF/views/common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->

	<!-- 가져올곳 시작 -->
	<!-- Product -->
	<div class="modal fade" id="modalProduct" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl" role="document">
			<div class="modal-content">

				<!-- Close -->
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
					<i class="fe fe-x" aria-hidden="true"></i>
				</button>

				<!-- Content -->
				<div class="container-fluid px-xl-0">
					<div class="row align-items-center mx-xl-0">
						<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">

							<!-- Image -->
							<img class="img-fluid" src="/olympic/dist/assets/img/products/product-7.jpg" alt="...">

							<!-- Button -->
							<a class="btn btn-sm w-100 btn-primary" href="./product.html">
								More Product Info <i class="fe fe-info ms-2"></i>
							</a>

						</div>
						<div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">

							<!-- Heading -->
							<h4 class="mb-3">Leather Sneakers</h4>

							<!-- Price -->
							<div class="mb-7">
								<span class="h5">$85.00</span>
								<span class="fs-sm">(In Stock)</span>
							</div>

							<!-- Form -->
							<form>
								<div class="form-group">

									<!-- Label -->
									<p>
										Color: <strong id="modalProductColorCaption">White</strong>
									</p>

									<!-- Radio -->
									<div class="mb-8 ms-n1">
										<div class="form-check form-check-inline form-check-img">
											<input type="radio" class="form-check-input" id="modalProductColorOne" name="modalProductColor" data-toggle="form-caption" data-target="#modalProductColorCaption" value="White" style="background-image: url(./assets/img/products/product-7.jpg);" checked>
										</div>
										<div class="form-check form-check-inline form-check-img">
											<input type="radio" class="form-check-input" id="modalProductColorTwo" name="modalProductColor" data-toggle="form-caption" data-target="#modalProductColorCaption" value="Black" style="background-image: url(./assets/img/products/product-49.jpg);">
										</div>
									</div>

								</div>
								<div class="form-group">

									<!-- Label -->
									<p>
										Size: <strong><span id="modalProductSizeCaption">7.5</span> US</strong>
									</p>

									<!-- Radio -->
									<div class="mb-2">
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeOne" value="6" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeOne">6</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeTwo" value="6.5" data-toggle="form-caption" data-target="#modalProductSizeCaption" disabled>
											<label class="form-check-label" for="modalProductSizeTwo">6.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeThree" value="7" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeThree">7</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeFour" value="7.5" data-toggle="form-caption" data-target="#modalProductSizeCaption" checked>
											<label class="form-check-label" for="modalProductSizeFour">7.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeFive" value="8" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeFive">8</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeSix" value="8.5" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeSix">8.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeSeven" value="9" data-toggle="form-caption" data-target="#modalProductSizeCaption" disabled>
											<label class="form-check-label" for="modalProductSizeSeven">9</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeEight" value="9.5" data-toggle="form-caption" data-target="#modalProductSizeCaption" disabled>
											<label class="form-check-label" for="modalProductSizeEight">9.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeNine" value="10" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeNine">10</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeTen" value="10.5" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeTen">10.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeEleven" value="11" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeEleven">11</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeTwelve" value="12" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeTwelve">12</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeThirteen" value="13" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeThirteen">13</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeFourteen" value="14" data-toggle="form-caption" data-target="#modalProductSizeCaption">
											<label class="form-check-label" for="modalProductSizeFourteen">14</label>
										</div>
									</div>

								</div>
								<div class="form-group mb-0">
									<div class="row gx-5">
										<div class="col-12 col-lg-auto">

											<!-- Quantity -->
											<select class="form-select mb-2">
												<option value="1" selected>1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
											</select>

										</div>
										<div class="col-12 col-lg">

											<!-- Submit -->
											<button type="submit" class="btn w-100 btn-dark mb-2">
												Add to Cart <i class="fe fe-shopping-cart ms-2"></i>
											</button>

										</div>
										<div class="col-12 col-lg-auto">

											<!-- Wishlist -->
											<button class="btn btn-outline-dark w-100 mb-2" data-toggle="button">
												Wishlist <i class="fe fe-heart ms-2"></i>
											</button>

										</div>
									</div>
								</div>
							</form>

						</div>
					</div>
				</div>
				<!-- Content END -->
			</div>
		</div>
	</div>

	<!-- Search -->
	<div class="offcanvas offcanvas-end" id="modalSearch" tabindex="-1" role="dialog" aria-hidden="true">

		<!-- Close -->
		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
			<i class="fe fe-x" aria-hidden="true"></i>
		</button>

		<!-- Header-->
		<div class="offcanvas-header lh-fixed fs-lg">
			<strong class="mx-auto">Search Products</strong>
		</div>

		<!-- Body: Form -->
		<div class="offcanvas-body">
			<form>
				<div class="form-group">
					<label class="visually-hidden" for="modalSearchCategories">Categories:</label>
					<select class="form-select" id="modalSearchCategories">
						<option selected>All Categories</option>
						<option>Women</option>
						<option>Men</option>
						<option>Kids</option>
					</select>
				</div>
				<div class="input-group input-group-merge">
					<input class="form-control" type="search" placeholder="Search">
					<div class="input-group-append">
						<button class="btn btn-outline-border" type="submit">
							<i class="fe fe-search"></i>
						</button>
					</div>
				</div>
			</form>
		</div>

		<!-- Body: Results (add `.d-none` to disable it) -->
		<div class="offcanvas-body border-top fs-sm">

			<!-- Heading -->
			<p>Search Results:</p>

			<!-- Items -->
			<div class="row align-items-center position-relative mb-5">
				<div class="col-4 col-md-3">

					<!-- Image -->
					<img class="img-fluid" src="/olympic/dist/assets/img/products/product-5.jpg" alt="...">

				</div>
				<div class="col position-static">

					<!-- Text -->
					<p class="mb-0 fw-bold">
						<a class="stretched-link text-body" href="./product.html">Leather mid-heel Sandals</a>
						<br>
						<span class="text-muted">$129.00</span>
					</p>

				</div>
			</div>
			<div class="row align-items-center position-relative mb-5">
				<div class="col-4 col-md-3">

					<!-- Image -->
					<img class="img-fluid" src="/olympic/dist/assets/img/products/product-6.jpg" alt="...">

				</div>
				<div class="col position-static">

					<!-- Text -->
					<p class="mb-0 fw-bold">
						<a class="stretched-link text-body" href="./product.html">Cotton floral print Dress</a>
						<br>
						<span class="text-muted">$40.00</span>
					</p>

				</div>
			</div>
			<div class="row align-items-center position-relative mb-5">
				<div class="col-4 col-md-3">

					<!-- Image -->
					<img class="img-fluid" src="/olympic/dist/assets/img/products/product-7.jpg" alt="...">

				</div>
				<div class="col position-static">

					<!-- Text -->
					<p class="mb-0 fw-bold">
						<a class="stretched-link text-body" href="./product.html">Leather Sneakers</a>
						<br>
						<span class="text-primary">$85.00</span>
					</p>

				</div>
			</div>
			<div class="row align-items-center position-relative mb-5">
				<div class="col-4 col-md-3">

					<!-- Image -->
					<img class="img-fluid" src="/olympic/dist/assets/img/products/product-8.jpg" alt="...">

				</div>
				<div class="col position-static">

					<!-- Text -->
					<p class="mb-0 fw-bold">
						<a class="stretched-link text-body" href="./product.html">Cropped cotton Top</a>
						<br>
						<span class="text-muted">$29.00</span>
					</p>

				</div>
			</div>
			<div class="row align-items-center position-relative mb-5">
				<div class="col-4 col-md-3">

					<!-- Image -->
					<img class="img-fluid" src="/olympic/dist/assets/img/products/product-9.jpg" alt="...">

				</div>
				<div class="col position-static">

					<!-- Text -->
					<p class="mb-0 fw-bold">
						<a class="stretched-link text-body" href="./product.html">Floral print midi Dress</a>
						<br>
						<span class="text-muted">$50.00</span>
					</p>

				</div>
			</div>

			<!-- Button -->
			<a class="btn btn-link px-0 text-reset" href="./shop.html">
				View All <i class="fe fe-arrow-right ms-2"></i>
			</a>

		</div>

		<!-- Body: Empty (remove `.d-none` to enable it) -->
		<div class="offcanvas-body d-none">

			<!-- Text -->
			<p class="mb-3 fs-sm text-center">Nothing matches your search</p>

			<!-- Smiley -->
			<p class="mb-0 fs-sm text-center">😞</p>

		</div>

	</div>

	<!-- Shopping Cart -->
	<div class="offcanvas offcanvas-end" id="modalShoppingCart" tabindex="-1" role="dialog" aria-hidden="true">

		<!-- Full cart (add `.d-none` to disable it) -->

		<!-- Close -->
		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
			<i class="fe fe-x" aria-hidden="true"></i>
		</button>

		<!-- Header-->
		<div class="offcanvas-header lh-fixed fs-lg">
			<strong class="mx-auto">Your Cart (2)</strong>
		</div>

		<!-- List group -->
		<ul class="list-group list-group-lg list-group-flush">
			<li class="list-group-item">
				<div class="row align-items-center">
					<div class="col-4">

						<!-- Image -->
						<a href="./product.html">
							<img class="img-fluid" src="/olympic/dist/assets/img/products/product-6.jpg" alt="...">
						</a>

					</div>
					<div class="col-8">

						<!-- Title -->
						<p class="fs-sm fw-bold mb-6">
							<a class="text-body" href="./product.html">Cotton floral print Dress</a>
							<br>
							<span class="text-muted">$40.00</span>
						</p>

						<!--Footer -->
						<div class="d-flex align-items-center">

							<!-- Select -->
							<select class="form-select form-select-xxs w-auto">
								<option value="1">1</option>
								<option value="1">2</option>
								<option value="1">3</option>
							</select>

							<!-- Remove -->
							<a class="fs-xs text-gray-400 ms-auto" href="#!">
								<i class="fe fe-x"></i> Remove
							</a>

						</div>

					</div>
				</div>
			</li>
			<li class="list-group-item">
				<div class="row align-items-center">
					<div class="col-4">

						<!-- Image -->
						<a href="./product.html">
							<img class="img-fluid" src="/olympic/dist/assets/img/products/product-10.jpg" alt="...">
						</a>

					</div>
					<div class="col-8">

						<!-- Title -->
						<p class="fs-sm fw-bold mb-6">
							<a class="text-body" href="./product.html">Suede cross body Bag</a>
							<br>
							<span class="text-muted">$49.00</span>
						</p>

						<!--Footer -->
						<div class="d-flex align-items-center">

							<!-- Select -->
							<select class="form-select form-select-xxs w-auto">
								<option value="1">1</option>
								<option value="1">2</option>
								<option value="1">3</option>
							</select>

							<!-- Remove -->
							<a class="fs-xs text-gray-400 ms-auto" href="#!">
								<i class="fe fe-x"></i> Remove
							</a>

						</div>

					</div>
				</div>
			</li>
		</ul>

		<!-- Footer -->
		<div class="offcanvas-footer justify-between lh-fixed fs-sm bg-light mt-auto">
			<strong>Subtotal</strong> <strong class="ms-auto">$89.00</strong>
		</div>

		<!-- Buttons -->
		<div class="offcanvas-body">
			<a class="btn w-100 btn-dark" href="./checkout.html">Continue to Checkout</a>
			<a class="btn w-100 btn-outline-dark mt-2" href="./shopping-cart.html">View Cart</a>
		</div>

		<!-- Empty cart (remove `.d-none` to enable it) -->
		<div class="d-none">

			<!-- Close -->
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
				<i class="fe fe-x" aria-hidden="true"></i>
			</button>

			<!-- Header-->
			<div class="offcanvas-header lh-fixed fs-lg">
				<strong class="mx-auto">Your Cart (0)</strong>
			</div>

			<!-- Body -->
			<div class="offcanvas-body flex-grow-0 my-auto">

				<!-- Heading -->
				<h6 class="mb-7 text-center">Your cart is empty 😞</h6>

				<!-- Button -->
				<a class="btn w-100 btn-outline-dark" href="#!"> Continue Shopping </a>

			</div>

		</div>

	</div>

	<!-- Sidebar -->
	<div class="offcanvas offcanvas-end" id="modalSidebar" tabindex="-1" role="dialog" aria-hidden="true">

		<!-- Close -->
		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">
			<i class="fe fe-x" aria-hidden="true"></i>
		</button>

		<!-- Body -->
		<div class="offcanvas-body px-10 my-auto">

			<!-- Nav -->
			<ul class="nav nav-vertical nav-unstyled fs-2" id="sidebarNav">
				<li class="nav-item">

					<!-- Toggle -->
					<a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sidebarHome"> Home </a>

					<!-- Collapse -->
					<div class="collapse" id="sidebarHome" data-bs-parent="#sidebarNav">
						<ul class="list-styled fs-lg py-3 mb-0">
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index.html">Default</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-classic.html">Classic</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-fashion.html">Fashion</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-boxed.html">Boxed</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-simple.html">Simple</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-asymmetric.html">Asymmetric</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-sidenav.html">Sidenav</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./index-landing.html">Landing</a>
							</li>
						</ul>
					</div>

				</li>
				<li class="nav-item">

					<!-- Toggle -->
					<a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sidebarCatalog"> Catalog </a>

					<!-- Collapse -->
					<div class="collapse" id="sidebarCatalog" data-bs-parent="#sidebarNav">
						<div class="row">
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5 fw-bold">Clothing</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg py-3">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">All Clothing</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Blouses & Shirts</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Coats & Jackets</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Dresses</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Hoodies & Sweats</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Denim</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Jeans</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Jumpers & Cardigans</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Leggings</a>
									</li>
								</ul>

							</div>
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5 fw-bold">Shoes & Boots</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">All Shoes & Boots</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Branded Shoes</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Boots</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Heels</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Trainers</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Sandals</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Shoes</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Wide Fit Shoes</a>
									</li>
								</ul>

							</div>
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5 fw-bold">Bags & Accessories</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">All Bags & Accessories</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Accessories</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Bags & Purses</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Luggage</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Belts</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Hats</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Hair Accessories</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Jewellery</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Travel Accessories</a>
									</li>
								</ul>

							</div>
						</div>
					</div>

				</li>
				<li class="nav-item">

					<!-- Toggle -->
					<a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sidebarShop"> Shop </a>

					<!-- Collapse -->
					<div class="collapse" id="sidebarShop" data-bs-parent="#sidebarNav">
						<div class="row">
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5">Shop</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop.html">Default</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop-topbar.html">Topbar</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop-collapse.html">Collapse</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop-simple.html">Simple</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shop-masonry.html">Masonry</a>
									</li>
								</ul>

							</div>
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5">Product</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./product.html">Default</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./product-images-left.html">Images Left</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./product-image-grid.html">Image Grid</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./product-image-slider.html">Image Slider</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./product-images-stacked.html">Images Stacked</a>
									</li>
								</ul>

							</div>
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5">Support</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shopping-cart.html">Shopping Cart</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./checkout.html">Checkout</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./order-completed.html">Order Completed</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./shipping-and-returns.html">Shipping & Returns</a>
									</li>
								</ul>

							</div>
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5">Account</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-order.html">Order</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-orders.html">Orders</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-wishlist.html">Wishlist</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-personal-info.html">Personal Info</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-address.html">Addresses</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-address-edit.html">Addresses: New</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-payment.html">Payment</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-payment-edit.html">Payment: New</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./account-payment-choose.html">Payment: Choose</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="./auth.html">Auth</a>
									</li>
								</ul>

							</div>
							<div class="col-12 py-3">

								<!-- Heading -->
								<h6 class="mb-5">Modals</h6>

								<!-- Links -->
								<ul class="list-styled fs-lg">
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="modal" href="#modalNewsletterHorizontal"> Newsletter: Horizontal </a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="modal" href="#modalNewsletterVertical"> Newsletter: Vertical </a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="modal" href="#modalProduct"> Product </a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="offcanvas" href="#modalSearch"> Search </a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="offcanvas" href="#modalShoppingCart"> Shopping Cart </a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="modal" href="#modalSizeChart"> Size Chart </a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" data-bs-toggle="modal" href="#modalWaitList"> Wait List </a>
									</li>
								</ul>

							</div>
						</div>
					</div>

				</li>
				<li class="nav-item">

					<!-- Toggle -->
					<a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sidebarPages"> Pages </a>

					<!-- Collapse -->
					<div class="collapse" id="sidebarPages" data-bs-parent="#sidebarNav">
						<ul class="list-styled fs-lg py-3 mb-0">
							<li class="list-styled-item">
								<a class="list-styled-link" href="./about.html">About</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./contact-us.html">Contact Us</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./store-locator.html">Store Locator</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./faq.html">FAQ</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./coming-soon.html">Coming Soon</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./404.html">404</a>
							</li>
						</ul>
					</div>

				</li>
				<li class="nav-item">

					<!-- Toggle -->
					<a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sidebarBlog"> Blog </a>

					<!-- Collapse -->
					<div class="collapse" id="sidebarBlog" data-bs-parent="#sidebarNav">
						<ul class="list-styled fs-lg py-3 mb-0">
							<li class="list-styled-item">
								<a class="list-styled-link" href="./blog.html">Blog</a>
							</li>
							<li class="list-styled-item">
								<a class="list-styled-link" href="./blog-post.html">Blog Post</a>
							</li>
						</ul>
					</div>

				</li>
				<li class="nav-item">
					<a class="nav-link" href="./docs/getting-started.html">Docs</a>
				</li>
			</ul>

		</div>

		<!-- Body -->
		<div class="moda-body px-10 py-9">

			<!-- Social links -->
			<ul class="list-inline">
				<li class="list-inline-item">
					<a class="text-gray-350" href="#!">
						<i class="fab fa-facebook-f"></i>
					</a>
				</li>
				<li class="list-inline-item">
					<a class="text-gray-350" href="#!">
						<i class="fab fa-youtube"></i>
					</a>
				</li>
				<li class="list-inline-item">
					<a class="text-gray-350" href="#!">
						<i class="fab fa-twitter"></i>
					</a>
				</li>
				<li class="list-inline-item">
					<a class="text-gray-350" href="#!">
						<i class="fab fa-instagram"></i>
					</a>
				</li>
				<li class="list-inline-item">
					<a class="text-gray-350" href="#!">
						<i class="fab fa-medium-m"></i>
					</a>
				</li>
			</ul>

			<!-- Footer -->
			<div class="fs-xxs text-gray-350">© 2019 All rights reserved. Designed by Unvab.</div>

		</div>

	</div>

	<!-- Size Chart -->
	<div class="modal fade" id="modalSizeChart" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
			<div class="modal-content">

				<!-- Close -->
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
					<i class="fe fe-x" aria-hidden="true"></i>
				</button>

				<!-- Header-->
				<div class="modal-header lh-fixed fs-lg">
					<strong class="mx-auto">Size Chart</strong>
				</div>

				<!-- Body -->
				<div class="modal-body border-bottom">

					<!-- Header -->
					<div class="d-flex mb-7">

						<!-- Heading -->
						<h5 class="mb-0">Clothing</h5>

						<!-- Inputs -->
						<div class="ms-auto">

							<!-- IN -->
							<input type="radio" class="btn-check" name="modalSizeChartUnitOne" id="inOne" checked>
							<label class="btn btn-xxs btn-circle btn-outline-dark fs-xxxs rounded-0" for="inOne">IN</label>

							<!-- CM -->
							<input type="radio" class="btn-check" name="modalSizeChartUnitOne" id="cmOne">
							<label class="btn btn-xxs btn-circle btn-outline-dark fs-xxxs rounded-0" for="cmOne">CM</label>

						</div>

					</div>

					<!-- Table -->
					<div class="table-responsive">
						<table class="table table-bordered table-sm table-hover mb-0">
							<thead>
								<tr>
									<th>Size</th>
									<th>US</th>
									<th>Bust</th>
									<th>Waist</th>
									<th>Hips</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>XS</td>
									<td>2</td>
									<td>32</td>
									<td>24 - 25</td>
									<td>33 - 34</td>
								</tr>
								<tr>
									<td>S</td>
									<td>4</td>
									<td>34 - 35</td>
									<td>26 - 27</td>
									<td>35 - 26</td>
								</tr>
								<tr>
									<td>M</td>
									<td>6</td>
									<td>36 - 37</td>
									<td>28 - 29</td>
									<td>38 - 40</td>
								</tr>
								<tr>
									<td>L</td>
									<td>8</td>
									<td>38 - 29</td>
									<td>30 - 31</td>
									<td>42 - 44</td>
								</tr>
								<tr>
									<td>XL</td>
									<td>10</td>
									<td>40 - 41</td>
									<td>32 - 33</td>
									<td>45 - 47</td>
								</tr>
								<tr>
									<td>XXL</td>
									<td>12</td>
									<td>42 - 43</td>
									<td>34 - 35</td>
									<td>48 - 50</td>
								</tr>
							</tbody>
						</table>
					</div>

				</div>

				<!-- Body -->
				<div class="modal-body">

					<!-- Header -->
					<div class="d-flex mb-7">

						<!-- Heading -->
						<h5 class="mb-0">Shoes</h5>

						<!-- Inputs -->
						<div class="ms-auto">

							<!-- IN -->
							<input type="radio" class="btn-check" name="modalSizeChartUnitTwo" id="inTwo" checked>
							<label class="btn btn-xxs btn-circle btn-outline-dark fs-xxxs rounded-0" for="inTwo">IN</label>

							<!-- CM -->
							<input type="radio" class="btn-check" name="modalSizeChartUnitTwo" id="cmTwo">
							<label class="btn btn-xxs btn-circle btn-outline-dark fs-xxxs rounded-0" for="cmTwo">CM</label>

						</div>

					</div>

					<!-- Tables -->
					<div class="row">
						<div class="col-12 col-lg-6">

							<!-- Table -->
							<div class="table-responsive">
								<table class="table table-bordered table-sm table-hover mb-lg-0">
									<thead>
										<tr>
											<th>Size</th>
											<th>US</th>
											<th>Foot Length</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>36</td>
											<td>5</td>
											<td>22.8</td>
										</tr>
										<tr>
											<td>26.5</td>
											<td>5.5</td>
											<td>23.1</td>
										</tr>
										<tr>
											<td>37</td>
											<td>6</td>
											<td>23.5</td>
										</tr>
										<tr>
											<td>37.5</td>
											<td>6.</td>
											<td>23.5</td>
										</tr>
										<tr>
											<td>38</td>
											<td>7</td>
											<td>24.1</td>
										</tr>
										<tr>
											<td>38.5</td>
											<td>7.5</td>
											<td>24.5</td>
										</tr>
									</tbody>
								</table>
							</div>

						</div>
						<div class="col-12 col-lg-6">

							<!-- Table -->
							<div class="table-responsive">
								<table class="table table-bordered table-sm table-hover mb-0">
									<thead>
										<tr>
											<th>Size</th>
											<th>US</th>
											<th>Foot Length</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>36</td>
											<td>5</td>
											<td>22.8</td>
										</tr>
										<tr>
											<td>39</td>
											<td>8</td>
											<td>24.1</td>
										</tr>
										<tr>
											<td>40</td>
											<td>9</td>
											<td>25.4</td>
										</tr>
										<tr>
											<td>40.5</td>
											<td>9.5</td>
											<td>25.7</td>
										</tr>
										<tr>
											<td>41</td>
											<td>10</td>
											<td>26.0</td>
										</tr>
									</tbody>
								</table>
							</div>

						</div>
					</div>

				</div>

			</div>

		</div>
	</div>

	<!-- Wait List -->
	<div class="modal fade" id="modalWaitList" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">

				<!-- Close -->
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
					<i class="fe fe-x" aria-hidden="true"></i>
				</button>

				<!-- Header-->
				<div class="modal-header lh-fixed fs-lg">
					<strong class="mx-auto">Wait List</strong>
				</div>

				<!-- Body -->
				<div class="modal-body">
					<div class="row mb-6">
						<div class="col-12 col-md-3">

							<!-- Image -->
							<a href="./product.html">
								<img class="img-fluid mb-7 mb-md-0" src="/olympic/dist/assets/img/products/product-6.jpg" alt="...">
							</a>

						</div>
						<div class="col-12 col-md-9">

							<!-- Label -->
							<p>
								<a class="fw-bold text-body" href="./product.html">Cotton floral print Dress</a>
							</p>

							<!-- Radio -->
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeOne" value="6" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeOne">3XS</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeTwo" value="6.5" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeTwo">2XS</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeThree" value="7" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeThree">XS</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeFour" value="7.5" data-toggle="form-caption" data-target="#modalWaitListSizeCaption" checked>
								<label class="form-check-label" for="modalWaitListSizeFour">S</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeFive" value="8" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeFive">M</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeSix" value="8.5" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeSix">LG</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeSeven" value="9" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeSeven">XL</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeEight" value="9.5" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeEight">2XL</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeNine" value="10" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeNine">3XL</label>
							</div>
							<div class="form-check form-check-inline form-check-size mb-2">
								<input type="radio" class="form-check-input" name="modalWaitListSize" id="modalWaitListSizeTen" value="10.5" data-toggle="form-caption" data-target="#modalWaitListSizeCaption">
								<label class="form-check-label" for="modalWaitListSizeTen">4XL</label>
							</div>

						</div>

					</div>
					<div class="row">
						<div class="col-12">

							<!-- Text -->
							<p class="fs-sm text-center text-gray-500">Justo ut diam erat hendrerit morbi porttitor, per eu curabitur diam sociis.</p>

						</div>
					</div>
					<div class="row gx-5 mb-2">
						<div class="col-12 col-md-6">

							<!-- Form group -->
							<div class="form-group">
								<label class="visually-hidden" for="listName">Your Name</label>
								<input class="form-control" id="listName" type="text" placeholder="Your Name *" required>
							</div>

						</div>
						<div class="col-12 col-md-6">

							<!-- Form group -->
							<div class="form-group">
								<label class="visually-hidden" for="listEmail">Your Name</label>
								<input class="form-control" id="listEmail" type="email" placeholder="Your Email *" required>
							</div>

						</div>
					</div>
					<div class="row">
						<div class="col-12 text-center">

							<!-- Button -->
							<button class="btn btn-dark" type="submit">Subscribe</button>

						</div>
					</div>
				</div>

			</div>

		</div>
	</div>


	<!-- PRODUCT -->
	<section>
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="row">
						<div class="col-12 col-md-6">

							<!-- Card -->
							<div class="card">
								<img src="${game.sport.title_image}" />
							</div>
						</div>
						<div class="col-12 col-md-6 ps-lg-10">

							<!-- Header -->
							<div class="row mb-1">
								<div class="col">

									<!-- Preheading -->
									<a class="text-muted" href="shop.html">Sneakers</a>

								</div>
								<div class="col-auto">

									<!-- Rating -->
									<div class="rating fs-xs text-dark" data-value="4">
										<div class="rating-item">
											<i class="fas fa-star"></i>
										</div>
										<div class="rating-item">
											<i class="fas fa-star"></i>
										</div>
										<div class="rating-item">
											<i class="fas fa-star"></i>
										</div>
										<div class="rating-item">
											<i class="fas fa-star"></i>
										</div>
										<div class="rating-item">
											<i class="fas fa-star"></i>
										</div>
									</div>

									<a class="fs-sm text-reset ms-2" href="#reviews"> Reviews (6) </a>

								</div>
							</div>

							<!-- Heading -->
							<h3 class="mb-2">Leather Sneakers</h3>

							<!-- Price -->
							<div class="mb-7">
								<span class="fs-lg fw-bold text-gray-350 text-decoration-line-through">$115.00</span>
								<span class="ms-1 fs-5 fw-bolder text-primary">$85.00</span>
								<span class="fs-sm ms-1">(In Stock)</span>
							</div>

							<!-- Form -->
							<form>
								<div class="form-group">

									<!-- Label -->
									<p class="mb-5">
										Color: <strong id="colorCaption">White</strong>
									</p>

									<!-- Radio -->
									<div class="mb-8 ms-n1">
										<div class="form-check form-check-inline form-check-img">
											<input type="radio" class="form-check-input" id="imgRadioOne" name="imgRadio" data-toggle="form-caption" data-target="#colorCaption" value="White" style="background-image: url(assets/img/products/product-7.jpg);" checked>
										</div>
										<div class="form-check form-check-inline form-check-img">
											<input type="radio" class="form-check-input" id="imgRadioTwo" name="imgRadio" data-toggle="form-caption" data-target="#colorCaption" value="Black" style="background-image: url(assets/img/products/product-49.jpg);">
										</div>
									</div>

								</div>
								<div class="form-group">

									<!-- Label -->
									<p class="mb-5">
										Size: <strong><span id="sizeCaption">7.5</span> US</strong>
									</p>

									<!-- Radio -->
									<div class="mb-2">
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioOne" value="6" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioOne">6</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioTwo" value="6.5" data-toggle="form-caption" data-target="#sizeCaption" disabled>
											<label class="form-check-label" for="sizeRadioTwo">6.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioThree" value="7" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioThree">7</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioFour" value="7.5" data-toggle="form-caption" data-target="#sizeCaption" checked>
											<label class="form-check-label" for="sizeRadioFour">7.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioFive" value="8" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioFive">8</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioSix" value="8.5" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioSix">8.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioSeven" value="9" data-toggle="form-caption" data-target="#sizeCaption" disabled>
											<label class="form-check-label" for="sizeRadioSeven">9</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioEight" value="9.5" data-toggle="form-caption" data-target="#sizeCaption" disabled>
											<label class="form-check-label" for="sizeRadioEight">9.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioNine" value="10" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioNine">10</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioTen" value="10.5" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioTen">10.5</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioEleven" value="11" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioEleven">11</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioTwelve" value="12" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioTwelve">12</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioThirteen" value="13" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioThirteen">13</label>
										</div>
										<div class="form-check form-check-inline form-check-size mb-2">
											<input type="radio" class="form-check-input" name="sizeRadio" id="sizeRadioFourteen" value="14" data-toggle="form-caption" data-target="#sizeCaption">
											<label class="form-check-label" for="sizeRadioFourteen">14</label>
										</div>
									</div>

									<!-- Size chart -->
									<p class="mb-8">
										<img src="/olympic/dist/assets/img/icons/icon-ruler.svg" alt="..." class="img-fluid">
										<a class="text-reset text-decoration-underline ms-3" data-bs-toggle="modal" href="#modalSizeChart">Size chart</a>
									</p>

									<div class="row gx-5 mb-7">
										<div class="col-12 col-lg-auto">

											<!-- Quantity -->
											<select class="form-select mb-2">
												<option value="1" selected>1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
											</select>

										</div>
										<div class="col-12 col-lg">

											<!-- Submit -->
											<button type="submit" class="btn w-100 btn-dark mb-2">
												Add to Cart <i class="fe fe-shopping-cart ms-2"></i>
											</button>

										</div>
										<div class="col-12 col-lg-auto">

											<!-- Wishlist -->
											<button class="btn btn-outline-dark w-100 mb-2" data-toggle="button">
												Wishlist <i class="fe fe-heart ms-2"></i>
											</button>

										</div>
									</div>

									<!-- Text -->
									<p>
										<span class="text-gray-500">Is your size/color sold out?</span>
										<a class="text-reset text-decoration-underline" data-bs-toggle="modal" href="#modalWaitList">Join the Wait List!</a>
									</p>

									<!-- Share -->
									<p class="mb-0">
										<span class="me-4">Share:</span>
										<a class="btn btn-xxs btn-circle btn-light fs-xxxs text-gray-350" href="#!">
											<i class="fab fa-twitter"></i>
										</a>
										<a class="btn btn-xxs btn-circle btn-light fs-xxxs text-gray-350" href="#!">
											<i class="fab fa-facebook-f"></i>
										</a>
										<a class="btn btn-xxs btn-circle btn-light fs-xxxs text-gray-350" href="#!">
											<i class="fab fa-pinterest-p"></i>
										</a>
									</p>

								</div>
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- DESCRIPTION -->
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
										<div class="col-12">

											<!-- Text -->
											<p class="text-gray-500">Won't herb first male seas, beast. Let upon, female upon third fifth every. Man subdue rule after years herb after form. And image may, morning. Behold in tree day sea that together cattle whose. Fifth gathering brought bearing. Abundantly creeping whose. Beginning form have void two. A whose.</p>

										</div>
										<div class="col-12 col-md-6">

											<!-- List -->
											<ul class="list list-unstyled mb-md-0 text-gray-500">
												<li>
													<strong class="text-body">SKU</strong>: #61590437
												</li>
												<li>
													<strong class="text-body">Occasion</strong>: Lifestyle, Sport
												</li>
												<li>
													<strong class="text-body">Country</strong>: Italy
												</li>
											</ul>

										</div>
										<div class="col-12 col-md-6">

											<!-- List -->
											<ul class="list list-unstyled mb-0">
												<li>
													<strong>Outer</strong>: Leather 100%, Polyamide 100%
												</li>
												<li>
													<strong>Lining</strong>: Polyester 100%
												</li>
												<li>
													<strong>CounSoletry</strong>: Rubber 100%
												</li>
											</ul>

										</div>
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
												<img src="/olympic/dist/assets/img/icons/icon-ruler.svg" alt="..." class="img-fluid">
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

	<!-- PRODUCTS -->
	<section class="pt-11">
		<div class="container">
			<div class="row">
				<div class="col-12">

					<!-- Heading -->
					<h4 class="mb-10 text-center">You might also like</h4>

					<!-- Items -->
					<div class="row">
						<div class="col-6 col-sm-6 col-md-4 col-lg-3">

							<!-- Card -->
							<div class="card mb-7">

								<!-- Badge -->
								<div class="badge bg-white text-body card-badge card-badge-start text-uppercase">New</div>

								<!-- Image -->
								<div class="card-img">

									<!-- Image -->
									<a class="card-img-hover" href="product.html">
										<img class="card-img-top card-img-back" src="/olympic/dist/assets/img/products/product-120.jpg" alt="...">
										<img class="card-img-top card-img-front" src="/olympic/dist/assets/img/products/product-5.jpg" alt="...">
									</a>

									<!-- Actions -->
									<div class="card-actions">
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-bs-toggle="modal" data-bs-target="#modalProduct">
												<i class="fe fe-eye"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-shopping-cart"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-heart"></i>
											</button>
										</span>
									</div>

								</div>

								<!-- Body -->
								<div class="card-body px-0">

									<!-- Category -->
									<div class="fs-xs">
										<a class="text-muted" href="shop.html">Shoes</a>
									</div>

									<!-- Title -->
									<div class="fw-bold">
										<a class="text-body" href="product.html"> Leather mid-heel Sandals </a>
									</div>

									<!-- Price -->
									<div class="fw-bold text-muted">$129.00</div>

								</div>

							</div>

						</div>
						<div class="col-6 col-sm-6 col-md-4 col-lg-3">

							<!-- Card -->
							<div class="card mb-7">

								<!-- Image -->
								<div class="card-img">

									<!-- Image -->
									<a class="card-img-hover" href="product.html">
										<img class="card-img-top card-img-back" src="/olympic/dist/assets/img/products/product-121.jpg" alt="...">
										<img class="card-img-top card-img-front" src="/olympic/dist/assets/img/products/product-6.jpg" alt="...">
									</a>

									<!-- Actions -->
									<div class="card-actions">
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-bs-toggle="modal" data-bs-target="#modalProduct">
												<i class="fe fe-eye"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-shopping-cart"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-heart"></i>
											</button>
										</span>
									</div>

								</div>

								<!-- Body -->
								<div class="card-body px-0">

									<!-- Category -->
									<div class="fs-xs">
										<a class="text-muted" href="shop.html">Dresses</a>
									</div>

									<!-- Title -->
									<div class="fw-bold">
										<a class="text-body" href="product.html"> Cotton floral print Dress </a>
									</div>

									<!-- Price -->
									<div class="fw-bold text-muted">$40.00</div>

								</div>

							</div>

						</div>
						<div class="col-6 col-sm-6 col-md-4 col-lg-3">

							<!-- Card -->
							<div class="card mb-7">

								<!-- Badge -->
								<div class="badge bg-dark card-badge card-badge-start text-uppercase">Sale</div>

								<!-- Image -->
								<div class="card-img">

									<!-- Image -->
									<a class="card-img-hover" href="product.html">
										<img class="card-img-top card-img-back" src="/olympic/dist/assets/img/products/product-122.jpg" alt="...">
										<img class="card-img-top card-img-front" src="/olympic/dist/assets/img/products/product-7.jpg" alt="...">
									</a>

									<!-- Actions -->
									<div class="card-actions">
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-bs-toggle="modal" data-bs-target="#modalProduct">
												<i class="fe fe-eye"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-shopping-cart"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-heart"></i>
											</button>
										</span>
									</div>

								</div>

								<!-- Body -->
								<div class="card-body px-0">

									<!-- Category -->
									<div class="fs-xs">
										<a class="text-muted" href="shop.html">Shoes</a>
									</div>

									<!-- Title -->
									<div class="fw-bold">
										<a class="text-body" href="product.html"> Leather Sneakers </a>
									</div>

									<!-- Price -->
									<div class="fw-bold">
										<span class="fs-xs text-gray-350 text-decoration-line-through">$85.00</span>
										<span class="text-primary">$85.00</span>
									</div>

								</div>

							</div>

						</div>
						<div class="col-6 col-sm-6 col-md-4 col-lg-3 d-md-none d-lg-block">

							<!-- Card -->
							<div class="card mb-7">

								<!-- Image -->
								<div class="card-img">

									<!-- Image -->
									<a href="#!">
										<img class="card-img-top card-img-front" src="/olympic/dist/assets/img/products/product-8.jpg" alt="...">
									</a>

									<!-- Actions -->
									<div class="card-actions">
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-bs-toggle="modal" data-bs-target="#modalProduct">
												<i class="fe fe-eye"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-shopping-cart"></i>
											</button>
										</span>
										<span class="card-action">
											<button class="btn btn-xs btn-circle btn-white-primary" data-toggle="button">
												<i class="fe fe-heart"></i>
											</button>
										</span>
									</div>

								</div>

								<!-- Body -->
								<div class="card-body px-0">

									<!-- Category -->
									<div class="fs-xs">
										<a class="text-muted" href="shop.html">Tops</a>
									</div>

									<!-- Title -->
									<div class="fw-bold">
										<a class="text-body" href="product.html"> Cropped cotton Top </a>
									</div>

									<!-- Price -->
									<div class="fw-bold text-muted">$29.00</div>

								</div>

							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</section>

	<!-- REVIEWS -->
	<section class="pt-9 pb-11" id="reviews">
		<div class="container">
			<div class="row">
				<div class="col-12">

					<!-- Heading -->
					<h4 class="mb-10 text-center">Customer Reviews</h4>

					<!-- Header -->
					<div class="row align-items-center">
						<div class="col-12 col-md-auto">

							<!-- Dropdown -->
							<div class="dropdown mb-4 mb-md-0">

								<!-- Toggle -->
								<a class="dropdown-toggle text-reset" data-bs-toggle="dropdown" href="#">
									<strong>Sort by: Newest</strong>
								</a>

								<!-- Menu -->
								<div class="dropdown-menu mt-3">
									<a class="dropdown-item" href="#!">Newest</a>
									<a class="dropdown-item" href="#!">Oldest</a>
								</div>

							</div>

						</div>
						<div class="col-12 col-md text-md-center">

							<!-- Rating -->
							<div class="rating text-dark h6 mb-4 mb-md-0" data-value="4">
								<div class="rating-item">
									<i class="fas fa-star"></i>
								</div>
								<div class="rating-item">
									<i class="fas fa-star"></i>
								</div>
								<div class="rating-item">
									<i class="fas fa-star"></i>
								</div>
								<div class="rating-item">
									<i class="fas fa-star"></i>
								</div>
								<div class="rating-item">
									<i class="fas fa-star"></i>
								</div>
							</div>

							<!-- Count -->
							<strong class="fs-sm ms-2">Reviews (3)</strong>

						</div>
						<div class="col-12 col-md-auto">

							<!-- Button -->
							<a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm"> Write Review </a>

						</div>
					</div>

					<!-- New Review -->
					<div class="collapse" id="reviewForm">

						<!-- Divider -->
						<hr class="my-8">

						<!-- Form -->
						<form>
							<div class="row">
								<div class="col-12 mb-6 text-center">

									<!-- Text -->
									<p class="mb-1 fs-xs">Score:</p>

									<!-- Rating form -->
									<div class="rating-form">

										<!-- Input -->
										<input class="rating-input" type="range" min="1" max="5" value="5">

										<!-- Rating -->
										<div class="rating h5 text-dark" data-value="5">
											<div class="rating-item">
												<i class="fas fa-star"></i>
											</div>
											<div class="rating-item">
												<i class="fas fa-star"></i>
											</div>
											<div class="rating-item">
												<i class="fas fa-star"></i>
											</div>
											<div class="rating-item">
												<i class="fas fa-star"></i>
											</div>
											<div class="rating-item">
												<i class="fas fa-star"></i>
											</div>
										</div>

									</div>

								</div>
								<div class="col-12 col-md-6">

									<!-- Name -->
									<div class="form-group">
										<label class="visually-hidden" for="reviewName">Your Name:</label>
										<input class="form-control form-control-sm" id="reviewName" type="text" placeholder="Your Name *" required>
									</div>

								</div>
								<div class="col-12 col-md-6">

									<!-- Email -->
									<div class="form-group">
										<label class="visually-hidden" for="reviewEmail">Your Email:</label>
										<input class="form-control form-control-sm" id="reviewEmail" type="email" placeholder="Your Email *" required>
									</div>

								</div>
								<div class="col-12">

									<!-- Name -->
									<div class="form-group">
										<label class="visually-hidden" for="reviewTitle">Review Title:</label>
										<input class="form-control form-control-sm" id="reviewTitle" type="text" placeholder="Review Title *" required>
									</div>

								</div>
								<div class="col-12">

									<!-- Name -->
									<div class="form-group">
										<label class="visually-hidden" for="reviewText">Review:</label>
										<textarea class="form-control form-control-sm" id="reviewText" rows="5" placeholder="Review *" required></textarea>
									</div>

								</div>
								<div class="col-12 text-center">

									<!-- Button -->
									<button class="btn btn-outline-dark" type="submit">Post Review</button>

								</div>
							</div>
						</form>

					</div>

					<!-- Reviews -->
					<div class="mt-8">

						<!-- Review -->
						<div class="review">
							<div class="review-body">
								<div class="row">
									<div class="col-12 col-md-auto">

										<!-- Avatar -->
										<div class="avatar avatar-xxl mb-6 mb-md-0">
											<span class="avatar-title rounded-circle">
												<i class="fa fa-user"></i>
											</span>
										</div>

									</div>
									<div class="col-12 col-md">

										<!-- Header -->
										<div class="row mb-6">
											<div class="col-12">

												<!-- Rating -->
												<div class="rating fs-sm text-dark" data-value="5">
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
												</div>

											</div>
											<div class="col-12">

												<!-- Time -->
												<span class="fs-xs text-muted">
													Logan Edwards,
													<time datetime="2019-07-25">25 Jul 2019</time>
												</span>

											</div>
										</div>

										<!-- Title -->
										<p class="mb-2 fs-lg fw-bold">So cute!</p>

										<!-- Text -->
										<p class="text-gray-500">Justo ut diam erat hendrerit. Morbi porttitor, per eu. Sodales curabitur diam sociis. Taciti lobortis nascetur. Ante laoreet odio hendrerit. Dictumst curabitur nascetur lectus potenti dis sollicitudin habitant quis vestibulum.</p>

										<!-- Footer -->
										<div class="row align-items-center">
											<div class="col-auto d-none d-lg-block">

												<!-- Text -->
												<p class="mb-0 fs-sm">Was this review helpful?</p>

											</div>
											<div class="col-auto me-auto">

												<!-- Rate -->
												<div class="rate">
													<a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
														<i class="fe fe-thumbs-up"></i>
													</a>
													<a class="rate-item" data-toggle="vote" data-count="0" href="#" role="button">
														<i class="fe fe-thumbs-down"></i>
													</a>
												</div>

											</div>
											<div class="col-auto d-none d-lg-block">

												<!-- Text -->
												<p class="mb-0 fs-sm">Comments (0)</p>

											</div>
											<div class="col-auto">

												<!-- Button -->
												<a class="btn btn-xs btn-outline-border" href="#!"> Comment </a>

											</div>
										</div>

									</div>
								</div>
							</div>
						</div>

						<!-- Review -->
						<div class="review">

							<!-- Body -->
							<div class="review-body">
								<div class="row">
									<div class="col-12 col-md-auto">

										<!-- Avatar -->
										<div class="avatar avatar-xxl mb-6 mb-md-0">
											<span class="avatar-title rounded-circle">
												<i class="fa fa-user"></i>
											</span>
										</div>

									</div>
									<div class="col-12 col-md">

										<!-- Header -->
										<div class="row mb-6">
											<div class="col-12">

												<!-- Rating -->
												<div class="rating fs-sm text-dark" data-value="3">
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
													<div class="rating-item">
														<i class="fas fa-star"></i>
													</div>
												</div>

											</div>
											<div class="col-12">

												<!-- Time -->
												<span class="fs-xs text-muted">
													Sophie Casey,
													<time datetime="2019-07-07">07 Jul 2019</time>
												</span>

											</div>
										</div>

										<!-- Title -->
										<p class="mb-2 fs-lg fw-bold">Cute, but too small</p>

										<!-- Text -->
										<p class="text-gray-500">Shall good midst can't. Have fill own his multiply the divided. Thing great. Of heaven whose signs.</p>

										<!-- Footer -->
										<div class="row align-items-center">
											<div class="col-auto d-none d-lg-block">

												<!-- Text -->
												<p class="mb-0 fs-sm">Was this review helpful?</p>

											</div>
											<div class="col-auto me-auto">

												<!-- Rate -->
												<div class="rate">
													<a class="rate-item" data-toggle="vote" data-count="2" href="#" role="button">
														<i class="fe fe-thumbs-up"></i>
													</a>
													<a class="rate-item" data-toggle="vote" data-count="1" href="#" role="button">
														<i class="fe fe-thumbs-down"></i>
													</a>
												</div>

											</div>
											<div class="col-auto d-none d-lg-block">

												<!-- Text -->
												<p class="mb-0 fs-sm">Comments (1)</p>

											</div>
											<div class="col-auto">

												<!-- Button -->
												<a class="btn btn-xs btn-outline-border" href="#!"> Comment </a>

											</div>
										</div>

									</div>
								</div>
							</div>

							<!-- Child review -->
							<div class="review review-child">
								<div class="review-body">

									<!-- Content -->
									<div class="row">
										<div class="col-12 col-md-auto">

											<!-- Avatar -->
											<div class="avatar avatar-xxl mb-6 mb-md-0">
												<span class="avatar-title rounded-circle">
													<i class="fa fa-user"></i>
												</span>
											</div>

										</div>
										<div class="col-12 col-md">

											<!-- Header -->
											<div class="row mb-6">
												<div class="col-12">

													<!-- Rating -->
													<div class="rating fs-sm text-dark" data-value="4">
														<div class="rating-item">
															<i class="fas fa-star"></i>
														</div>
														<div class="rating-item">
															<i class="fas fa-star"></i>
														</div>
														<div class="rating-item">
															<i class="fas fa-star"></i>
														</div>
														<div class="rating-item">
															<i class="fas fa-star"></i>
														</div>
														<div class="rating-item">
															<i class="fas fa-star"></i>
														</div>
													</div>

												</div>
												<div class="col-12">

													<!-- Time -->
													<span class="fs-xs text-muted">
														William Stokes,
														<time datetime="2019-07-14">14 Jul 2019</time>
													</span>

												</div>
											</div>

											<!-- Title -->
											<p class="mb-2 fs-lg fw-bold">Very good</p>

											<!-- Text -->
											<p class="text-gray-500">Made face lights yielding forth created for image behold blessed seas.</p>

											<!-- Footer -->
											<div class="row align-items-center">
												<div class="col-auto d-none d-lg-block">

													<!-- Text -->
													<p class="mb-0 fs-sm">Was this review helpful?</p>

												</div>
												<div class="col-auto me-auto">

													<!-- Rate -->
													<div class="rate">
														<a class="rate-item" data-toggle="vote" data-count="7" href="#" role="button">
															<i class="fe fe-thumbs-up"></i>
														</a>
														<a class="rate-item" data-toggle="vote" data-count="0" href="#" role="button">
															<i class="fe fe-thumbs-down"></i>
														</a>
													</div>

												</div>
												<div class="col-auto d-none d-lg-block">

													<!-- Text -->
													<p class="mb-0 fs-sm">Comments (0)</p>

												</div>
												<div class="col-auto">

													<!-- Button -->
													<a class="btn btn-xs btn-outline-border" href="#!"> Comment </a>

												</div>
											</div>

										</div>
									</div>

								</div>
							</div>

						</div>

					</div>

					<!-- Pagination -->
					<nav class="d-flex justify-content-center mt-9">
						<ul class="pagination pagination-sm text-gray-400">
							<li class="page-item">
								<a class="page-link page-link-arrow" href="#">
									<i class="fa fa-caret-left"></i>
								</a>
							</li>
							<li class="page-item active">
								<a class="page-link" href="#">1</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">2</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">3</a>
							</li>
							<li class="page-item">
								<a class="page-link page-link-arrow" href="#">
									<i class="fa fa-caret-right"></i>
								</a>
							</li>
						</ul>
					</nav>

				</div>
			</div>
		</div>
	</section>

	<!-- FEATURES -->
	<section class="bg-light py-9">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 col-lg-3">

					<!-- Item -->
					<div class="d-flex mb-6 mb-lg-0">

						<!-- Icon -->
						<i class="fe fe-truck fs-lg text-primary"></i>

						<!-- Body -->
						<div class="ms-6">

							<!-- Heading -->
							<h6 class="heading-xxs mb-1">Free shipping</h6>

							<!-- Text -->
							<p class="mb-0 fs-sm text-muted">From all orders over $100</p>

						</div>

					</div>

				</div>
				<div class="col-12 col-md-6 col-lg-3">

					<!-- Item -->
					<div class="d-flex mb-6 mb-lg-0">

						<!-- Icon -->
						<i class="fe fe-repeat fs-lg text-primary"></i>

						<!-- Body -->
						<div class="ms-6">

							<!-- Heading -->
							<h6 class="mb-1 heading-xxs">Free returns</h6>

							<!-- Text -->
							<p class="mb-0 fs-sm text-muted">Return money within 30 days</p>

						</div>

					</div>

				</div>
				<div class="col-12 col-md-6 col-lg-3">

					<!-- Item -->
					<div class="d-flex mb-6 mb-md-0">

						<!-- Icon -->
						<i class="fe fe-lock fs-lg text-primary"></i>

						<!-- Body -->
						<div class="ms-6">

							<!-- Heading -->
							<h6 class="mb-1 heading-xxs">Secure shopping</h6>

							<!-- Text -->
							<p class="mb-0 fs-sm text-muted">You're in safe hands</p>

						</div>

					</div>

				</div>
				<div class="col-12 col-md-6 col-lg-3">

					<!-- Item -->
					<div class="d-flex">

						<!-- Icon -->
						<i class="fe fe-tag fs-lg text-primary"></i>

						<!-- Body -->
						<div class="ms-6">

							<!-- Heading -->
							<h6 class="mb-1 heading-xxs">Over 10,000 Styles</h6>

							<!-- Text -->
							<p class="mb-0 fs-sm text-muted">We have everything you need</p>

						</div>

					</div>

				</div>
			</div>
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>