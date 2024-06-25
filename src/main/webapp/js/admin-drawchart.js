$(function() {
	// 판매 관련 데이터 추출
	const sumSalesByGame = chartData.sumSalesByGame;
	const countSalesByGame = chartData.countSalesByGame;
	const sumSalesByDays = chartData.sumSalesByDays;
	const countSalesByDays = chartData.countSalesByDays;

	// game_id를 labels에, total_price와 sale_count를 data에 넣기 위한 배열 생성
	const gameLabels = sumSalesByGame.map(item => item.game_id);
	const gameTotalPrices = sumSalesByGame.map(item => item.total_price);
	const gameSaleCounts = countSalesByGame.map(item => item.sale_count);
	const daysLabels = sumSalesByDays.map(item => {
		const date = new Date(item.buy_date);
		return date.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' })
			.replace(/\. /g, '.')
			.replace(/\.$/, '');
	});
	const daysTotalPrices = sumSalesByDays.map(item => item.total_price);
	const daysSaleCounts = countSalesByDays.map(item => item.sale_count);

	// 차트를 그릴 캔버스를 가져옴
	const sales_ctx = document.getElementById('salesChart').getContext('2d');
	const salesGame = {
		type: 'bar',
		data: {
			labels: gameLabels,
			datasets: [
				{
					label: '판매 금액',
					data: gameTotalPrices,
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					borderColor: 'rgba(255, 99, 132, 1)',
					borderWidth: 1,
					yAxisID: 'y'
				},
				{
					label: '판매량',
					data: gameSaleCounts,
					backgroundColor: 'rgba(75, 192, 192, 0.2)',
					borderColor: 'rgba(75, 192, 192, 1)',
					borderWidth: 1,
					yAxisID: 'y1'
				}
			]
		},
		options: {
			scales: {
				y: {
					type: 'linear',
					position: 'left',
					beginAtZero: true,
					title: {
						display: true,
						text: '판매 금액',
						color: 'rgba(255, 99, 132, 1)'
					},
					ticks: {
						color: 'rgba(255, 99, 132, 1)'
					}
				},
				y1: {
					type: 'linear',
					position: 'right',
					beginAtZero: true,
					title: {
						display: true,
						text: '판매량',
						color: 'rgba(75, 192, 192, 1)'
					},
					ticks: {
						color: 'rgba(75, 192, 192, 1)'
					},
					grid: {
						drawOnChartArea: false // 두 번째 Y축의 그리드 선을 표시하지 않음
					}
				}
			}
		}
	};
	const salesDays = {
		type: 'bar',
		data: {
			labels: daysLabels,
			datasets: [
				{
					label: '판매 금액',
					data: daysTotalPrices,
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					borderColor: 'rgba(255, 99, 132, 1)',
					borderWidth: 1,
					yAxisID: 'y'
				},
				{
					label: '판매량',
					data: daysSaleCounts,
					backgroundColor: 'rgba(75, 192, 192, 0.2)',
					borderColor: 'rgba(75, 192, 192, 1)',
					borderWidth: 1,
					yAxisID: 'y1'
				}
			]
		},
		options: {
			scales: {
				y: {
					type: 'linear',
					position: 'left',
					beginAtZero: true,
					title: {
						display: true,
						text: '판매 금액',
						color: 'rgba(255, 99, 132, 1)'
					},
					ticks: {
						color: 'rgba(255, 99, 132, 1)'
					}
				},
				y1: {
					type: 'linear',
					position: 'right',
					beginAtZero: true,
					title: {
						display: true,
						text: '판매량',
						color: 'rgba(75, 192, 192, 1)'
					},
					ticks: {
						color: 'rgba(75, 192, 192, 1)'
					},
					grid: {
						drawOnChartArea: false // 두 번째 Y축의 그리드 선을 표시하지 않음
					}
				}
			}
		}
	}
	// 차트 생성
	let salesChart = new Chart(sales_ctx, salesGame);
	let isGame = true;
	$("#salesGameBtn, #salesDaysBtn").click(function() {
		$("#salesGameBtn").toggle();
		$("#salesDaysBtn").toggle();
		salesChart.destroy();
		if (isGame) {
			salesChart = new Chart(sales_ctx, salesDays);
			isGame = false;
		} else {
			salesChart = new Chart(sales_ctx, salesGame);
			isGame = true;
		}
	})
	// 취소 관련 데이터 추출
	const countCancelsByGame = chartData.countCancelsByGame;
	const countCancelsByDays = chartData.countCancelsByDays;
	// game_id를 labels에, total_price와 sale_count를 data에 넣기 위한 배열 생성
	const cancelsGameLabels = countCancelsByGame.map(item => item.game_id);
	const cancelsGameCounts = countCancelsByGame.map(item => item.cancel_count);
	const cancelsDaysLabels = countCancelsByDays.map(item => {
		const date = new Date(item.cancel_date);
		return date.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' })
			.replace(/\. /g, '.')
			.replace(/\.$/, '');
	});

	// 차트를 그릴 캔버스를 가져옴
	const cancels_ctx = document.getElementById('cancelsChart').getContext('2d');
	const cancelsGame = {
		type: 'bar',
		data: {
			labels: cancelsGameLabels,
			datasets: [
				{
					label: '경기별 취소량',
					data: cancelsGameCounts,
					backgroundColor: 'rgba(75, 192, 192, 0.2)',
					borderColor: 'rgba(75, 192, 192, 1)',
					borderWidth: 1,
					yAxisID: 'y'
				}
			]
		},
		options: {
			scales: {
				y: {
					type: 'linear',
					position: 'right',
					beginAtZero: true,
					title: {
						display: true,
						text: '경기별 취소량',
						color: 'rgba(75, 192, 192, 1)'
					},
					ticks: {
						color: 'rgba(75, 192, 192, 1)'
					},
				}
			}
		}
	};
	const cancelsDays = {
		type: 'bar',
		data: {
			labels: cancelsDaysLabels,
			datasets: [
				{
					label: '날짜별 취소량',
					data: cancelsGameCounts,
					backgroundColor: 'rgba(75, 192, 192, 0.2)',
					borderColor: 'rgba(75, 192, 192, 1)',
					borderWidth: 1,
					yAxisID: 'y'
				}
			]
		},
		options: {
			scales: {
				y: {
					type: 'linear',
					position: 'right',
					beginAtZero: true,
					title: {
						display: true,
						text: '날짜별 취소량',
						color: 'rgba(75, 192, 192, 1)'
					},
					ticks: {
						color: 'rgba(75, 192, 192, 1)'
					},
				}
			}
		}
	}
	// 차트 생성
	let cancelsChart = new Chart(cancels_ctx, cancelsGame);
	let isGameCancels = true;
	$("#cancelsGameBtn, #cancelsDaysBtn").click(function() {
		$("#cancelsGameBtn").toggle();
		$("#cancelsDaysBtn").toggle();
		cancelsChart.destroy();
		if (isGameCancels) {
			cancelsChart = new Chart(cancels_ctx, cancelsDays);
			isGameCancels = false;
		} else {
			cancelsChart = new Chart(cancels_ctx, cancelsGame);
			isGameCancels = true;
		}
	})
});
