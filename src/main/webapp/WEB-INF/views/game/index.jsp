<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>올림픽 경기</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.list-group {
	list-style: none;
	padding: 0;
	margin: 0;
}

.list-group-item {
	border: 1px solid #ddd;
	margin-bottom: 6px;
	padding: 12px;
	display: flex;
	flex-direction: row;
}

.inline-container {
	display: flex;
	align-items: center;
}

.inline-container>div, .inline-container>img {
	margin-right: 10px;
}

.flag, #unknown_flag {
	width: 50px;
	height: 30px;
	object-fit: cover;
	border: 1px solid #000; /* 테두리 추가 */
	display: flex;
	align-items: center;
	justify-content: center;
}

.fw-bold {
	font-weight: bold;
}

.fs-sm {
	font-size: 0.875rem;
}

.mb-4 {
	margin-bottom: 1.5rem;
}

.mb-6 {
	margin-bottom: 3rem;
}

.ms-auto {
	margin-left: auto;
}

.text-muted {
	color: #6c757d;
}

.btn-link {
	border: none;
	background: none;
	padding: 0;
}

#grid-container {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	grid-template-rows: repeat(5, 1fr);
	gap: 5px; /* 각 셀 사이의 간격을 지정합니다 */
	width: 25em;
}

.grid-item {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50px; /* 각 셀의 높이를 지정합니다 */
}

.sdate {
	background-color: white;
	border: 1px solid #000;
	cursor: pointer;
}

.hidden {
	display: none; /* 내용을 숨깁니다 */
}

#calendar {
	border: 1px solid #000;
	padding: 10px;
}

#calendar, #search_sport, .total-date {
	cursor: pointer;
}
</style>
<script>
	function listGame() {
		var search_date = $('#search_date > #calendar').text();
		var search_sport = $('#search_sport').val();
		console.log(search_date, search_sport);
		if (search_date == '모든 날짜') {
			search_date = "all";
		}
		$
				.ajax({
					url : "/olympic/game/search.do",
					type : "GET",
					data : {
						search_date : search_date,
						search_sport : search_sport
					},
					success : function(data) {
						var content = '';
						if (data.game.length === 0) {
							content += '<div><p>등록된 경기 일정이 없습니다.</p></div>';
						} else {
							content += '<ul class="ps-0" style="list-style-type: none;">';
							$
									.each(
											data.game,
											function(idx, vo) {
												content += '<li class="list-group-item shadow-lg p-4 mb-5 rounded-4" style="border-left: 3px solid black;">';
												content += '<div class="row align-items-center" id="game-item-' + vo.game_id + '">';
												content += '<div class="col-2 d-flex justify-content-center align-items-center overflow-hidden">';
												content += '<a href="#;" onclick="redirectToDetail('
														+ vo.game_id + ')">';
												content += '<img src="' + vo.sport_pictogram + '" alt="스포츠 아이콘" class="sport_pictogram" style="width: 160px; object-fit: fill;">';
												content += '</a></div>';

												content += '<div class="col my-1">';
												content += '<div class="d-flex mb-4">';
												content += '<a class="text-body fs-5 fw-bolder" href="#;" onclick="redirectToDetail('
														+ vo.game_id
														+ ')">'
														+ vo.sport_name
														+ '&nbsp;-&nbsp;'
														+ vo.tournament
														+ '</a>';
												content += '<span class="ms-auto"><i class="fa-solid fa-map-pin"></i> '
														+ vo.stadium_name
														+ '</span>';
												content += '</div>';

												content += '<div class="row">';
												content += '<div class="col-9 fs-sm text-muted m-0 fw-bolder">';
												content += '<i class="fa-regular fa-calendar"></i> 경기 일자: '
														+ vo.korea_date
														+ '&ensp; | &ensp; 시간: '
														+ vo.korea_time
														+ '<br>';
												content += '<i class="fa-regular fa-flag"></i> 출전 나라: ';
												content += vo.country1_name ? vo.country1_name
														: '미정';
												content += ' vs ';
												content += vo.country2_name ? vo.country2_name
														: '미정';
												content += '</div>';

												content += '<div class="col-3 d-flex justify-content-end">';
												if (data.member
														&& data.member.member_no) {
													if (vo.favorite === 0) {
														content += '<img src="/olympic/img/fake_love.png" id="favorite_'
																+ vo.game_id
																+ '" onclick="toggle_favorite('
																+ vo.game_id
																+ ', 0)" style="cursor: pointer; width: 50px; height: 50px;">';
													} else if (vo.favorite === 1) {
														content += '<img src="/olympic/img/true_love.png" id="favorite_'
																+ vo.game_id
																+ '" onclick="toggle_favorite('
																+ vo.game_id
																+ ', 1)" style="cursor: pointer; width: 50px; height: 50px;">';
													}
												} else {
													content += '<a id="loginLink" onclick="loginLink()">';
													content += '<img src="/olympic/img/fake_love.png" style="cursor: pointer; width: 50px; height: 50px;">';
													content += '</a>';
												}
												content += '</div>'; // col-3
												content += '</div>'; // row
												content += '<div class="row">';
												content += '<div class="inline-container col-9">';
												content += vo.country1_flag ? '<img src="' + vo.country1_flag + '" alt="" class="flag">'
														: '<div id="unknown_flag" class="flag">?</div>';
												content += '<div id=""> vs </div>';
												content += vo.country2_flag ? '<img src="' + vo.country2_flag + '" alt="" class="flag">'
														: '<div id="unknown_flag" class="flag">?</div>';
												content += '</div>'; // inline-container
												content += '<div class="col-3 d-flex justify-content-end mt-2"><button type="button" class="text-decoration-underline p-0 m-0 btn btn-link" onclick="redirectToDetail('
														+ vo.game_id
														+ ')">경기 상세 보기</button></div>';
												content += '</div>'; // row
												content += '</div>'; // col my-1
												content += '</div>'; // row align-items-center
												content += '</li>';
											});
							content += '</ul>';
						}

						$('#listGame').html(content); // AJAX로 받은 데이터 추가
					}
				});
	}

	function loginLink() {
		var userConfirmed = confirm("로그인 페이지로 이동하시겠습니까?");
		if (userConfirmed) {
			window.location.href = '/olympic/member/login.do';
		}
	}

	function toggle_favorite(game_id, favorite_status) {
		if (favorite_status === 0) {
			// 추가
			$.ajax({
				url : "/olympic/game/createFavorite.do",
				type : "POST",
				data : {
					game_id : game_id
				},
				success : function(res) {
					if (res == 1) {
						$('#favorite_' + game_id).attr('onclick',
								'toggle_favorite(' + game_id + ', 1)').attr(
								'src', '/olympic/img/true_love.png');
					}
				},
				error : function() {
					alert('오류가 발생했습니다.');
				}
			});
		} else {
			// 삭제
			$.ajax({
				url : "/olympic/game/deleteFavorite.do",
				type : "POST",
				data : {
					game_id : game_id
				},
				success : function(res) {
					if (res == 1) {
						$('#favorite_' + game_id).attr('onclick',
								'toggle_favorite(' + game_id + ', 0)').attr(
								'src', '/olympic/img/fake_love.png');
					}
				},
				error : function() {
					alert('오류가 발생했습니다.');
				}
			});
		}
	}

	function redirectToDetail(gameId) {
		window.location.href = '/olympic/game/detail.do?game_id=' + gameId;
	};
	$(document).ready(function() {

		$("#toggle-date").hide();
		$("#calendar").click(function() {
			$("#toggle-date").toggle();
		});

		$("#search_sport").change(function() {
			search_sport = $("#search_sport").val();
			listGame();
		})

		$('.grid-item').on('click', function() {
			var hiddenValue = $(this).data("sdate");
			if (hiddenValue) {
				$('#calendar').text(hiddenValue);
				listGame();
			}
		});

		// 페이지 로드 시 초기 데이터 로드
		listGame();

		$('.total-date').on('click', function() {
			$('#calendar').text("모든 날짜");
			listGame();
		});

	});
</script>

</head>
<body>
	<!-- 공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="/WEB-INF/views/common/modals.jsp"%>
	<!--  타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<!--  헤더 하단 현재 경로 노출 -->
	<%@include file="/WEB-INF/views/common/breadcrumb.jsp"%>
	<!--  메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Heading -->
					<h3 class="mb-10 text-center">경기 일정</h3>
				</div>
			</div>
			<div class="mb-9 d-flex">
				<div id="search_date" class="me-2">
					<div id="calendar">2024-07-24</div>
				</div>

				<select name="search_sport" id="search_sport">
					<option value="all" selected>전체종목</option>
					<option value="3x3 농구">3x3 농구</option>
					<option value="7인제 럭비">7인제 럭비</option>
					<option value="경영">경영</option>
					<option value="골프">골프</option>
					<option value="기계체조">기계체조</option>
					<option value="근대5종">근대5종</option>
					<option value="농구">농구</option>
					<option value="다이빙">다이빙</option>
					<option value="레슬링">레슬링</option>
					<option value="리듬체조">리듬체조</option>
					<option value="마라톤 수영">마라톤 수영</option>
					<option value="배구">배구</option>
					<option value="배드민턴">배드민턴</option>
					<option value="복싱">복싱</option>
					<option value="브레이킹">브레이킹</option>
					<option value="비치발리볼">비치발리볼</option>
					<option value="사격">사격</option>
					<option value="사이클 BMX 레이싱">사이클 BMX 레이싱</option>
					<option value="사이클 BMX 프리스타일">사이클 BMX 프리스타일</option>
					<option value="사이클 도로">사이클 도로</option>
					<option value="사이클 산악자전거">사이클 산악자전거</option>
					<option value="사이클 트랙">사이클 트랙</option>
					<option value="서핑">서핑</option>
					<option value="수구">수구</option>
					<option value="승마">승마</option>
					<option value="스케이트보드">스케이트보드</option>
					<option value="스포츠클라이밍">스포츠클라이밍</option>
					<option value="아티스틱 스위밍">아티스틱 스위밍</option>
					<option value="양궁">양궁</option>
					<option value="역도">역도</option>
					<option value="육상">육상</option>
					<option value="유도">유도</option>
					<option value="요트">요트</option>
					<option value="조정">조정</option>
					<option value="축구">축구</option>
					<option value="카누 슬라럼">카누 슬라럼</option>
					<option value="카누 스프린트">카누 스프린트</option>
					<option value="테니스">테니스</option>
					<option value="탁구">탁구</option>
					<option value="태권도">태권도</option>
					<option value="트라이애슬론">트라이애슬론</option>
					<option value="트램폴린">트램폴린</option>
					<option value="펜싱">펜싱</option>
					<option value="하키">하키</option>
					<option value="핸드볼">핸드볼</option>
				</select>

			</div>
			<div id="toggle-date">
				<a class="total-date mb-2">모든 날짜 선택</a>
				<div id="grid-container" class="mb-10 p-2 shadow-lg">
					<!-- 5x7 = 35개의 div 요소를 생성합니다 -->
					<!-- 각 div 요소에 class="grid-item" data-sdate=""을 추가합니다 -->
					<!-- 그리고 각 div 요소 안에 class="hidden"을 추가하여 값을 숨깁니다 -->
					<div class="grid-item">일</div>
					<div class="grid-item">월</div>
					<div class="grid-item">화</div>
					<div class="grid-item">수</div>
					<div class="grid-item">목</div>
					<div class="grid-item">금</div>
					<div class="grid-item">토</div>
					<div class="grid-item">7월</div>
					<div class="grid-item"></div>
					<div class="grid-item sdate" data-sdate="2024-07-24">24</div>
					<div class="grid-item sdate" data-sdate="2024-07-25">25</div>
					<div class="grid-item sdate" data-sdate="2024-07-26">26</div>
					<div class="grid-item sdate" data-sdate="2024-07-27">27</div>
					<div class="grid-item sdate" data-sdate="2024-07-28">28</div>
					<div class="grid-item sdate" data-sdate="2024-07-29">29</div>
					<div class="grid-item sdate" data-sdate="2024-07-30">30</div>
					<div class="grid-item sdate" data-sdate="2024-07-31">31</div>
					<div class="grid-item"></div>
					<div class="grid-item"></div>
					<div class="grid-item"></div>
					<div class="grid-item"></div>
					<div class="grid-item">8월</div>
					<div class="grid-item"></div>
					<div class="grid-item"></div>
					<div class="grid-item sdate" data-sdate="2024-08-01">1</div>
					<div class="grid-item sdate" data-sdate="2024-08-02">2</div>
					<div class="grid-item sdate" data-sdate="2024-08-03">3</div>
					<div class="grid-item sdate" data-sdate="2024-08-04">4</div>
					<div class="grid-item sdate" data-sdate="2024-08-05">5</div>
					<div class="grid-item sdate" data-sdate="2024-08-06">6</div>
					<div class="grid-item sdate" data-sdate="2024-08-07">7</div>
					<div class="grid-item sdate" data-sdate="2024-08-08">8</div>
					<div class="grid-item sdate" data-sdate="2024-08-09">9</div>
					<div class="grid-item sdate" data-sdate="2024-08-10">10</div>
					<div class="grid-item sdate" data-sdate="2024-08-11">11</div>
				</div>

			</div>

			<div id="listGame">
				<!-- ajax로 받은 데이터 추가 -->
			</div>
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
