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
    var geocoder;
    var map;

    function initialize() {
        geocoder = new google.maps.Geocoder();
        var latlng = new google.maps.LatLng(45.7821824, 4.8739386);
        var mapOptions = {
            zoom: 8,
            center: latlng
        };
        map = new google.maps.Map(document.getElementById('map'), mapOptions);
        codeAddress(); // 지도 초기화 후 주소로 위치 설정
    }

    function codeAddress() {
        var address = '${game.stadium.stadium_position}';
		console.log(address)
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
    <div id="map" style="width: 320px; height: 480px;"></div>

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
