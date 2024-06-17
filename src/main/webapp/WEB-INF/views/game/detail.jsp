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
<script src="https://maps.googleapis.com/maps/api/js?key=${apikey}"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
        // 페이지 로드시 댓글 목록 불러오는 요청
        loadComments();

        function loadComments() {
            $.ajax({
                url: 'listComment.do',
                type: 'GET',
                data: { 
                    game_id: '${game.game_id}' 
                },
                success: function(data) {
                    var commentsHtml = '';
                    for (var i = 0; i < data.length; i++) {
                        commentsHtml += '<p>' + data[i].content + '</p>';
                    }
                    $('#listComment').html(commentsHtml);
                },
                error: function(xhr, status, error) {
                    alert('댓글을 불러오는 데 실패했습니다.');
                }
            });
        };
    });
    $('#createComment').click(function() {
        var commentContent = $('#commentContent').val();
        if (commentContent.trim() === '') {
            alert('댓글 내용을 입력하세요.');
            return;
        }

        $.ajax({
            url: 'createComment.do',  // 댓글 작성 요청 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ 
                game_id: '${game.game_id}'
                , content: commentContent 
                , member_no: '${member.member_no}'
            }),
            success: function(data) {
                $('#commentContent').val(''); // 입력 필드 초기화
                loadComments(); // 댓글 목록 다시 불러오기
            },
            error: function(xhr, status, error) {
                alert('댓글을 등록하는 데 실패했습니다.');
            }
        });
    });

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
        var address = '${game.stadium.stadium_position}';
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
    <img style="width: 300px; height: 250px;"  src="${game.sport.title_image}" alt="">
    <c:if test="${!empty vo.country1_flag}">
        <img src="${vo.country1_flag}" alt="" id="flag">
    </c:if>
    <c:if test="${empty vo.country1_flag}">
        <div id="unknown_flag">?</div>
    </c:if>
    <c:if test="${!empty vo.country2_flag}">
        <img src="${vo.country2_flag}" alt="" id="flag">
    </c:if>
    <c:if test="${empty vo.country2_flag}">
        <div id="unknown_flag">?</div>
    </c:if>

    <h4>지도 정보</h4>
    <p>날짜</p>
    <p>${game.korea_date}</p>
    <p>경기장</p>
    <p>${game.stadium_name}</p>
    <p>${game.stadium.stadium_position}</p>
    <div id="map" style="width: 320px; height: 480px;"></div>

    <h4>상품 정보</h4>
    <img style="width: 200px; height: 300px;" src="${game.stadium.stadium_img_url}" alt="">
    <h5>티켓가격</h5>
    <p>${game.item.a_seat_price}</p>
    <p>${game.item.b_seat_price}</p>
    <p>${game.item.c_seat_price}</p>
    <p>${game.item.d_seat_price}</p>
    <p>${game.item.vip_seat_price}</p>
    <h5>판매량</h5>
    <p>${game.item.a_seat_sold}</p>
    <p>${game.item.b_seat_sold}</p>
    <p>${game.item.c_seat_sold}</p>
    <p>${game.item.d_seat_sold}</p>
    <p>${game.item.vip_seat_sold}</p>
    <h5>총 좌석수</h5>
    <p>${game.stadium.a_seat_quantity}</p>
    <p>${game.stadium.b_seat_quantity}</p>
    <p>${game.stadium.c_seat_quantity}</p>
    <p>${game.stadium.d_seat_quantity}</p>
    <p>${game.stadium.vip_seat_quantity}</p>

    <h4>댓글</h4>
    <div id="listComment"></div>
    <textarea id="commentContent" rows="4" cols="50"></textarea>
    <button id="createComment">댓글 등록</button>

    <h4>종목 정보</h4>
    <p>${game.sport_name}</p>
    <p>종목 설명</p>
    <p>${game.sport.sport_info}</p>
    <p>종목 규칙</p>
    <p>${game.sport.sport_rule}</p>  
    <p>올림픽 역사</p>
    <p>${game.sport.sport_history}</p>

    <h4>문의 사항</h4>
</body>
</html>
