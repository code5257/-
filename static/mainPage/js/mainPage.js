$(function () {

    // $('img').each(function () {
    //     var path = $(this).attr('src')
    //
    //     //{% static 'path'%}
    //     var img_path = "{% static '" + path + "' %}"
    //
    //     $(this).attr('src',img_path)
    // })
    // console.log('开始')
    // console.log($('body').html())
    // console.log(('结束'))

    //轮播图
    var swiper = new Swiper('.swiper-container', {
        // pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        paginationClickable: true,
        spaceBetween: 30,
        centeredSlides: true,
        autoplay: 2500,
        autoplayDisableOnInteraction: false
    });

})