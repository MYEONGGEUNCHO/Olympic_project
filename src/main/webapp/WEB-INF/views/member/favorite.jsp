<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
function deleteGame(button) {
    var $this = $(button); 
    var gameId = $this.data('game-id'); // 버튼에서 game_id 가져오기

    $.ajax({
        url: "/olympic/member/deletefavorite.do", 
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            game_id: gameId
        }),
        success: function(res) {
            if(res > 0) {
                $this.closest('.list-group-item').remove();
            } else {
                alert('다시 시도하세요');
                return;
            }
        },
        error: function() {
            alert('서버 오류');
        }
    });
}


</script>
<style>
#favoritelist::-webkit-scrollbar {
    width: 4px; 
}

#favoritelist::-webkit-scrollbar-thumb {
    background: rgba(136, 136, 136, 0.3);
    border-radius: 10px;
    min-height: 20px;
}

#favoritelist::-webkit-scrollbar-thumb:hover {
    background: rgba(85, 85, 85, 0.3);
}

#favoritelist::-webkit-scrollbar-track {
    background: rgba(241, 241, 241, 0.5);
}

#favoritelist {
	max-height: 360px; 
	overflow-y: auto;
	overflow-x: hidden; 
}
</style>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">관심 목록 확인</h3>
          </div>
        </div>
        <div class="row">
          <%@include file="../common/mypage.jsp"%>
			<div class="col-12 col-md-9 col-lg-8 offset-lg-1">
            <!-- Heading -->
            <h5 class="mt-7 mb-7">나의 찜 목록</h5>
            <!-- Card -->
            <div id="favoritelist">

		    <div class="col-12">
		    <!-- 반복문 시작 자리 -->
		    <c:choose>
		    	<c:when test="${empty favorite}">
		    		<div class="text-center my-3">찜한 경기가 없습니다.</div>
		    	</c:when>
		    	<c:otherwise>
		    	<!-- List group -->
            <ul class="list-group list-group-lg list-group-flush-x mb-6">
            <c:forEach var="favorite" items="${favorite}">
              <li class="list-group-item py-2 me-5">
                <div class="row align-items-center">
                  <div class="col-2 d-flex justify-content-center align-items-center" >
                      <img style="width: 160px;" src="${favorite.sport_pictogram }" alt="..." >
                  </div>
                  
                  <div class="col my-1">

                    <!-- Title -->
                    <div class="d-flex mb-4 fw-bold">
                      <a class="text-body" href="product.html">${favorite.sport_name } &nbsp; ${favorite.tournament }</a> <span class="ms-auto">${favorite.stadium_name}</span>
                    </div>

                    <!-- Text -->
                    <div class="row">
	                    <div class="col-9 fs-sm text-muted m-0">
	                      경기 일자: ${favorite.korea_date } &ensp; 시간: ${favorite.korea_time }<br>
	                      출전 나라:
	                      <c:choose>
						    <c:when test="${empty favorite.country1_name}">
						        미정
						    </c:when>
						    <c:otherwise>
						        ${favorite.country1_name}
						    </c:otherwise>
						</c:choose> 
						vs 
						<c:choose>
						    <c:when test="${empty favorite.country2_name}">
						        미정
						    </c:when>
						    <c:otherwise>
						        ${favorite.country2_name}
						    </c:otherwise>
						</c:choose> 
	                    </div>
	                    <div class="col-3 d-flex align-items-center">
	                      <!-- Remove -->
	                      <button type="button" id="deleteBtn" data-game-id="${favorite.game_id}" data-member-no="${login.member_no}" class=" btn btn-link fs-s text-gray-400 ms-auto p-0" onClick="deleteGame(this);">
	                        <i class="fa-solid fa-heart" style="color: #fd938b;"></i> Remove
	                      </button>
	                    </div>
						</div>
                    <!--Footer -->
                    
                  </div>
                  
                </div>
              </li>
              </c:forEach>
            </ul>
		    	</c:otherwise>
            </c:choose>
			  </div>
            </div>
           </div>     
        </div>
      </div>
    </section>

	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
