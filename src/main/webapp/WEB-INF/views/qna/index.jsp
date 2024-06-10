<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="ko">
<head>
<style>
th {
	text-align: center !important;
}
table {
	table-layout: fixed;
}

td {
	text-align: center;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#qna_title {
	text-algin: left !important;
}
</style>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>

	$(document).ready(function() {

		// 페이지 로드 시 기본 QnA 리스트 로드
		loadQnaList();
		// #search_words 요소에서 엔터 키를 눌렀을 때
		$('#search_words').keypress(function(event) {
			event.preventDefault();
			if (event.which == 13) { // 13은 엔터 키의 키 코드입니다.
				searchQna(1);
			}
		});

		// #search_words 요소의 값이 변경되었을 때
		$('#search_words').on('input', function() {
			searchQna(1);
		});
		$("#searchBtn").click(function() {
			searchQna(1);
		});
		$("input[name='type']").change(function() {
			//     	console.log($(this).val());
			searchQna(1);
		})
		// 페이지 링크 클릭 시 searchQna 함수 호출
	$(document).on('click', '.page-link', function(event) {
		event.preventDefault(); // 기본 동작(링크 이동)을 막습니다.
		var page = $(this).data('page');
		searchQna(page);
	});

	function searchQna(page) {
		// 	TODO: game_id는 해당 페이지 gameVO에서 받아오기
		// TODO: member_no는 어떻게 받아와야할까????
		var type = $("input[name='type']:checked").val();
		var searchType = $("#search_type").val();
		var searchWords = $("#search_words").val();
		if (page == null || page == 0)
			page = 1;
		var requestData = {
			search_type : searchType,
			search_words : searchWords,
			page : page,
			type : type
		};

		$.ajax({
			type : "POST",
			url : "/olympic/qna/search.do",
			contentType : "application/json",
			data : JSON.stringify(requestData),
			success : function(response) {
				updateQnaList(response);
			},
			error : function(xhr, status, error) {
				console.error("Error:", error);
				alert('검색 중 오류가 발생했습니다.');
			}
		});
	}

	function updateQnaList(data) {
	    
		var qnaList = $("#qnaList");
		qnaList.empty();
		var pagination = $("#pagination");
		if (data.length === 0) {
			pagination.empty();
			qnaList
					.append("<tr><td colspan='7' class='text-center lh-lg'>검색 결과가 없습니다.</td></tr>");
			pagination
					.append('<li class="page-item active"><a class="page-link" href="#;" data-page="1">1</a></li>');
		} else {
			pagination.empty();
							<c:if test="${search.pages.isPrev}">
					pagination.append(`<li class="page-item">
						<a class="page-link page-link-arrow" href="#;" onclick="searchQna(${search.pages.startPage - 1})">
							<i class="fa fa-caret-left"></i>
						</a>
					</li>`);
				</c:if>
			<c:forEach var="i" begin="${search.pages.startPage}" end="${search.pages.endPage}">
				pagination.append(`<li class="page-item"><a class="page-link" href="#;" data-page="${i}">${i}</a></li>`);
			</c:forEach>
			<c:if test="${search.pages.isNext}">
					pagination.append(`<li class="page-item">
						<a class="page-link page-link-arrow" href="#;" onclick="searchQna(${search.pages.endPage + 1})">
							<i class="fa fa-caret-right"></i>
						</a>
					</li>`);
				</c:if>
			$.each(
							data,
							function(index, item) {
								var typeText;
								switch (item.type) {
								case 0:
									typeText = "경기 문의";
									break;
								case 1:
									typeText = "일반 문의";
									break;
								case 2:
									typeText = "결제 문의";
									break;
								case 3:
									typeText = "티켓 문의";
									break;
								}

								var replyStatus = item.reply ? "답변 완료" : "대기중";

								var itemDate = new Date(item.regdate);
								var now = new Date();
								var itemDateStr = itemDate.toISOString()
										.substring(0, 10);
								var nowDateStr = now.toISOString().substring(0,
										10);
								var formattedDate = itemDateStr === nowDateStr ? itemDate
										.toTimeString().substring(0, 5)
										: itemDate.toLocaleDateString();

								var row = '<tr class="lh-lg bg-light border border-top border-secondary">';
								row += '<td>' + item.qna_no + '</td>';
								row += '<td>' + typeText + '</td>';
								row += '<td class="text-break" id="qna_title">';
								row += '<a href="/olympic/qna/detail.do?qna_no='
										+ item.qna_no + '">';
								row += item.title;
								row += '</a></td>';
								row += '<td class="text-break">' + item.name
										+ '</td>';
								row += '<td class="small">' + formattedDate
										+ '</td>';
								row += '<td>' + item.readcnt + '</td>';
								row += '<td>' + replyStatus + '</td></tr>';
								qnaList.append(row);

							});
			// 현재 페이지에 해당하는 링크에 active 클래스 추가
			console.log(${search.page});
			$('.page-link').each(function() {
				if ($(this).data('page') == ${search.page}) {
					$(this).parent().addClass('active');
				} else {
					$(this).parent().removeClass('active');
					$(this).parent().addClass('page-item');
				}
			});

		}
	}

	function loadQnaList() {
		$.ajax({
			type : "POST",
			url : "/olympic/qna/search.do",
			contentType : "application/json",
			data : JSON.stringify({
				search_type : "all",
				search_words : ""
			}), // 기본 값으로 모든 QnA 로드
			success : function(response) {
				updateQnaList(response);
			},
			error : function(xhr, status, error) {
				console.error("Error:", error);
				alert('데이터 로드 중 오류가 발생했습니다.');
			}
		});
	}
	
	
	});
</script>


</head>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<form id="searchForm" class="d-flex">
		<div id="type">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="type" id="type_all" value="all" checked>
				<label class="form-check-label" for="type_all">전체 문의</label>
			</div>
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="type" id="type_game" value="0">
				<label class="form-check-label" for="type_game">경기 문의</label>
			</div>
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="type" id="type_common" value="1">
				<label class="form-check-label" for="type_common">일반 문의</label>
			</div>
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="type" id="type_order" value="2">
				<label class="form-check-label" for="type_order">결제 문의</label>
			</div>
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="type" id="type_ticket" value="3">
				<label class="form-check-label" for="type_ticket">티켓 문의</label>
			</div>
		</div>

		<!-- 검색 타입 선택 -->
		<select id="search_type" name="search_type" class="form-select form-select-xs">
			<option value="all" <c:if test="${search.search_type == 'all'}">selected</c:if>>전체</option>
			<option value="title" <c:if test="${search.search_type == 'title'}">selected</c:if>>제목</option>
			<option value="content" <c:if test="${search.search_type == 'content'}">selected</c:if>>내용</option>
		</select>
		<!-- 검색 창 -->
		<div class="input-group input-group-merge">
			<input id="search_words" class="form-control" type="search" placeholder="Search">
			<div class="input-group-append">
				<button class="btn btn-outline-border" type="button" id="searchBtn">
					<i class="fe fe-search"></i>
				</button>
			</div>
		</div>
	</form>

	<!-- 문의사항 목록 -->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Heading -->
					<h3 class="mb-10 text-center">QNA</h3>
				</div>
			</div>
			<div class="row justify-content-center">
				<table border="1">
					<caption style="display: none;">게시판 목록</caption>
					<colgroup>
						<col width="80px" />
						<col width="80px" />
						<col width="*" />
						<col width="100px" />
						<col width="100px" />
						<col width="80px" />
						<col width="100px" />
					</colgroup>
					<thead class="lh-lg bg-dark text-white">
						<tr>
							<th>번호</th>
							<th>분류</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>조회수</th>
							<th>답변 상태</th>
						</tr>
					</thead>
					<tbody id="qnaList">
						<!-- AJAX로 불러온 데이터가 이곳에 삽입됨 -->
					</tbody>
				</table>
			</div>


		</div>

		<!-- Pagination -->
		<nav class="pt-3 d-flex justify-content-center justify-content-md-center">
			<ul class="pagination pagination-sm text-gray-400" id="pagination">
				<!-- ajax로 값이 들어갈 부분 -->
			</ul>
		</nav>
		<div class="d-flex justify-content-end m-2">
			<a class="btn btn-sm btn-dark" href="write.do">작성하기</a>
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
