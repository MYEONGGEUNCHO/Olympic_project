<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
function pagination() {
    var req_num_row = 3; //보여지는 행 개수
    var $tr = $('tbody tr');
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
    
 	// 테이블의 각 행 클릭했을 때
    $("tbody").on("click", "tr", function() {
        // 클릭한 문의 번호 가져오기
        var qna_no = $(this).find(".qna").data('qna-no');
        //상세 페이지로 이동
        location.href = '/olympic/qna/detail.do?qna_no=' + qna_no;
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
        /*background-color: #dc3545;*/
        color: #dc3545;
        border-color: #007bff;
    }
</style>
<body>
    <!-- 공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
    <%@include file="../common/modals.jsp"%>
    <!-- 타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <%@include file="../common/header.jsp"%>
    <!-- 헤더 하단 현재 경로 노출 -->
    <%@include file="../common/breadcrumb.jsp"%>
    <!-- 메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨 -->
    <section class="pt-7 pb-12">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h3 class="mb-10">문의 내역 확인</h3>
                </div>
            </div>
            <div class="row">
                <%@include file="../common/mypage.jsp"%>
                <div class="col-12 col-md-9 col-lg-8 offset-1 p-0">
                    <h5 class="mt-7 mb-5">1:1 문의 내역</h5>
                    <p class="fs-7">해당 문의 클릭시 답변을 확인하실 수 있습니다. </p>
                    <div id="favoritelist" class="table-responsive">
                        <table class="table text-center fs-8">
                            <colgroup>
                                <col width="12%">
                                <col width="12%">
                                <col width="36%">
                                <col width="20%">
                                <col width="20%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="px-0 py-2" scope="col">번호</th>
                                    <th class="px-0 py-2" scope="col">분류</th>
                                    <th class="px-0 py-2" scope="col">제목</th>
                                    <th class="px-0 py-2" scope="col">작성일</th>
                                    <th class="px-0 py-2" scope="col">답변처리상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- 반복문 -->
                                <c:choose>
                                    <c:when test="${empty qna}">
                                        <tr>
                                            <td colspan="4" onclick='event.cancelBubble=true;'>문의 내역이 없습니다.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="qnaItem" items="${qna}">
                                            <tr style="cursor : pointer;">
                                                <td class="py-3 qna" id="qna" data-qna-no="${qnaItem.qna_no}">${qnaItem.qna_no}</td>
                                                <td class="py-3">
												    ${qnaItem.type == 0 ? '경기'
												    : qnaItem.type == 1 ? '일반'
												    : qnaItem.type == 2 ? '결제'
												    : qnaItem.type == 3 ? '티켓'
												    : '기타'
												    }
												</td>
                                                <td class="py-3">${qnaItem.title}</td>
                                                <td class="py-3"><fmt:formatDate value="${qnaItem.regdate}" pattern="yyyy-MM-dd"/></td>
                                                <td class="py-3">
                                                    <c:choose>
                                                        <c:when test="${qnaItem.reply != null}">답변 완료</c:when>
                                                        <c:otherwise>답변 대기중</c:otherwise>
                                                    </c:choose>
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
    <!-- 푸터 -->
    <%@include file="../common/footer.jsp"%>
</body>
</html>
