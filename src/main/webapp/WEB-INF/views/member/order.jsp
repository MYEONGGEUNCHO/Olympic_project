<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<script src="../js/jquery-3.7.1.min.js"></script>
<script src="../js/ticket_carousel.js"></script>
<script>
function pagination() {
    var req_num_row = 3; //보여지는 행 개수
    var $table = $('#orderBody'); 
    var $tr = $table.find('tr');
    var total_num_row = $tr.length;  //테이블의 총 행 개수
    var num_pages = Math.ceil(total_num_row / req_num_row); //몇페이지
    var max_visible_pages = 3;  //하단 페이징 번호 수
    var current_page = 1;  //현재 페이지 번호(초기값은 1)
    var current_page_group = 1; // 페이지 그룹 번호

    function showPage(page) {
        $tr.hide(); //모든 행 숨기고
        var start = (page - 1) * req_num_row;  //보여줄 행의 시작
        for (var i = 0; i < req_num_row; i++) {
            $tr.eq(start + i).show();    //해당 행만 보여주기
        }
    }

    function renderPagination(current_page, current_page_group) {
        $('.pagination').empty();
        $('.pagination').append("<li><a class='prev' href='#'>이전&nbsp;</a></li>");
        var start_page = (current_page_group - 1) * max_visible_pages + 1; //현재 페이지 그룹의 시작 페이지 계산
        var end_page = Math.min(start_page + max_visible_pages - 1, num_pages); //그룹의 끝페이지 계신
        
        for (var i = start_page; i <= end_page; i++) {
            $('.pagination').append("<li><a class='pagination-link' href='#'>" + i + "&nbsp;</a></li>"); //번호 추가
        }
        
        $('.pagination').append("<li><a class='next' href='#'>다음&nbsp;</a></li>");
        $('.pagination a.pagination-link').removeClass('active').filter(function() {
            return $(this).text() == current_page; //현재 페이지와 일치하는 페이지 번호
        }).addClass('active'); //현재 페이지 나타내기
        
        
        if (current_page == 1) {
            $('.prev').parent().addClass('disabled'); //현재 페이지가 1이면 버튼 비활성화
        } else {
            $('.prev').parent().removeClass('disabled');
        }
        if (current_page_group * max_visible_pages >= num_pages) {
            $('.next').parent().addClass('disabled'); //마지막 그룹이면 다음 버튼 비활성화
        } else {
            $('.next').parent().removeClass('disabled');
        }
    }

    showPage(current_page);
    renderPagination(current_page, current_page_group);

    //페이지 번호 클릭하면 해당 페이지의 데이터 표시 및 페이지 번호 업데이트
    $('.pagination').on('click', '.pagination-link', function(e) {
        e.preventDefault();
        current_page = parseInt($(this).text());
        showPage(current_page);
        renderPagination(current_page, current_page_group);
    });
    
	//이전 그룹으로 이동
    $('.pagination').on('click', '.prev', function(e) {
        e.preventDefault();
        if (current_page_group > 1) {
            current_page_group--;
            current_page = (current_page_group - 1) * max_visible_pages + 1;
            showPage(current_page);
            renderPagination(current_page, current_page_group);
        }
    });

    //다음 그룹으로 이동
    $('.pagination').on('click', '.next', function(e) {
        e.preventDefault();
        if (current_page_group * max_visible_pages < num_pages) {
            current_page_group++;
            current_page = (current_page_group - 1) * max_visible_pages + 1;
            showPage(current_page);
            renderPagination(current_page, current_page_group);
        }
    });
}

$(document).ready(function() {
    pagination();
    
    
    $(document).on("click", ".cancelOrder", function() {
    	
    	
        var row = $(this).closest("tr");
		var imp_uid = row.find("#imp_uid").text();
		var order_no = row.find("#order_no").text();
		
		var fullText = row.find("#korea_date").html(); 
		var parts = fullText.split('<br>'); 
		var formattedText = parts.join(' | '); 
		
        $('#modalOrderNo').text(row.find("#order_no").text());
        $('#modalBuyDate').text(row.find("#buy_date").text());
        $('#modalSportName').text(row.find("#tournament").text());
        $('#modalStadiumName').text(row.find("#stadium_name").text());
        $('#modalKoreaDate').text(formattedText);
        $('#modalTicketCount').text(row.find("#ticket_count").text());
    	
        $("#cancelcheck").data("impuid", imp_uid); //버튼에 저장
        $("#cancelcheck").data("orderNo", order_no); //버튼에 저장
        
    });
    
 /*    $("#cancelcheck").click(function() {
    	var imp_uid = $(this).data("impuid"); // 저장된 imp_uid 가져오기
    	var order_no = $(this).data("orderNo");
    	const member_no = '${login.member_no}';
    	
    	console.log(order_no);
    	console.log(imp_uid);
    	console.log(member_no);
		
        var form = $("<form>", {
            "method": "POST",
            "action": '/olympic/order/cancel' 
        });

        $("<input>").attr({
            "type": "hidden",
            "name": "imp_uid",
            "value": imp_uid
        }).appendTo(form);
        
        $("<input>").attr({
            "type": "hidden",
            "name": "member_no",
            "value": member_no
        }).appendTo(form);
        $("<input>").attr({
            "type": "hidden",
            "name": "order_no",
            "value": order_no
        }).appendTo(form);

        form.appendTo('body').submit();
    }); */
    
    $("#cancelcheck").click(function() {
        var imp_uid = $(this).data("impuid"); // 저장된 imp_uid 가져오기
        var order_no = $(this).data("orderNo");
        var member_no = '${login.member_no}';
        
        /* console.log(order_no);
        console.log(imp_uid);
        console.log(member_no); */

        $.ajax({
            type: 'POST',
            url: '/olympic/order/cancel',
            contentType: 'application/json',
            data: JSON.stringify({
                order_no: order_no,
                imp_uid: imp_uid,
                member_no: member_no
            }),
            success: function(response) {
                alert(response); // 서버에서 반환된 메시지를 알림으로 표시
                location.reload(); // 성공 시 페이지 새로고침
                
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('서버 오류 발생. 다시 시도해주세요.');
            }
        });
    });
});
</script>
<style>
	.table {
	    width: 100%;
	    table-layout: fixed;
	}
	th, td {
	    word-wrap: break-word;
	    white-space: nowrap; 
	    overflow:hidden;
	    text-overflow: ellipsis;
	}
	th {
	    font-weight: bold;
	    font-size: 13px;
	}
	td {
		font-size:12px;
		
	}
    .pagination {
       display: flex;
       justify-content: center;
       list-style-type: none;
       padding: 0;
       overflow: hidden;
    }
    
    .pagination li {
        display: inline-block;
        margin-right: 5px;
    }
    
    .pagination a {
        padding: 5px 10px;
        text-decoration: none;
        cursor: pointer;
        color: black; 
    }
    
    .pagination a.pagination-link.active {
        color: #dc3545;
        border-color: #007bff;
    }
    
    .modal-body-scrollable {
	    max-height: 400px; 
	    overflow-y: auto;
	}
	.carousel-control-prev-icon,
	.carousel-control-next-icon {
	    background-color: black;
	    opacity: 0.5; /* 투명도 조정 */
	}
	.carousel-item {
	    display: none;
	    width: 100%;
	}
	.carousel-item.active {
	    display: block;
	}
	.carousel-inner {
	    position: relative;
	    overflow: hidden;
	    display: flex;
	}
	.carousel-control-prev,
	.carousel-control-next {
	    width: 5%; /* 슬라이드 바깥쪽으로 위치 조정 */
	    z-index: 1; /* 슬라이드와 겹치지 않도록 함 */
	    opacity: 0.7; /* 투명도 조정 */
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
            <h3 class="mb-10">예매 내역 확인</h3>
          </div>
        </div>
        <div class="row">
          <%@include file="../common/mypage.jsp"%>
			<div class="col-12 col-md-9 col-lg-8 offset-1 p-0">
            <!-- Heading -->
            <h5 class="mt-7 mb-5">예매 확인/취소</h5>
            <div class="d-flex justify-content-between align-items-center mb-5">
	            <p class="fs-7 mb-0">상세보기 클릭시 결제 내역을 확인하실 수 있습니다.</p>
	            <a href="#ListCancelOrderModal" class="mb-1" data-bs-toggle="modal" data-bs-target="#ListCancelOrderModal" id="openModal">취소내역 보기</a>
	        </div>
            <!-- Card -->
            <div id="favoritelist" class="table-responsive">
		        <table class="table text-center fs-8 table-bordered">
		        <colgroup>
		            <col width=29%>
		            <col width=12%>
		            <col width=15%>
		            <col width=17%>
		            <col width=13%>
		            <col width=6%>
		            <col width=9%>
		            <col width=9%>
		        </colgroup>
				  <thead>
				    <tr>
				      <th class="px-0 py-2" scope="col">주문번호</th>
				      <th class="px-0 py-2" scope="col">주문일</th>
				      <th class="px-0 py-2" scope="col">경기정보</th>
				      <th class="px-0 py-2" scope="col">경기장</th>
				      <th class="px-0 py-2" scope="col">경기일자</th>
				      <th class="px-0 py-2" scope="col">매수</th>
				      <th class="px-0 py-2" scope="col">취소</th>
				      <th class="px-0 py-2" scope="col">티켓확인</th>
				    </tr>
				  </thead>
				  <tbody class="table-group-divider" id="orderBody">
				  <!-- 반복문 -->
				  <c:choose>
					<c:when test="${empty order}">
						<tr>
					    	<td colspan="9" onclick='event.cancelBubble=true;'>예매 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="orderItem" items="${order}">
							<tr class="order-row">
								<td id="member_no" style="display:none;">${orderItem.member_no}</td>
								<td id="imp_uid" style="display:none;">${orderItem.imp_uid}</td>
                                <td class="py-3 px-1" id="order_no">${orderItem.order_no}</td>
                                <td class="py-3 px-1" id="buy_date"><fmt:formatDate value="${orderItem.buy_date}" pattern="yyyy-MM-dd"/></td>
                                <td class="py-2 px-1" id="tournament">${orderItem.sport_name}<br>${orderItem.tournament }</td>
                                <td class="py-3 px-1" id="stadium_name">${orderItem.stadium_name}</td>
								<td class="py-2 px-1" id="korea_date"><fmt:formatDate value="${orderItem.korea_date}" pattern="yyyy-MM-dd"/><br>Time: ${orderItem.korea_time}</td>
                                <td class="py-3 px-1" id="ticket_count">${orderItem.ticket_count }</td>
                                <td class="py-3 px-1" id="cancel"><a class="cancelOrder danger" data-bs-toggle="modal" href="#CancelOrderModal" >취소하기</a></td>
                                <td class="py-4 px-1" id="show">
                                    <a class="showTicket danger" data-bs-toggle="modal" data-order-no="${orderItem.order_no}" href="#ticketModal">티켓확인</a>
                                </td>
							</tr>
						</c:forEach>
					</c:otherwise>
					</c:choose>
				  </tbody>
				</table>
				<ul class="pagination mt-2">
    				<!-- 페이징 하단 바 -->
  				</ul>
			  </div>
			  
            </div>
        </div>
      </div>
    </section>

	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
	<!-- 주문 취소 내역 테이블 모달 -->
	<div class="modal fade" id="ListCancelOrderModal" data-bs-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-xl" role="document" style="width: 70%;">
	            <div class="modal-content">
	            	<!-- Close -->
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
						<i class="fe fe-x" aria-hidden="true"></i>
					</button>
					<!-- Header-->
					<div class="modal-header fs-lg">
						<strong class="mx-auto my-auto h3">예매 취소 내역</strong>
					</div>
	                <div class="modal-body modal-body-scrollable">
	                    <table class="table text-center fs-7 table-bordered ">
	                        <colgroup>
	                            <col width=25%>
	                            <col width=12%>
	                            <col width=12%>
	                            <col width=15%>
	                            <col width=13%>
	                            <col width=13%>
	                            <col width=8%>
	                        </colgroup>
	                        <thead>
	                            <tr>
	                                <th class="px-0 py-2" scope="col">주문번호</th>
	                                <th class="px-0 py-1" scope="col">경기정보</th>
	                                <th class="px-0 py-1" scope="col">경기일자</th>
	                                <th class="px-0 py-2" scope="col">경기장</th>
	                                <th class="px-0 py-2" scope="col">주문일자</th>
	                                <th class="px-0 py-2" scope="col">취소일자</th>
	                                <th class="px-0 py-2" scope="col">매수</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:choose>
	                                <c:when test="${empty cancel}">
	                                    <tr>
	                                        <td colspan="7" onclick='event.cancelBubble=true;'>취소 내역이 없습니다.</td>
	                                    </tr>
	                                </c:when>
	                                <c:otherwise>
	                                    <c:forEach var="cancelItem" items="${cancel}">
	                                        <tr class="cancel-row">
	                                            <td class="py-3 px-1">${cancelItem.order_no}</td>
	                                            <td class="py-2 px-1">${cancelItem.sport_name} <br> ${cancelItem.tournament }</td>
	                                            <td class="py-2 px-1"><fmt:formatDate value="${cancelItem.korea_date}" pattern="yyyy-MM-dd"/><br>${cancelItem.korea_time}</td>
	                                            <td class="py-3 px-1">${cancelItem.stadium_name}</td>
	                                            <td class="py-3 px-1"><fmt:formatDate value="${cancelItem.buy_date}" pattern="yyyy-MM-dd"/></td>
	                                            <td class="py-3 px-1"><fmt:formatDate value="${cancelItem.cancel_date}" pattern="yyyy-MM-dd"/></td>
	                                            <td class="py-3 px-1">${cancelItem.ticket_count }</td>
	                                        </tr>
	                                    </c:forEach>
	                                </c:otherwise>
	                            </c:choose>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	        </div>
	    </div>
</body>
</html>
