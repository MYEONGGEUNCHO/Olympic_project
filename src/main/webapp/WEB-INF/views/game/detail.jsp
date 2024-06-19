<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    	// 지완이 코드
    	function cleanUp() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/olympic/order/cleanupExpiredReservations?item_no=${game.item.item_no}", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        console.log("유효기간이 지난 예약건을 성공적으로 취소하였습니다. ");
                    } else {
                        console.error("유효기간 지난 예약건 취소 과정 에러 " + xhr.responseText);
                    }
                }
            };
            xhr.send();
    	};
    	cleanUp();
        // 페이지 로드시 댓글 목록 불러오는 요청
        loadComments();
        loadQna();

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

        // 댓글 작성 버튼 클릭 이벤트
        $('#createComment').click(function() {
            var commentContent = $('#commentContent').val();
            if (commentContent.trim() === '') {
                alert('댓글 내용을 입력하세요.');
                return;
            }

            $.ajax({
                url: 'createComment.do',  // 댓글 작성 요청 URL
                type: 'POST',
                data: { 
                    game_id: '${game.game_id}',
                    content: commentContent,
                    member_no: '${member.member_no}'
                },
                success: function(data) {
                    if (data == '1') {
                        $('#commentContent').val(''); // 입력 필드 초기화
                        loadComments(); // 댓글 목록 다시 불러오기
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', status, error);
                    alert('댓글을 등록하는 데 실패했습니다.');
                }
            });
        });
        function loadQna() {
            
        }

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
    <!--  타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <%@include file="/WEB-INF/views/common/header.jsp"%>
    <!--  헤더 하단 현재 경로 노출 -->
    <%@include file="/WEB-INF/views/common/breadcrumb.jsp"%>
    <!--  메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
    <section>
        <h3 class="mb-2">${game.sport_name}</h3>
        <p>${game.tournament}</p>
        <img style="width: 300px; height: 250px;"
            src="${game.sport.title_image}" alt="">
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
        <img style="width: 200px; height: 300px;"
            src="${game.stadium.stadium_img_url}" alt="">
        <form id="paymentForm" action="/olympic/order/initOrder" method="post">

            <input type="hidden" id="game_id" name="game_id"
                value="${game.game_id}"> <input type="hidden" id="item_no"
                name="item_no" value="${game.item.item_no}"> <input
                type="hidden" id="stadium_no" name="stadium_no"
                value="${game.stadium_no}"> <input type="hidden" id="content"
                name="content" value="${game.tournament}"> <label
                for="a_seat_price">A석 가격:</label> <input type="number"
                id="a_seat_price" name="a_seat_price"
                value="${game.item.a_seat_price}"><br> <label
                for="b_seat_price">B석 가격:</label> <input type="number"
                id="b_seat_price" name="b_seat_price"
                value="${game.item.b_seat_price}"><br> <label
                for="c_seat_price">C석 가격:</label> <input type="number"
                id="c_seat_price" name="c_seat_price"
                value="${game.item.c_seat_price}"><br> <label
                for="d_seat_price">D석 가격:</label> <input type="number"
                id="d_seat_price" name="d_seat_price"
                value="${game.item.d_seat_price}"><br> <label
                for="vip_seat_price">VIP석 가격:</label> <input type="number"
                id="vip_seat_price" name="vip_seat_price"
                value="${game.item.vip_seat_price}"><br> <label
                for="a_seat_sold">A석 개수:</label> <input type="number" id="a_seat_cnt"
                name="a_seat_cnt" value="0"><br> <label
                for="b_seat_sold">B석 개수:</label> <input type="number" id="b_seat_cnt"
                name="b_seat_cnt" value="0"><br> <label
                for="c_seat_sold">C석 개수:</label> <input type="number" id="c_seat_cnt"
                name="c_seat_cnt" value="0"><br> <label
                for="d_seat_sold">D석 개수:</label> <input type="number" id="d_seat_cnt"
                name="d_seat_cnt" value="0"><br> <label
                for="vip_seat_sold">VIP석 개수:</label> <input type="number"
                id="vip_seat_cnt" name="vip_seat_cnt" value="0"><br>

            <button type="submit">결제하기</button>
        </form>
        <h5>티켓가격</h5>
        <!-- c:if test -> 밑에 있는 애들, 각각 있느지 체크 -> 있으면 div 태그 안에 텍스트 기본석(el a.seat_price) -->
        <!-- script에서 $("#div_id").click(function() { $("hidden").val() = 넣어줘 선택ㄱ한거의 개수, 선택된 div에 클래스를 추가해주고 }) -->
        <!-- style에서 #id { cursor: pointer;}  .추가된 클래스 { border: 1px solid; background: white;} -->

        <p>${game.item.a_seat_price}</p>
        <p>${game.item.b_seat_price}</p>
        <p>${game.item.c_seat_price}</p>
        <p>${game.item.d_seat_price}</p>
        <p>${game.item.vip_seat_price}</p>
        <h5>잔여석</h5>
        <c:set var="a_seat_able"
            value="${game.stadium.a_seat_quantity - game.item.a_seat_sold}" />
        <c:set var="b_seat_able"
            value="${game.stadium.b_seat_quantity - game.item.b_seat_sold}" />
        <c:set var="c_seat_able"
            value="${game.stadium.c_seat_quantity - game.item.c_seat_sold}" />
        <c:set var="d_seat_able"
            value="${game.stadium.d_seat_quantity - game.item.d_seat_sold}" />
        <c:set var="vip_seat_able"
            value="${game.stadium.vip_seat_quantity - game.item.vip_seat_sold}" />


        <div class="highlight">잔여 좌석: ${a_seat_able}</div>
        <div class="highlight">잔여 좌석: ${b_seat_able}</div>
        <div class="highlight">잔여 좌석: ${c_seat_able}</div>
        <div class="highlight">잔여 좌석: ${d_seat_able}</div>
        <div class="highlight">잔여 좌석: ${vip_seat_able}</div>

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
        <input type="text" id="commentContent">
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
        <%@include file="./qna_list.jsp"%>
        <!-- 푸터  -->
        <%@include file="/WEB-INF/views/common/footer.jsp"%>
    </section>
</body>
</html>
