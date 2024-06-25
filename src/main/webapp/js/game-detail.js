function fn_cancel(seatname) {
	$(seatname).val(0);
	choicedUpdate();

};
function choicedUpdate(seat) {
	let seat_name = ["a_seat_cnt", "b_seat_cnt", "c_seat_cnt", "d_seat_cnt", "vip_seat_cnt"];
	let seat_info = ["CAT A", "CAT B", "CAT C", "CAT D", "VIP"];
	if (seat === "CAT A") {
		$("#a_seat_cnt").val(parseInt($("#a_seat_cnt").val()) + 1);
	}
	else if (seat === "CAT B") {
		$("#b_seat_cnt").val(parseInt($("#b_seat_cnt").val()) + 1);
	}
	else if (seat === "CAT C") {
		$("#c_seat_cnt").val(parseInt($("#c_seat_cnt").val()) + 1);
	}
	else if (seat === "CAT D") {
		$("#d_seat_cnt").val(parseInt($("#d_seat_cnt").val()) + 1);
	}
	else if (seat === "VIP") {
		$("#vip_seat_cnt").val(parseInt($("#vip_seat_cnt").val()) + 1);
	}
	let seat_cnt = [$("#a_seat_cnt").val(), $("#b_seat_cnt").val(), $("#c_seat_cnt").val(), $("#d_seat_cnt").val(), $("#vip_seat_cnt").val()];
	let price = [parseInt($("#a_seat_price_info").val()), parseInt($("#b_seat_price_info").val()), parseInt($("#c_seat_price_info").val()), parseInt($("#d_seat_price_info").val()), parseInt($("#vip_seat_price_info").val())];
	let result_text = "";
	let price_sum = 0;
	for (let i = 0; i < seat_cnt.length; i++) {
		if (seat_cnt[i] != 0) {
			price_sum += seat_cnt[i] * price[i];
			result_text += '<div data-cat="' + seat_name[i] + '" class="d-flex justify-content-around align-items-center mx-3 font-monospace"><span>';
			result_text += seat_info[i] + " " + price[i].toLocaleString('ko-KR') + "원 * " + seat_cnt[i] + "매";
			result_text += '</span><a href="#;" onclick="fn_cancel(' + seat_name[i] + ')";"><i id="choice_cancel" class="fa-regular fa-circle-xmark"></i></a></div>';

		}
	}
	$("#choice_result").html(result_text);
	$("#choice_sum").html(price_sum.toLocaleString('ko-KR'));
}

function add_favorite(game_id) {
	// 추가
	$.ajax({
		url: "/olympic/game/createFavorite.do",
		type: "POST",
		data: {
			game_id: game_id
		},
		success: function() {
			alert("관심 목록에 추가되었습니다.");
		},
		error: function() {
			alert('오류가 발생했습니다.');
		}
	});

}
function purchase() {
	if($("#a_seat_cnt").val() == 0 && $("#b_seat_cnt").val() == 0 && $("#c_seat_cnt").val() == 0 && $("#d_seat_cnt").val() == 0 && $("#vip_seat_cnt").val() == 0 ) {
		alert("좌석을 하나라도 선택하세요.");
		return false;
	}
}

$(function() {
	// 결제 중간 끊겼던 것들 초기화
	cleanUp();
	// 페이지 로드시 댓글 목록 불러오는 요청
	loadComments();
	$("#seat_choice").children("div").click(function() {
		let seat = $(this).children("label").contents().filter(function() {
			return this.nodeType === 3;
		}).text().trim();
		choicedUpdate(seat);
	})



	// 댓글 작성 버튼 클릭 이벤트
	$('#createComment').click(function() {
		let commentContent = $('#commentContent').val();
		let member_no = $("#member_no").val();
		if (commentContent.trim() === '') {
			alert('댓글 내용을 입력하세요.');
			return;
		}
		if (member_no === '') {
			alert("로그인 후 이용하세요");
			return;
		}
		commentContent = commentContent.replace(/(<([^>]+)>)/ig, "");
		console.log(commentContent);
		$.ajax({
			url: 'createComment.do', // 댓글 작성 요청 URL
			type: 'POST',
			data: {
				game_id: $("#game_id").val(),
				content: commentContent,
				member_no: member_no
			},
			success: function(data) {
				if (data == '1') {
					$('#commentContent').val(''); // 입력 필드 초기화
					loadComments(); // 댓글 목록 다시 불러오기
				}
			},
			error: function(xhr, status, error) {
				console.error('Error:', xhr);
				alert('댓글을 등록하는 데 실패했습니다.');
			}
		});
	});
	function cleanUp() {
		var xhr = new XMLHttpRequest();
		let cleanURL = "/olympic/order/cleanupExpiredReservations?item_no=";
		let item_no = $("#item_no").val();
		xhr.open("GET", cleanURL + item_no, true);
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					console.log("유효기간이 지난 예약건을 성공적으로 취소하였습니다.");
				} else {
					console.error("유효기간 지난 예약건 취소 과정 에러 " + xhr.responseText);
				}
			}
		};
		xhr.send();
	}

	function loadComments() {
		$.ajax({
			url: 'listComment.do',
			type: 'GET',
			data: {
				game_id: $("#game_id").val()
			},
			success: function(data) {
				$("#comment_count").html(data.length);
				var commentsHtml = '';
				for (var i = 0; i < data.length; i++) {
					let date = new Date(data[i].regdate);
					commentsHtml += '<p class="d-flex justify-content-between"><span>';
					commentsHtml += data[i].content + '</span>';
					commentsHtml += '<span class="fs-xs text-gray-400">' + data[i].name + '(' + data[i].email + ') ' + date.toLocaleString() + '</span></p>';
				}
				const $element = $("#listComment");
				// 현재의 최하단 구하기
				const eh = $element.clientHeight + $element.scrollTop;
				// 요소가 추가되어 길이가 길어지기 전에 비교
				const isScroll = $element.scrollHeight <= eh;
				// -- 요소 추가하는 코드 --
				$element.html(commentsHtml);
				// 스크롤이 최하단 일때만 고정
				if (isScroll) {
					$element.scrollTop = $element.scrollHeight;
				}
			},
			error: function(xhr, status, error) {
				alert('댓글을 불러오는 데 실패했습니다.');
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}

	var geocoder;
	var map;

	function initialize() {
		geocoder = new google.maps.Geocoder();
		var latlng = new google.maps.LatLng(45.7821824, 4.8739386);
		var mapOptions = {
			zoom: 14,
			center: latlng
		};
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
		codeAddress(); // 지도 초기화 후 주소로 위치 설정
	}

	function codeAddress() {
		var address = $("#stadium_pos").val();
		geocoder.geocode({ 'address': address }, function(results, status) {
			if (status === 'OK') {
				map.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker({
					map: map,
					position: results[0].geometry.location
				});
			} else {
				alert('Geocode was not successful for the following reason: ' + status);
			}
		});
	}
	google.maps.event.addDomListener(window, 'load', initialize);


});

