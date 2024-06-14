<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<script src="../js/jquery-3.7.1.min.js"></script>

<script>
$(document).ready(function() {
     // 테이블의 각 행 클릭했을 때
     $("tbody").on("click", "tr", function() {
         // 클릭한 문의 번호 가져오기
         var qna_no = $(this).find(".qna").data('qna-no');
         //상세 페이지로 이동
         location.href = '/olympic/qna/detail.do?qna_no=' + qna_no;
     });
});
</script>
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
                                <col width="8%">
                                <col width="12%">
                                <col width="40%">
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
                                            <td colspan="4">문의 내역이 없습니다.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="qnaItem" items="${qna}">
                                            <tr style="cursor : pointer;">
                                                <td class="py-4 qna" id="qna" data-qna-no="${qnaItem.qna_no}">${qnaItem.qna_no}</td>
                                                <td class="py-4">
												    ${qnaItem.type == 0 ? '경기'
												    : qnaItem.type == 1 ? '일반'
												    : qnaItem.type == 2 ? '결제'
												    : qnaItem.type == 3 ? '티켓'
												    : '기타'}
												</td>
                                                <td class="py-4">${qnaItem.title}</td>
                                                <td class="py-4"><fmt:formatDate value="${qnaItem.regdate}" pattern="yyyy-MM-dd"/></td>
                                                <td class="py-4">
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
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- 푸터 -->
    <%@include file="../common/footer.jsp"%>
</body>
</html>
