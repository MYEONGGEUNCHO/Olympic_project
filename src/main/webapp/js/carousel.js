$(function() {
	// 메인화면 carousel 슬라이드 구현
	let CAROUSEL_LENGTH;
	let current = 0;
	// 동적으로 이미지 불러오기
	$.ajax({
		url: 'carousel-images',
		async: false,
		success: function(response) {
			CAROUSEL_LENGTH = response.length - 1;
			$.each(response, function(index, item) {
				console.log(item);
				$("#carousel").append(
					'<div id="carousel-item" class="bg-cover"><img src="carousel?filename='
					+ item + '"></div>')
			})
		}
	});
	//슬라이드 구현
	const nextEvent = () => {
		let width = $("#carousel-item").width();
		if (current !== CAROUSEL_LENGTH) {
			$("#carousel").css('transform', 'translateX(' + ((current + 1) * -width) + 'px)');
			current++;
		} else {
			current = 0;
			$("#carousel").css('transform', 'translateX(0px)');
		}
	};

	const prevEvent = () => {
		let width = $("#carousel-item").width();
		if (current !== 0) {
			current--;
			$("#carousel").css('transform', 'translateX(' + (current * -width) + 'px)');
		} else {
			current = CAROUSEL_LENGTH;
			$("#carousel").css('transform', 'translateX(' + (current * -width) + 'px)');
		}
	};
	let xPos;

	$("#next_button").on("click", nextEvent);
	$("#prev_button").on("click", prevEvent);
	$("#carousel").on("dragstart", function(event) {
		xPos = event.clientX;
		console.log("클릭됨", xPos);
	})
	$("#carousel").on("dragend", function(event) {
		console.log("클릭 뗌", event.clientX)
		if (xPos - event.clientX > 100) {
			nextEvent();
		} else if (event.clientX - xPos > 100) {
			prevEvent();
		}
	})

});
