let editor;
var files;
$(function() {
	const editor = new toastui.Editor({
		el: document.querySelector('#editor'),
		height: '500px',
		initialEditType: 'wysiwyg',
		initialValue: '내용을 입력해 주세요.',
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

	$("#btn").click(function(e) {
		if ($("input[name='writer']").val() == "") {
			alert('로그인 후 사용하세요.');
			location.href = "index.do";
			return;
		}
		if ($("#title").val() == "" || $("#title").val() == null) {
			alert("제목을 입력해주세요.");
			return;
		}
		if (editor.getMarkdown() == "") {
			alert("내용을 입력해주세요.");
			return;
		}
		write();
	});

	function write() {
		let member_state = $("input[name='writer_state']").val();
		const inner_html = editor.getHTML();
		//공지 게시물 등록
		if (member_state == 3) {
			$.ajax({
				type: 'POST',
				url: '/olympic/qna/write.do',
				headers: {
					"Content-Type": "application/json"
				},
				data: JSON.stringify({
					type: $("input[name='type']:checked").val(),
					title: $("#title").val(),
					content: inner_html,
					member_no: $("input[name='writer']").val(),
					state: 1
				}),
				success: function(response) {
					alert('공지사항이 성공적으로 작성되었습니다.');
					window.history.back();
				},
				error: function(xhr, status, error) {
					console.error("Error:", error);
					alert('공지사항 작성 중 오류가 발생했습니다.');
				}
			});
		}
		else {
			//일반 게시물 등록
			$.ajax({
				type: 'POST',
				url: '/olympic/qna/write.do',
				headers: {
					"Content-Type": "application/json"
				},
				data: JSON.stringify({
					type: $("input[name='type']:checked").val(),
					title: $("#title").val(),
					content: inner_html,
					member_no: $("input[name='writer']").val(),
					game_id: $("#game_id").val()
				}),
				success: function(response) {
					alert('글이 성공적으로 작성되었습니다.');
					window.history.back();
				},
				error: function(xhr, status, error) {
					console.error("Error:", error);
					alert('글 작성 중 오류가 발생했습니다.');
				}
			});
		}
	}
});
