<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 글쓰기 테스트</title>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script>
	let editor;
	
	$(function() {
		editor = new toastui.Editor({
			el : document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
			height : '500px', // 에디터 영역의 높이 값 (OOOpx || auto)
			initialEditType : 'markdown', // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
			initialValue : '내용을 입력해 주세요.', // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
			previewStyle : 'vertical', // 마크다운 프리뷰 스타일 (tab || vertical)
			language : 'ko-KR',
			autofocus : true,
			hooks: {
				addImageBlobHook(blob, callback) {
					
				}
			}
		});
		
	});
	function printdiv() {
// 		$("#printdiv").html(editor.getMarkdown());		
// 		$("#printdiv").html(editor.getHTML());
		console.log("HTML:", editor.getHTML());
		console.log("Markdown:", editor.getMarkdown());
		const inner_html = editor.getHTML();
		$.ajax({
			type: 'POST',
			url: '/qna/write.do',
			headers: {
				"Content-Type": "application/json",
			},
			data: JSON.stringify({
				type: $("input[name='type']:checked").val(),
				title: $("#title").val(),
				content: inner_html
				}),
			success: function(response) {
				console.log("Response:", response);
				// 성공 시 수행할 동작
				alert('글이 성공적으로 작성되었습니다.');
			},
			error: function(xhr, status, error) {
				console.error("Error:", error);
				// 에러 시 수행할 동작
				alert('글 작성 중 오류가 발생했습니다.');
			}
		});
	}
</script>
</head>
<body>
	<h1>에디터 적용</h1>
	<form action="/qna/write.do" method="post">
		<p>작성자 :</p>
		<p id="writer">${login.name}</p>
		<p>분류</p>
		<div id="radio_group">
			<input type="radio" name="type" value=0>
			게임 문의
			<input type="radio" name="type" value=1>
			일반 문의
			<input type="radio" name="type" value=2>
			결제 문의
			<input type="radio" name="type" value=3>
			티켓 문의
		</div>
		<label for="title">제목 : </label>
		<input type="text" id="title" name="title" />
		<div id="editor"></div>
		<button type="button" onclick=printdiv()>입력</button>
	</form>
	<div id="printdiv"></div>
</body>
</html>