$(function () {
    $('.status').each(function () {
        console.log( $(this).attr('status') )
        if($(this).attr('status')!=0){
            $(this).next().children().remove()
        }
    })

    $('.alipay').click(function () {
        // 发起支付请求
        request_data = {
            'orderId': $(this).attr('orderId')
        }
        $.get('/pay/', request_data, function (response) {
            console.log(response)
            if (response.status == 1){
                window.open(response.alipayurl, target='_self')
            }
        })
    })
})