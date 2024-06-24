<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>경기 상세</title>
<script src="../js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
    $(function() {
	cleanup();
	$("#test_btn").click(function() {
	    $.ajax({
		url : "/olympic/order/cancel",
		type : "POST",
		headers : {
		    "Content-Type" : "application/json"
		},
		data : JSON.stringify({
		    member_no : "${login.member_no}",
		    imp_uid : "${order_imp_uid}"
		}),
		success : function(res) {
		    console.log("성공", res);
		},
		error : function(xhr, status, error) {
		    console.error("에러", error);
		}
	    });
	});
    });
    function cleanup() {
	var itemNo = document.getElementById("item_no").value;
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/olympic/order/?item_no=" + itemNo, true);
	xhr.onreadystatechange = function() {

	    if (xhr.readyState === 4) {
		if (xhr.status === 200) {
		    console.log("유효기간이 지난 예약건을 성공적으로 취소하였습니다. ");
		} else {
		    console
			    .error("유효기간 지난 예약건 취소 cleanupExpiredReservations과정 에러 "
				    + xhr.responseText);
		}
	    }
	};
	xhr.send();
    };
</script>
</head>
<body>
	<input type="text" id="test_uid" placeholder="imp_uid 입력" />
	<button type="button" id="test_btn">취소 요청</button>
	<h1>경기 상세</h1>
	<form id="paymentForm" action="/olympic/order/initOrder" method="post">

		<input type="hidden" id="game_id" name="game_id" value="500">
		<input type="hidden" id="item_no" name="item_no" value="500">
		<input type="hidden" id="stadium_no" name="stadium_no" value="16">
		<input type="hidden" id="content" name="content" value="32강 남자 축구 미국 vs 중국">

		<label for="a_seat_price">A석 가격:</label>
		<input type="number" id="a_seat_price" name="a_seat_price" value="10000">
		<br>

		<label for="b_seat_price">B석 가격:</label>
		<input type="number" id="b_seat_price" name="b_seat_price" value="20000">
		<br>

		<label for="c_seat_price">C석 가격:</label>
		<input type="number" id="c_seat_price" name="c_seat_price" value="30000">
		<br>

		<label for="d_seat_price">D석 가격:</label>
		<input type="number" id="d_seat_price" name="d_seat_price" value="40000">
		<br>

		<label for="vip_seat_price">VIP석 가격:</label>
		<input type="number" id="vip_seat_price" name="vip_seat_price" value="50000">
		<br>

		<label for="a_seat_sold">A석 개수:</label>
		<input type="number" id="a_seat_cnt" name="a_seat_cnt" value="1">
		<br>

		<label for="b_seat_sold">B석 개수:</label>
		<input type="number" id=b_seat_cnt " name="b_seat_cnt" value="1">
		<br>

		<label for="c_seat_sold">C석 개수:</label>
		<input type="number" id="c_seat_cnt" name="c_seat_cnt" value="1">
		<br>

		<label for="d_seat_sold">D석 개수:</label>
		<input type="number" id="d_seat_cnt" name="d_seat_cnt" value="1">
		<br>

		<label for="vip_seat_sold">VIP석 개수:</label>
		<input type="number" id="vip_seat_cnt" name="vip_seat_cnt" value="1">
		<br>

		<button type="submit">결제하기</button>
	</form>
</body>
</html>
