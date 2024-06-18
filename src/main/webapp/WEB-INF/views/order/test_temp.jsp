<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>경기 상세</title>
</head>
<body>
    <h1>경기 상세</h1>
    <form id="paymentForm" action="/olympic/order/initOrder" method="post">
   		
        <input type="hidden" id="game_id" name="game_id" value="500">
        <input type="hidden" id="item_no" name="item_no" value="500">
        <input type="hidden" id="stadium_no" name="stadium_no" value="16">
        <input type="hidden" id="content" name="content" value="32강 남자 축구 미국 vs 중국">

        <label for="a_seat_price">A석 가격:</label>
        <input type="number" id="a_seat_price" name="a_seat_price" value="10000"><br>

        <label for="b_seat_price">B석 가격:</label>
        <input type="number" id="b_seat_price" name="b_seat_price" value="20000"><br>

        <label for="c_seat_price">C석 가격:</label>
        <input type="number" id="c_seat_price" name="c_seat_price" value="30000"><br>

        <label for="d_seat_price">D석 가격:</label>
        <input type="number" id="d_seat_price" name="d_seat_price" value="40000"><br>

        <label for="vip_seat_price">VIP석 가격:</label>
        <input type="number" id="vip_seat_price" name="vip_seat_price" value="50000"><br>

        <label for="a_seat_sold">A석 개수:</label>
        <input type="number" id="a_seat_sold" name="a_seat_sold" value="1"><br>

        <label for="b_seat_sold">B석 개수:</label>
        <input type="number" id="b_seat_sold" name="b_seat_sold" value="1"><br>

        <label for="c_seat_sold">C석 개수:</label>
        <input type="number" id="c_seat_sold" name="c_seat_sold" value="1"><br>

        <label for="d_seat_sold">D석 개수:</label>
        <input type="number" id="d_seat_sold" name="d_seat_sold" value="1"><br>

        <label for="vip_seat_sold">VIP석 개수:</label>
        <input type="number" id="vip_seat_sold" name="vip_seat_sold" value="1"><br>

        <button type="submit">결제하기</button>
    </form>
</body>
</html>
