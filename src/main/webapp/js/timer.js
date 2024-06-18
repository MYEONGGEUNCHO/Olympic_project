document
	.addEventListener(
		'DOMContentLoaded',
		// 메인화면 시간 출력
		function() {
			var countdownElement = document
				.querySelector('[data-countdown]');
			var targetDate = new Date(countdownElement
				.getAttribute('data-date')).getTime();

			function updateCountdown() {
				var now = new Date().getTime();
				var distance = targetDate - now;

				var days = Math.floor(distance
					/ (1000 * 60 * 60 * 24));
				var hours = Math
					.floor((distance % (1000 * 60 * 60 * 24))
						/ (1000 * 60 * 60));
				var minutes = Math
					.floor((distance % (1000 * 60 * 60))
						/ (1000 * 60));
				var seconds = Math
					.floor((distance % (1000 * 60)) / 1000);

				document.querySelector('[data-days]').innerText = String(
					days).padStart(2, '0');
				document.querySelector('[data-hours]').innerText = String(
					hours).padStart(2, '0');
				document.querySelector('[data-minutes]').innerText = String(
					minutes).padStart(2, '0');
				document.querySelector('[data-seconds]').innerText = String(
					seconds).padStart(2, '0');

				if (distance < 0) {
					clearInterval(countdownInterval);
					document.querySelector('[data-days]').innerText = '00';
					document.querySelector('[data-hours]').innerText = '00';
					document.querySelector('[data-minutes]').innerText = '00';
					document.querySelector('[data-seconds]').innerText = '00';
				}
			}

			var countdownInterval = setInterval(updateCountdown,
				1000);
			updateCountdown();
		});