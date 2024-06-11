<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>

<script src="../js/jquery-3.7.1.min.js"></script>
<script>
    $(function() {
	$("#modify").click(function() {
	    location.href = "/olympic/qna/update.do?qna_no=${param.qna_no}";
	});

	$("#delete").click(function() {
	    $.ajax({
		type : "POST",
		url : "/olympic/qna/delete.do",
		headers : {
		    "Content-Type" : "application/json",
		},
		data : JSON.stringify({
		    qna_no : "${qna.qna_no}",
		    member_no : "${qna.member_no}",
		}),
		success : function() {
		    alert('삭제가 완료되었습니다.');
		    location.href = "/olympic/qna/index.do";
		},
		error : function(xhr, status, error) {
		    console.error("Error:", error);
		    // 에러 시 수행할 동작
		    alert('글 삭제 중 오류가 발생했습니다: ' + xhr.responseText);
		}
	    });
	});

    });
</script>

</head>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<!-- REVIEWS -->
	<section class="pt-9 pb-11" id="reviews">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Heading -->
					<h4 class="mb-10 text-center">문의 내용 확인</h4>
					<!-- TODO:: post요청 보내고 받아야함 -->
					<c:if test="${empty qna.reply && !empty login}">
						<div class="btn-group d-flex justify-content-end" role="group" aria-label="Buttons">
							<button type="button" id="modify" class="btn-circle btn-sm m-1 btn-outline-secondary">
								<i class="fa-regular fa-pen-to-square"></i>
							</button>
							<button type="button" id="delete" class="btn-circle btn-sm m-1 btn-outline-secondary">
								<i class="fa-regular fa-trash-can"></i>
							</button>
						</div>
					</c:if>
					<c:if test="${login.state == 3 }">
						<div class="btn-group d-flex justify-content-end" role="group" aria-label="Buttons">
							<button type="button" id="delete" class="btn-circle btn-sm mb-1 btn-outline-secondary">
								<i class="fa-regular fa-trash-can"></i>
							</button>
							<button type="button" id="reply" class="btn-circle btn-sm mb-1 btn-outline-secondary">
								<i class="fa-regular fa-comment-dots"></i>
							</button>
						</div>
					</c:if>
					<!-- Reviews -->
					<div class="mt-2">
						<!-- Review -->
						<div class="review">
							<div class="review-body">
								<div class="row">
									<div class="col-12 col-md-auto">
										<!-- Avatar -->
										<div class="avatar avatar-xxl mb-6 mb-md-0">
											<span class="avatar-title rounded-circle">
												<i class="fa fa-user"></i>
											</span>
										</div>
									</div>
									<div class="col-12 col-md">
										<!-- Header -->
										<div class="row mb-4">
											<div class="col-12">
												<span class="fs-xs text-muted d-flex justify-content-end">조회수 : ${qna.readcnt }</span>
												<div class="fx-xs text-bold">${qna.name}님</div>
												<!-- Time -->
												<span class="fs-xs text-muted">
													<time datetime="${qna.regdate}">${qna.regdate}</time>
												</span>
											</div>
										</div>

										<div class="col-12">
											<c:if test="${qna.type == 0}">
												<span class="mb-2 fs-lg fw-bold">${qna.title}</span>
												<span class="fs-xs text-muted">[경기문의]</span>
											</c:if>
											<c:if test="${qna.type == 1}">
												<span class="mb-2 fs-lg fw-bold">${qna.title}</span>
												<span class="fs-xs text-muted">[일반문의]</span>
											</c:if>
											<c:if test="${qna.type == 2}">
												<span class="mb-2 fs-lg fw-bold">${qna.title}</span>
												<span class="fs-xs text-muted">[결제문의]</span>
											</c:if>
											<c:if test="${qna.type == 3}">
												<span class="mb-2 fs-lg fw-bold">${qna.title}</span>
												<span class="fs-xs text-muted">[티켓문의]</span>
											</c:if>
										</div>
										<hr>
										<!-- Text -->
										<p class="text-gray-500">${qna.content}</p>
									</div>
								</div>
								<!-- Child review 관리자 답변 -->
								<div class="review review-child">
									<div class="review-body">
										<div class="row">
											<div class="col-12 col-md-auto">
												<!-- Avatar -->
												<div class="avatar avatar-xxl mb-6 mb-md-0">
													<span class="avatar-title rounded-circle">
														<i class="fa fa-user"></i>
													</span>
												</div>
											</div>
											<div class="col-12 col-md">
												<!-- Header -->
												<div class="row mb-4">
													<div class="col-12">
														<div class="fx-xs text-bold">관리자 답변</div>
														<!-- Time -->
														<span class="fs-xs text-muted d-flex justify-content-between">
															<c:if test="${!empty qna.reply}">
																<time datetime="${qna.reply_date}">${qna.reply_date}</time>
															</c:if>

														</span>
													</div>
												</div>
												<hr>
												<!-- Text -->
												<c:if test="${empty qna.reply}">
													<p class="text-gray-500">아직 답변이 작성되지 않았습니다.</p>
												</c:if>
												<c:if test="${!empty qna.reply}">
													<p class="text-gray-500">${qna.reply }</p>
												</c:if>
											</div>
										</div>
									</div>
								</div>
								<!-- Child review END -->
							</div>
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

</html>
