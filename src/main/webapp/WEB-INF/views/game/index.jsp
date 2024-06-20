<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>올림픽 경기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        /* 스타일을 추가하여 보기 좋게 합니다. */
        #unknown_flag {
            display: inline-block;
            width: 20px;
            height: 20px;
            background-color: grey;
            text-align: center;
            color: white;
            line-height: 20px;
        }
    </style>
    <script>
        $(document).ready(function() {
            var search_date = $('#search_date').val();
            var search_sport = $('#search_sport').val();
            
            function listGame(search_date, search_sport) {             
                $.ajax({
                    url: "/olympic/game/search.do",
                    type: "GET",
                    data: {
                        search_date: search_date,
                        search_sport: search_sport
                    },
                    success: function(data) {
                        var content = '';
                        if(data.game.length === 0) {
                            content += '<div><p>등록된 경기 일정이 없습니다.</p></div>';
                        } else {
                            $.each(data.game, function(idx, vo) {
                                content += '<div>';
                                content += '<img src="' + vo.sport_pictogram + '" alt="스포츠 아이콘" id="sport_pictogram">';
                                content += '<p>' + vo.sport_name + '</p>';
                                content += '<p>' + vo.tournament + '</p>';
                                if (vo.country1_flag) {
                                    content += '<img src="' + vo.country1_flag + '" alt="" id="flag">';
                                } else {
                                    content += '<div id="unknown_flag">?</div>';
                                }

                                if (vo.country2_flag) {
                                    content += '<img src="' + vo.country2_flag + '" alt="" id="flag">';
                                } else {
                                    content += '<div id="unknown_flag">?</div>';
                                }
                                
                                content += '<p>' + vo.stadium_name + '</p>';
                                content += '<p>' + vo.korea_date + '</p>';
                                content += '<p>' + vo.favorite + '</p>';
                                if (data.member && data.member.member_no) {
                                    if (vo.favorite === 0) {
                                        content += '<i onclick="create_favorite(' + vo.game_id + ')" id="create_favorite" class="fa-regular fa-heart" style="color: #4f4f4f;"></i>';
                                    } else if (vo.favorite === 1) {
                                        content += '<i onclick=""delete_favorite(' + vo.game_id + ')"" id="delete_favorite" class="fa-solid fa-heart" style="color: #f51919;"></i>';
                                    }
                                } else {
                                    if (vo.favorite === 0) {
                                    	/* content += '<a data-bs-toggle="modal" href="#modalLoginForm">'; */
                                    	content += '<a href="/olympic/member/login.do" id="loginLink">';
                                        content += '<i class="fa-regular fa-heart" style="color: #4f4f4f;"></i>';
                                        content += '</a>';
                                    }
                                }
                                content += '<button onclick="redirectToDetail(' + vo.game_id + ')">경기 상세 보기</button>';
                                content += '</div>';                    
                            });
                        }
                        $('#listGame').html(content); // AJAX로 받은 데이터 추가
                    }
                });
            };

            // 검색 조건이 변경될 때마다 listGame 함수 호출
            $('#search_date, #search_sport').on('change', function() {
                var search_date = $('#search_date').val();
                var search_sport = $('#search_sport').val();
                listGame(search_date, search_sport);
            });

            // 페이지 로드 시 초기 데이터 로드
            listGame(search_date, search_sport);
        });

        function redirectToDetail(gameId) {
            window.location.href = '/olympic/game/detail.do?game_id=' + gameId;
        };

        function create_favorite(game_id) {
        	alert(1)
            $.ajax({
                url: "/olympic/game/createFavorite.do",
                tpye: "POST",
                data: {
                    game_id : game_id
                },
                success: function(res) {
                    if (res == 1) {
                        $('#create_favorite').attr('id', 'delete_favorite').removeClass('fa-regular fa-heart').addClass('fa-solid fa-heart').css('color', '#f51919');
                    }
                },
                error: function() {
                    alert('오류가 발생했습니다.');
                }
            })
        };

        function delete_favorite(game_id) {
        	alert(1)
            $.ajax({
                url: "/olympic/game/deleteFavorite.do",
                tpye: "POST",
                data: {
                    game_id : game_id
                },
                success: function(res) {
                    if (res == 1) {
                        $('#delete_favorite').attr('id', 'create_favorite').removeClass('fa-regular fa-heart').addClass('fa-solid fa-heart').css('color', '#4f4f4f');
                    }
                },
                error: function() {
                    alert('오류가 발생했습니다.');
                }
            })
        };
    </script>
</head>
<body>
    <!--  타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <%@include file="/WEB-INF/views/common/header.jsp"%>
    <!--  헤더 하단 현재 경로 노출 -->
    <%@include file="/WEB-INF/views/common/breadcrumb.jsp"%>
    <!--  메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
    <section>
        <div>
            <input type="date" name="search_date" id="search_date" min="2024-07-26" max="2024-08-11" value="2024-07-26">
            <select name="search_sport" id="search_sport">
                <option value="all" selected>전체종목</option>
                <option value="양궁">양궁</option>
                <option value="육상">육상</option>
                <option value="배드민턴">배드민턴</option>
                <option value="3x3 농구">3x3 농구</option>
                <option value="농구">농구</option>
                <option value="브레이킹">브레이킹</option>
                <option value="사이클 BMX 프리스타일">사이클 BMX 프리스타일</option>
                <option value="사이클 BMX 레이싱">사이클 BMX 레이싱</option>
                <option value="복싱">복싱</option>
                <option value="스포츠클라이밍">스포츠클라이밍</option>
                <option value="사이클 도로">사이클 도로</option>
                <option value="카누 슬라럼">카누 슬라럼</option>
                <option value="카누 스프린트">카누 스프린트</option>
                <option value="사이클 트랙">사이클 트랙</option>
                <option value="다이빙">다이빙</option>
                <option value="승마">승마</option>
                <option value="축구">축구</option>
                <option value="펜싱">펜싱</option>
                <option value="기계체조">기계체조</option>
                <option value="골프">골프</option>
                <option value="리듬체조">리듬체조</option>
                <option value="트램폴린">트램폴린</option>
                <option value="핸드볼">핸드볼</option>
                <option value="하키">하키</option>
                <option value="유도">유도</option>
                <option value="근대5종">근대5종</option>
                <option value="사이클 산악자전거">사이클 산악자전거</option>
                <option value="마라톤 수영">마라톤 수영</option>
                <option value="조정">조정</option>
                <option value="7인제 럭비">7인제 럭비</option>
                <option value="요트">요트</option>
                <option value="사격">사격</option>
                <option value="스케이트보드">스케이트보드</option>
                <option value="서핑">서핑</option>
                <option value="아티스틱 스위밍">아티스틱 스위밍</option>
                <option value="경영">경영</option>
                <option value="테니스">테니스</option>
                <option value="태권도">태권도</option>
                <option value="트라이애슬론">트라이애슬론</option>
                <option value="탁구">탁구</option>
                <option value="비치발리볼">비치발리볼</option>
                <option value="배구">배구</option>
                <option value="역도">역도</option>
                <option value="수구">수구</option>
                <option value="레슬링">레슬링</option>
            </select>
        </div>
        <div id="listGame">
            <!-- ajax로 받은 데이터 추가 -->
        </div>
    </section>
    <!-- 푸터  -->
    <%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
