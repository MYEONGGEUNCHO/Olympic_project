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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRW9rxPptnDhbOjNsNEbObzwJ5bTzwAS4"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
	function init_map() {
		var map_options = {
			zoom: 18, // 지도를 띄웠을 때의 줌 크기
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};

		var map = new google.maps.Map(
			document.getElementById("map-canvas"), // div의 id와 값이 같아야 함
			map_options
		);

		var size_x = 40;
		var size_y = 40;

		var image = new google.maps.MarkerImage(
			'${game.stadium.stadium_position}',
			new google.maps.Size(size_x, size_y),
			null,
			null,
			new google.maps.Size(size_x, size_y)
		);
		
		// Geocoding
		var stadium_position = '${game.stadium.stadium_position}'; // 경기장 주소
		var marker = null;
		var geocoder = new google.maps.Geocoder();
		geocoder.geocode({ 'address': stadium_position }, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				map.setCenter(results[0].geometry.location);
				marker = new google.maps.Marker({
					map: map,
					icon: image,
					title: '${game.stadium_name}',
					position: results[0].geometry.location
				});
				var content = '${game.stadium_name}';
				var infowindow = new google.maps.InfoWindow({
					content: content
				});
				google.maps.event.addListener(marker, "click", function() {
					infowindow.open(map, marker);
				});
			} else {
				alert("Geocode was not successful for the following reason: " + status);
			}
		});
	};
	google.maps.event.addDomListener(window, 'load', init_map);
</script>
</head>
<body>
	<h3 class="mb-2">${game.sport_name}</h3>
	<p>${game.tournament}</p>
	<p>${game.country1_name}</p> <p>${game.country2_name}</p>
	<p>${game.country1_flag}</p> <p>${game.country2_flag}</p>

	<h4>지도 정보</h4>
	<p>날짜</p>
	<p>${game.korea_date}</p>
	<p>경기장</p>
	<p>${game.stadium.stadium_position}</p>
	<div id="map-canvas" style="width: 100%; height: 340px" title="경기장 위치"></div>

	<h4>상품 정보</h4>
	<p>${game.item.a_seat_price}</p>
	<p>${game.item.b_seat_price}</p>
	<p>${game.item.c_seat_price}</p>
	<p>${game.item.d_seat_price}</p>
	<p>${game.item.vip_seat_price}</p>

	<h4>댓글</h4>

	<h4>종목 정보</h4>
	<p>${game.sport_name}</p>
	<img src="${game.sport.title_image}" alt="">
	<p>종목 설명</p>
	<p>${game.sport.sport_info}</p>
	<p>종목 규칙</p>
	<p>${game.sport.sport_rule}</p>  
	<p>올림픽 역사</p>
	<p>${game.sport.sport_history}</p>

	<h4>문의 사항</h4>
</body>
</html>
