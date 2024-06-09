document.addEventListener("DOMContentLoaded", function() {
	IMP.init(IMP_KEY);
    const button = document.getElementById('payButton');

    const onClickPay = async () => {
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
        const total_price = document.getElementById('hidden_total_price').value;
        const game_id = document.getElementById('hidden_game_id').value;
        const item_no = document.getElementById('hidden_item_no').value;
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
            content: content
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

            // 결제 요청
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
                            window.location.href = '/olympic/order/finish.do';
                        } else {
                            alert('UID 업데이트에 실패하였습니다.');
                        }
                    }).catch(error => {
                        console.error('Error:', error);
                        alert('서버와 통신 중 오류가 발생하였습니다.');
                    });
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        } else {
            alert('주문 생성에 실패하였습니다.');
        }
    };

    button.addEventListener('click', onClickPay);
});
