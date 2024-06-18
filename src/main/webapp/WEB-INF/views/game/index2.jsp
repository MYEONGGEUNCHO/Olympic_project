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
    

    function redirectToDetail(game_id) {
        window.location.href = '/olympic/game/detail.do?game_id=' + game_id;
    }
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
            <input type="date" name="search_date" id="search_date" min="2024-07-26" max="2024-08-11"
                value="2024-07-26">
            <select name="search_sport" id="search_sport" >
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
        <div>
            <c:if test="${empty map}">
                <tr>
                    <td colspan="15">등록된 종목이 없습니다.</td>
                </tr>
            </c:if>
            <c:if test="${!empty map}">
                <c:forEach var="vo" items="${map}">
                    <div>
                        <img src="${vo.sport_pictogram}" alt="" id="sport_pictogram">
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
                        <p>${vo.stadium_name}</p>
                        <p>${vo.tournament}</p>
                        <p>${vo.korea_date}</p>
                        <c:if test="${!empty member.member_no}">
                            <c:if test="${vo.favorite == 0}">
                                <i id="create_favorite" class="fa-regular fa-heart" style="color: #4f4f4f;"></i>
                            </c:if>
                            <c:if test="${vo.favorite == 1}">
                                <i id="delete_favorite" class="fa-solid fa-heart" style="color: #f51919;"></i>
                            </c:if>
                        </c:if>
                        <c:if test="${empty member.member_no}">
                            <c:if test="${vo.favorite == 0}">
                                <a href="${pageContext.request.contextPath}/member/login.do">
                                    <i id="create_favorite" class="fa-regular fa-heart" style="color: #4f4f4f;"></i>
                                </a>
                            </c:if>
                        </c:if>
                        
                        <button onclick="redirectToDetail(${vo.game_id })">경기 상세 보기</button>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </section>
    <!-- 푸터  -->
    <%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
