<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올림픽 경기 일정</title>
<style>
    #unknown_flag {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: gray;
        text-align: center;
        line-height: 100px;
        font-size: 50px;
    }
    #flag {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        line-height: 100px;
    }
    #sport_pictogram {
        width: 200px;
        height: 100px;
    }
</style>
<script src="/olympic/js/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
        $('#korea_date, #sport_name').on('change', function() {
            var korea_date = $('#korea_date').val();
            var sport_name = $('#sport_name').val();
            
            $.ajax({
                url: '/olympic/game/index.do',
                type: 'GET',
                data: {
                    korea_date: korea_date,
                    sport_name: sport_name
                },
                success: function(data) {
                    var content = '';
                    if (!data || !Array.isArray(data)) {
                        content += '<div><p>등록된 경기 일정이 없습니다.</p></div>';
                    } else {
                        data.forEach(function(vo) {
                            content += '<div>';
                            content += '<img src="' + vo.sport_pictogram + '" alt="스포츠 아이콘">';
                            
                            if (vo.country1_flag) {
                                content += '<img src="' + vo.country1_flag + '" alt="나라1">';
                            } else {
                                content += '<div id="unknown_flag">?</div>';
                            }
                            
                            if (vo.country2_flag) {
                                content += '<img src="' + vo.country2_flag + '" alt="나라2">';
                            } else {
                                content += '<div id="unknown_flag">?</div>';
                            }
                            
                            content += '<p>' + vo.stadium_name + '</p>';
                            content += '<p>' + vo.tournament + '</p>';
                            content += '<p>' + vo.korea_date + '</p>';
                            
                            if (vo.favorite == 0) {
                                content += '<i class="fa-regular fa-heart" style="color: #4f4f4f;"></i>';
                            } else {
                                content += '<i class="fa-solid fa-heart" style="color: #f51919;"></i>';
                            }
                            
                            content += '<button onclick="redirectToDetail(' + vo.game_id + ')">경기 상세 보기</button>';
                            content += '</div>';
                        });
                    }
                    
                    $('#gameList').html(content);
                },
                error: function(xhr, status, error) {
                    console.error('에러 발생: ' + error);
                }
            });
        });
    });

    function redirectToDetail(game_id) {
        window.location.href = '${pageContext.request.contextPath}/game/detail.do?game_id=' + game_id;
    }
</script>
</head>
<body>
    <%@include file="/WEB-INF/views/common/header.jsp"%>
    <%@include file="/WEB-INF/views/common/breadcrumb.jsp"%>
    <section>
        <div>
            <input type="date" name="korea_date" id="korea_date" min="2024-07-26" max="2024-08-11" value="2024-07-26">
            <select name="sport_name" id="sport_name">
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
        <div id="gameList">
            <!-- Ajax로 받은 데이터를 여기에 추가할 예정 -->
        </div>
    </section>
    <%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
