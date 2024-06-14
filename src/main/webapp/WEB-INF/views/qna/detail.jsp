<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<script src="../js/jquery-3.7.1.min.js"></script>
<script>
function reply_open() {
    if($("#reply_content").css("display") == "none") {
		$("#reply_open").text("답변 창 닫기");
    }
    else {	
		$("#reply_open").text("답변 창 열기");
    }
    $("#reply_content").slideToggle();
}


    $(function() {
	const Viewer = toastui.Editor.factory;
	const viewer = new Viewer({
	    el : document.querySelector('#toast_viewer'),
	    height : '600px',
	    initialValue : '${qna.content}',
	    viewer: true
	});
	<c:if test="${!empty qna.reply}">
	const reply = '${qna.reply}';
	const reply_viewer = new Viewer({
	    el : document.querySelector('#reply_viewer'),
	    height : '600px',
	    initialValue : reply,
	    viewer: true
	});
	 </c:if>
	 <c:if test="${empty qna.reply && login.state==3}"> 
		const editor = new toastui.Editor({
		el: document.querySelector('#reply_editor'),
		height: '500px',
		initialEditType: 'wysiwyg',
		initialValue: '답변을 입력해 주세요.',
		previewStyle: 'vertical',
		language: 'ko-KR',
		autofocus: true,
		hooks: {
			//blob 정보를 AttachedVO에 맞춰서 JSON 형태로 전달한 후
			//해당 file의 경로를 돌려받기.
			async addImageBlobHook(blob, callback) {
				try {
					const formData = new FormData();
					formData.append('file', blob);
					const response = await fetch('/olympic/qna/upload.do', {
						method: 'POST',
						body: formData,
					});
					const filename = await response.text();
					const jsonObj = JSON.parse(filename);
					const forsaveName = jsonObj.forsave_name;
					const imageUrl = '/olympic/qna/download.do?filename=' + forsaveName;
					callback(imageUrl, '대체 텍스트');
				} catch (error) {
					console.log("업로드 실패 : ", error);
				}
			}
		}
	});
	</c:if>

	 
	 $("#modify").on('click', function() {
		location.href = "/olympic/qna/update.do?qna_no=${param.qna_no}";
	 });

	    $("#delete").click(function() {
		$.ajax({
		    type : "POST",
		    url : "/olympic/qna/delete.do",
		    headers : {
			"Content-Type" : "application/json"
		    },
		    data : JSON.stringify({
			qna_no : "${qna.qna_no}",
			member_no : "${qna.member_no}"
		    }),
		    success : function() {
			alert('삭제가 완료되었습니다.');
			location.href = "/olympic/qna/index.do";
		    },
		    error : function(xhr, status, error) {
			console.error("Error:", error);
			// 에러 시 수행할 동작
			alert('글 삭제 중 오류가 발생했습니다.');
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
												<div class="fx-xs text-bold">${empty qna.name ? '알 수 없음' : qna.name}님</div>
												<!-- Time -->
												<c:if test="${empty qna.update_date}">
													<span class="fs-xs text-muted">
														<time datetime="${qna.regdate}">
															<fmt:formatDate value="${qna.regdate}" pattern="yyyy-MM-dd HH시 mm분" />
														</time>
													</span>
												</c:if>
												<c:if test="${!empty qna.update_date}">
													<span class="fs-xs text-muted">
														<time datetime="${qna.update_date}">수정일자: ${qna.update_date}</time>
													</span>
												</c:if>
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
										<p class="text-gray-500">
										<div id="toast_viewer"></div>
										</p>
									</div>
								</div>
								<c:if test="${qna.state == 0 }">
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
																	<time datetime="${qna.reply_date}">
																		<fmt:formatDate value="${qna.reply_date}" pattern="yyyy-MM-dd HH시 mm분" />
																	</time>
																</c:if>

															</span>
														</div>
													</div>
													<hr>
													<!-- Text -->
													<c:if test="${empty qna.reply}">
														<p class="text-gray-500">아직 답변이 작성되지 않았습니다.</p>
														<c:if test="${login.state == 3 }">
															<a id="reply_open" href="javascript:;" onclick="reply_open()">답변 창 열기</a>
															<div id="reply_content" style="display: none;">
																<div id="reply_editor"></div>
																<button type="button" id="reply_write">등록하기</button>
															</div>
														</c:if>
													</c:if>
													<c:if test="${!empty qna.reply}">
														<div id="reply_viewer">
															<!--reply viewer 불러올 부분 -->
														</div>
													</c:if>
												</div>
											</div>
										</div>
									</div>
								</c:if>
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
