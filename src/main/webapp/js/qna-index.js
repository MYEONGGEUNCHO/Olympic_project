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
	// #search_words 요소에서 엔터 키를 눌렀을 때
	$('#search_words').keypress(function(event) {
		if (event.which == 13) { // 13은 엔터 키의 키 코드입니다.
			event.preventDefault();
			searchQna(1, "");
		}
	});

	// #search_words 요소의 값이 변경되었을 때
	$('#search_words').on('input', function() {
		searchQna(1, "");
	});
	$("#searchBtn").click(function() {
		searchQna(1, "");
	});
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
			search_type: searchType,
			search_words: searchWords,
			page: page,
			type: typeValue,
			orderinfo: orderInfo,
			state: searchState
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
		var notice = data.noticeResults;
		//		console.log(search);
		//		console.log(result);
		//		console.log(notice);
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
			$.each(notice, function(index, item) {
				var itemDate = new Date(item.regdate);
				var now = new Date();
				var itemDateStr = itemDate.toISOString().substring(0, 10);
				var nowDateStr = now.toISOString().substring(0, 10);
				var formattedDate = itemDateStr === nowDateStr ? itemDate.toTimeString().substring(0, 5) : itemDate.toLocaleDateString();

				var row = '<tr class="lh-lg bg-light border border-top fw-bold">';
				row += '<td>' + item.qna_no + '</td>';
				row += '<td>🚨</td>';
				row += '<td class="text-break" id="qna_title">';
				row += '<a href="/olympic/qna/detail.do?qna_no=' + item.qna_no + '">' + item.title + '</a></td>';
				row += '<td class="text-break">관리자</td>';
				row += '<td class="small">' + formattedDate + '</td>';
				row += '<td>' + item.readcnt + '</td>';
				row += '<td></td></tr>';
				qnaList.append(row);
			});
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
				search_type: "all",
				search_words: ""
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
