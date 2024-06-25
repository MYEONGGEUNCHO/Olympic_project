document.addEventListener("DOMContentLoaded", function() {
	IMP.init(IMP_KEY);
    const button = document.getElementById('payButton');
    const couponSelect = document.getElementById('coupon_select');
    const applyCouponButton = document.getElementById('apply_coupon');
    const removeCouponButton = document.getElementById('remove_coupon');
    const totalPriceElement = document.getElementById('total_price');
    const hiddenTotalPriceElement = document.getElementById('hidden_total_price');
    const originalTotalPrice = parseInt(hiddenTotalPriceElement.value);
    let selectedCouponNo = ''; // 쿠폰 번호 저장 변수
    
    applyCouponButton.addEventListener('click', () => {
        const selectedCoupon = couponSelect.options[couponSelect.selectedIndex];
        selectedCouponNo = selectedCoupon.value; // 선택된 쿠폰 번호 저장
        const discount = parseInt(selectedCoupon.getAttribute('data-discount')) || 0;
        const discountedPrice = originalTotalPrice - (originalTotalPrice*(discount/100));
        hiddenTotalPriceElement.value = discountedPrice;
    });

    removeCouponButton.addEventListener('click', () => {
        totalPriceElement.innerText = originalTotalPrice;
        hiddenTotalPriceElement.value = originalTotalPrice;
        couponSelect.selectedIndex = 0;
        selectedCouponNo = ''; // 쿠폰 번호 초기화
    });
    
    // 10분 타이머 설정
    const timeoutMinutes = 3;
    const timeoutMilliseconds = timeoutMinutes * 60 * 1000;
    const countdownElement = document.getElementById('countdown');
    const startTime = Date.now();

    let countdownInterval = setInterval(() => {
        const remainingTime = timeoutMilliseconds - (Date.now() - startTime);
        const minutes = Math.floor(remainingTime / (60 * 1000));
        const seconds = Math.floor((remainingTime % (60 * 1000)) / 1000);
        countdownElement.innerText = `남은 시간: ${minutes}분 ${seconds}초`;

        if (remainingTime <= 0) {
            clearInterval(countdownInterval);
            alert('결제 시간이 초과되었습니다. 다시 시도해주세요.');
            const item_no2 = document.getElementById('hidden_item_no').value;
            fetch(`/olympic/order/cleanupExpiredReservations?item_no=${item_no2}`)
                .then(response => response.text())
                .then(data => {
                    console.log(data);
                    window.location.href = '/olympic/index.do'; // 메인 페이지로 리다이렉트
                })
                .catch(error => {
                    console.error('Error:', error);
                    window.location.href = '/olympic/index.do'; // 메인 페이지로 리다이렉트
                });
        }
    }, 1000);

    const onClickPay = async () => {
    	clearInterval(countdownInterval);
    	
         // 히든 필드에서 값을 가져옴
        const buyer_name = document.getElementById('hidden_buyer_name').value;
        const buyer_email = document.getElementById('hidden_buyer_email').value;
        const buyer_phone = document.getElementById('hidden_buyer_phone').value;
        const a_seat_price = document.getElementById('hidden_a_seat_price').value;
        const a_seat_sold = document.getElementById('hidden_a_seat_sold').value;
        const b_seat_price = document.getElementById('hidden_b_seat_price').value;
        const b_seat_sold = document.getElementById('hidden_b_seat_sold').value;
        const c_seat_price = document.getElementById('hidden_c_seat_price').value;
        const c_seat_sold = document.getElementById('hidden_c_seat_sold').value;
        const d_seat_price = document.getElementById('hidden_d_seat_price').value;
        const d_seat_sold = document.getElementById('hidden_d_seat_sold').value;
        const vip_seat_price = document.getElementById('hidden_vip_seat_price').value;
        const vip_seat_sold = document.getElementById('hidden_vip_seat_sold').value;
        const total_price = hiddenTotalPriceElement.value;
        const game_id = document.getElementById('hidden_game_id').value;
        const item_no = document.getElementById('hidden_item_no').value;
        const stadium_no = document.getElementById('hidden_stadium_no').value;
        const content = document.getElementById('hidden_content').value;

        const paymentVO = {
            buyer_name: buyer_name,
            buyer_email: buyer_email,
            buyer_phone: buyer_phone,
            a_seat_price: a_seat_price,
            a_seat_sold: a_seat_sold,
            b_seat_price: b_seat_price,
            b_seat_sold: b_seat_sold,
            c_seat_price: c_seat_price,
            c_seat_sold: c_seat_sold,
            d_seat_price: d_seat_price,
            d_seat_sold: d_seat_sold,
            vip_seat_price: vip_seat_price,
            vip_seat_sold: vip_seat_sold,
            total_price: total_price,
            game_id: game_id,
            item_no: item_no,
            stadium_no: stadium_no,
            content: content,
            coupon_no: selectedCouponNo // 선택된 쿠폰 번호 추가
        };

        // 백엔드 서버로 paymentVO 전송 -> 서버에서는 해당 정보로 주문객체 만들어서 저장하고 반환 
        const response = await fetch('/olympic/order/insertPay', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(paymentVO)
        });

        if (response.ok) {
            const responseData = await response.json();
            const savedOrder = responseData.order;
            const paymentData = responseData.payment;
            const memberData = responseData.member;

            // 포트원으 결제 요청
            IMP.request_pay({
                pg: 'kakaopay', // PG사
                pay_method: 'card', // 결제 수단
                merchant_uid: savedOrder.order_no, // 주문번호
                name: paymentData.content, // 주문명
                amount: parseInt(savedOrder.real_price), // 결제 금액
                buyer_email: memberData.email, // 구매자 이메일 
                buyer_name: memberData.name, // 구매자 이름 
                buyer_tel: memberData.phone, // 구매자 전화번호 
            }, function (rsp) {
                if (rsp.success) {
                    // 결제 성공 시, imp_uid와 order_no를 백엔드로 전송
                    fetch('/olympic/order/auth', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ 
                        	order_no: savedOrder.order_no, 
                        	imp_uid: rsp.imp_uid, 
                            paymentData: paymentData 
                        })
                    }).then(response => {
                        if (response.ok) {
                            alert('결제가 완료되었습니다.');
                            const encodedOrderNo = encodeURIComponent(savedOrder.order_no);
        					window.location.href = `/olympic/order/finish.do?order_no=${encodedOrderNo}`;
                        } else {
                            alert('UID 업데이트에 실패하였습니다.');
                            window.location.href = `/olympic/game/detail.do?game_id=${game_id}`;
                        }
                    }).catch(error => {
                        console.error('Error:', error);
                        alert('서버와 통신 중 오류가 발생하였습니다.');
                        window.location.href = `/olympic/game/detail.do?game_id=${game_id}`;
                    });
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                    window.location.href = `/olympic/game/detail.do?game_id=${game_id}`;
                }
            });
        } else {
            alert('주문 생성에 실패하였습니다.');
            window.location.href = `/olympic/game/detail.do?game_id=${game_id}`;
        }
    };

    button.addEventListener('click', onClickPay);
});
