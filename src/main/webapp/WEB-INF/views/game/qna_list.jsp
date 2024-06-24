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
	cursor: pointer;
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
	text-align: left !important;
}

#qna_title a {
	margin-left: 1em;
}

.nav {
	flex-wrap: nowrap;
}

.nav-tabs {
	margin-left: -1em !important;
}

.nav-tabs .nav-item {
	margin-right: 2px;
}

.nav-tabs .nav-link {
	padding: 0.5rem 0.4rem 0.3rem ! important;
	margin: 0;
	font-size: 0.6em;
	color: black;
	background: #f2f2f2 !important;
	border-radius: 50% 20% 0 0;
}

.nav-link.active {
	background-color: #1f1f1f !important;
}

.nav-link.active:before {
	border: none !important;
}

.nav-tabs .nav-link.active {
	color: white !important;
}

#search-group {
	width: 300px;
}
</style>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
var currentPage = 1;
var orderInfo = "";
var typeValue;
var searchState = 0;
$(document).ready(function() {
	const thElements = document.querySelectorAll('th');
	thElements.forEach(th => {
		th.addEventListener('click', function() {
			var column = th.getAttribute('data-head');
			if (orderInfo == "" || orderInfo.indexOf("ASC") != -1) {
				column += ' DESC, ';
			} else {
				column += ' ASC, ';
			}
			// 표 헤더에 따른 정렬
			searchQna(1, column);
		});
	});

	// 페이지 로드 시 기본 QnA 리스트 로드
	loadQnaList();

	$('#type .nav-link').click(function(e) {
		e.preventDefault(); // 기본 동작(페이지 이동)을 막습니다.

		// 모든 탭에서 active 클래스를 제거하고 클릭된 탭에만 추가합니다.
		$('#type .nav-link').removeClass('active');
		$(this).addClass('active');

		// 클릭된 탭의 부모 li 요소의 data-value 속성 값을 가져옵니다.
		typeValue = $(this).parent().data('value');
		// searchQna 함수를 호출하면서 typeValue 값을 전달합니다.
		searchQna(1, "");
	});
	// 페이지 링크 클릭 시 searchQna 함수 호출
	$(document).on('click', '.page-link', function(event) {
		event.preventDefault(); // 기본 동작(링크 이동)을 막습니다.
		currentPage = $(this).data('page');
		searchQna(currentPage, "");
	});

	function searchQna(page, orderinfo) {
		orderInfo = orderinfo + "q.qna_no";
		// 	TODO: game_id는 해당 페이지 gameVO에서 받아오기
		// TODO: member_no는 어떻게 받아와야할까????
		var searchType = $("#search_type").val();
		var searchWords = $("#search_words").val();
		if (page == null || page == 0) page = 1;
		if (typeValue == "notice") {
			typeValue = "all";
			searchState = 1;
		}
		else {
			searchState = 0;
		}
		var requestData = {
			page: page,
			type: 0,
			orderinfo: orderInfo,
			state: searchState,
			game_id: "${game.game_id}"
		};

		$.ajax({
			type: "POST",
			url: "/olympic/qna/search.do",
			contentType: "application/json",
			data: JSON.stringify(requestData),
			success: function(response) {
				updateQnaList(response);
			},
			error: function(xhr, status, error) {
				console.error("Error:", error);
				alert('검색 중 오류가 발생했습니다.');
			}
		});
	}

	function updateQnaList(data) {
		var search = data.searchConditions;
		var result = data.searchResults;

		var qnaList = $("#qnaList");
		qnaList.empty();
		var pagination = $("#pagination");
		if (result.length === 0) {
			pagination.empty();
			qnaList.append("<tr><td colspan='7' class='text-center lh-lg'>검색 결과가 없습니다.</td></tr>");
			pagination.append('<li class="page-item active"><a class="page-link" href="#;" data-page="1">1</a></li>');
		} else {
			pagination.empty();
			if (search.pages.isPrev) {
				pagination.append('<li class="page-item"><a class="page-link page-link-arrow" href="#;" onclick="searchQna(' + (search.pages.startPage - 1) + ')"><i class="fa fa-caret-left"></i></a></li>');
			}
			for (var i = search.pages.startPage; i <= search.pages.endPage; i++) {
				pagination.append('<li class="page-item"><a class="page-link" href="#;" data-page="' + i + '">' + i + '</a></li>');
			}
			if (search.pages.isNext) {
				pagination.append('<li class="page-item"><a class="page-link page-link-arrow" href="#;" onclick="searchQna(' + (search.pages.endPage + 1) + ')"><i class="fa fa-caret-right"></i></a></li>');
			}
			$.each(result, function(index, item) {
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
				var itemDateStr = itemDate.toISOString().substring(0, 10);
				var nowDateStr = now.toISOString().substring(0, 10);
				var formattedDate = itemDateStr === nowDateStr ? itemDate.toTimeString().substring(0, 5) : itemDate.toLocaleDateString();
				var nullName = item.name === null ? "" : item.name;

				if (item.state == 1) {
					replyStatus = "";
					nullName = "관리자";
				}
				var row = '<tr class="lh-lg bg-light border border-top">';
				row += '<td>' + item.qna_no + '</td>';
				row += '<td>' + typeText + '</td>';
				row += '<td class="text-break" id="qna_title">';
				row += '<a href="/olympic/qna/detail.do?qna_no=' + item.qna_no + '">';
				if (item.update_date != null)
					row += '<span class="fst-italic text-gray-500">[수정됨] &nbsp;</span>';
				row += item.title + '</a></td>';
				row += '<td class="text-break">' + nullName + '</td>';
				row += '<td class="small">' + formattedDate + '</td>';
				row += '<td>' + item.readcnt + '</td>';
				row += '<td>' + replyStatus + '</td></tr>';
				qnaList.append(row);
			});
			// 현재 페이지에 해당하는 링크에 active 클래스 추가
			$('.page-link').each(function() {
				if ($(this).data('page') == search.page) {
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
			type: "POST",
			url: "/olympic/qna/search.do",
			contentType: "application/json",
			data: JSON.stringify({
				type: 0,
				state: 0,
				game_id: "${game.game_id}"
			}), // 기본 값으로 모든 QnA 로드
			success: function(response) {
				updateQnaList(response);
			},
			error: function(xhr, status, error) {
				console.error("Error:", error);
				alert('데이터 로드 중 오류가 발생했습니다.');
			}
		});
	}
});

</script>

</head>
<body>
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
					<th data-head="q.qna_no">번호</th>
					<th data-head="type">분류</th>
					<th data-head="title">제목</th>
					<th data-head="m.name">작성자</th>
					<th data-head="regdate">작성일자</th>
					<th data-head="readcnt">조회수</th>
					<th data-head="reply">답변 상태</th>
				</tr>
			</thead>
			<tbody id="qnaList">
				<!-- AJAX로 불러온 데이터가 이곳에 삽입됨 -->
			</tbody>
		</table>
	</div>

	<!-- Pagination -->
	<nav class="pt-3 d-flex justify-content-center justify-content-md-center">
		<ul class="pagination pagination-sm text-gray-400" id="pagination">
			<!-- ajax로 값이 들어갈 부분 -->
		</ul>
	</nav>
	<div class="mx-auto">
		<c:if test="${!empty login && login.state == 0}">
			<div class="d-flex justify-content-end m-2">
				<a class="btn btn-sm btn-dark" href="/olympic/qna/write.do?game_id=${game.game_id }">작성하기</a>
			</div>
		</c:if>
		<c:if test="${login.state == 3}">
			<div class="d-flex justify-content-end m-2">
				<a class="btn btn-sm btn-dark" href="/olympic/qna/write.do?game_id=${game.game_id }">공지사항 등록</a>
			</div>
		</c:if>
	</div>
</body>