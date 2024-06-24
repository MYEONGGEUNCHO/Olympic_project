$(function() {
    function initializeCarousel(tickets, game, sport) {
        let carouselInner = $("#ticketCarousel .carousel-inner");
        carouselInner.empty();
        
        $.each(tickets, function(index, ticket) {
            let activeClass = index === 0 ? ' active' : '';
            let seatInfo = convertSeatInfo(ticket.seat_info);
            let countryMatch = (!(game.country1_name==='' && game.country2_name==='')) ? 
                               `${game.country1_name} vs ${game.country2_name}` : 
                               '국가 대진 정보 없음';
            let slide = `
                <div class="carousel-item${activeClass}">
                    <div class="d-block w-100 p-3">
                        <img src="${sport.title_image}" alt="Title Image" class="img-fluid">
                        <h5 style="font-size: 1.5em;">${game.sport_name} - ${game.tournament}</h5>
                        <h5>${countryMatch}</h5>
                        <p>경기장: ${game.stadium_name}</p>
                        <p>티켓 번호: ${ticket.ticket_no}</p>
                        <p>가격: ${ticket.price}원</p>
                        <p>좌석 정보: ${seatInfo}</p>
                    </div>
                </div>
            `;
            carouselInner.append(slide);
        });

        // Bootstrap Carousel Initialization
        $('#ticketCarousel').carousel({
            interval: 3000
        });
    }
    
    function convertSeatInfo(seat) {
        switch (seat) {
            case 'a_seat': return 'A좌석';
            case 'b_seat': return 'B좌석';
            case 'c_seat': return 'C좌석';
            case 'd_seat': return 'D좌석';
            case 'vip_seat': return 'VIP좌석';
            default: return seat;
        }
    }

    $(document).on("click", ".showTicket", function() {
        var orderNo = $(this).data('order-no');
        console.log("Order No: " + orderNo);

        $.ajax({
            url: '/olympic/order/getTicketDetails',
            type: 'GET',
            data: { order_no: orderNo },
            success: function(data) {
                console.log("돌려받은 데이터 : ", data);
                if (data && data.tickets && data.tickets.length > 0) {
                    initializeCarousel(data.tickets, data.game, data.sport);
                } else {
                    console.log("해당 주문건의 티켓이 없습니다. " + orderNo);
                    $("#ticketCarousel .carousel-inner").html(`
                        <div class="carousel-item active">
                            <div class="d-block w-100 p-3">
                                <h5>티켓 정보 없음</h5>
                                <p>해당 주문에 대한 티켓 정보를 찾을 수 없습니다.</p>
                            </div>
                        </div>
                    `);
                }
                $('#ticketModal').modal('show');
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX request failed: ", textStatus, errorThrown);
            }
        });
    });
});
