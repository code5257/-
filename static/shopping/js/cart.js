// $(document).ready(function(){
// 	//页面跳转
// 	$(".header-con .home-fl").click(function(){
// 		window.location.href = "mainPage.html";
// 	});
// 	$(".show_register a").click(function(){
// 		window.location.href = "register.html";
// 	});
// 	$(".show_login").click(function(){
// 		window.location.href = "login.html";
// 	});
// 	//二级菜单
// 	$(".shoppingcar").mouseenter(function(){
// 		$(".empty_cart").show()
// 		$(".empty_cart").mouseenter(function(){
// 			$(this).show();
// 		});
// 		$(".empty_cart").mouseleave(function(){
// 			$(this).hide();
// 		})
// 	});
// 	$(".shoppingcar").mouseleave(function(){
// 		$(".empty_cart").hide()
// 	})
//
// 	$(".customer_service").mouseenter(function(){
// 		$(".service_none").show()
// 		$(".service_none").mouseenter(function(){
// 			$(this).show();
// 		});
// 		$(".service_none").mouseleave(function(){
// 			$(this).hide();
// 		})
// 	});
// 	$(".customer_service").mouseleave(function(){
// 		$(".empty_cart").hide()
// 	})
//
// 	$(".xiaodian").mouseenter(function(){
// 		$(".myxiaodian").show()
// 		$(".myxiaodian").mouseenter(function(){
// 			$(this).show();
// 		});
// 		$(".myxiaodian").mouseleave(function(){
// 			$(this).hide();
// 		})
// 	});
// 	$(".xiaodian").mouseleave(function(){
// 		$(".empty_cart").hide()
// 	})
// 	//初始化隐藏
// 	$(".cartEmpty").hide();
// 	//获取cookie
// 	var goodsList = $.cookie("cart");
// 	if(goodsList){
// 		goodsList = JSON.parse(goodsList);
// 		//console.log(goodsList)一个对象
// 		for(var i = 0;i<goodsList.length;i++){
// 			var goods = goodsList[i]//每个商品
// 			//创建节点
// 			var img = $("<img>");
// 			img.attr("src",goods.Img);
// 			var pictd = $("<td class='propic'></td>");
// 			img.appendTo(pictd);
// 			var nametd = $("<td class='name'>" + goods.name + "</td>");
// 			var pricetd = $("<td class='price'>" + goods.price + "</td>")
// 			var numtd = $("<td class='num'>" + goods.num + "</td>")
// 			var del = $("<td class='del'>删除</td>");
// 			var tr = $("<tr id="+goods.id+"></tr>");
// 			tr.append(pictd,nametd,pricetd,numtd,del)
// 			$(".data-con").append(tr);
// 			$(".empty_cart").append(tr.clone(true));
// 		}
// 		$(".del").click(function(){
// 			var trID = $(this).parent().attr("id");
// 			console.log(trID);
// 			for(var i = 0;i<goodsList.length;i++){
// 				if(trID==goodsList[i].id) {
// 					console.log(0000);
// 					goodsList.splice(i,1);
// 					$(this).parent().remove()
// 					$.cookie("cart", JSON.stringify(goodsList), {expires:22, path:"/"})
// 				}
// 			}
// 		})
//
// 		$(".deleteall").click(function(){
// 			$(".data-con").remove();
// 			$.cookie("cart", JSON.stringify(goodsList), {expires:0, path:"/"})
// 		})
//
// 		console.log($.cookie("cart"));
// 	}
// })

$(function () {
	//     $('img').each(function () {
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

    //一开始就计算金额
    $('#oneselect input').each(function () {
        var price1 = $(this).parent().nextAll('.goodprice').attr('goodprice')
        var number1 = $(this).parent().nextAll('.goodnum').attr('productnumber')
        var sum1 = price1 * number1
        $(this).parent().nextAll('.goodssum').html(sum1)

    })




    //为每件商品选中和取消选中加点击事件
    $('#oneselect input').click(function () {
        request_data = {
            'cartid':$(this).attr('cartid')
        }
        // console.log('点击啦')
        var $that = $(this)
        $.get('/changeselect/',request_data,function (response) {
            // console.log(response)
            if( !response.isselect){
                $('#allselect').prop('checked',false)
            }
        })
        var bo = true
        $('#oneselect input').each(function () {
            // console.log($(this).attr('checked'))
            if($(this).attr('checked') != 'checked'){
                bo = false
            }
        })
        //全选
        if (bo){
            $('#allselect').prop('checked',bo)
            $('#allselect').attr('selectall',bo)
        }else {
            $('#allselect').prop('checked',bo)
            $('#allselect').attr('selectall',bo)
        }
        money()
    })

    //控制没选中时不能下单
    // console.log($(".cartEmpty .deleteall"))
    // $(".cartEmpty .deleteall").attr();


    //初始化全选
    var initall =  $('#allselect').attr('selectall')
    if(initall){
            $('#allselect').prop('checked',true)
            $('#allselect').attr('selectall',initall)
        }else{
            $('#allselect').prop('checked',false)
            $('#allselect').attr('selectall',initall)
        }
        money()

    //为全选添加一个点击事件
    $('#allselect').click(function () {
        var isall = $(this).attr('selectall')

        isall = (isall == 'false')? true:false

        // 改变模板中selectall的值
        $(this).attr('selectall', isall)

        // console.log(isall)
        if(isall){
            $(this).prop('checked',true)
        }else{
            $(this).prop('checked',false)
        }
        var $that = $(this)
        request_data = {
            'isall':isall
        }
        $.get('/allselect/',request_data,function (response) {
            // console.log(response)
            if (response.status == 1){
                $('#oneselect input').each(function () {
                    if(isall){
                        $(this).prop('checked',true)
                        // console.log(11)
                    }else {
                        // console.log(22)
                        $(this).prop('checked',false)
                    }
                    money()
                })
            }

        })



    })


    //封装一个计算价钱的函数
    function money(){
        var sum = 0

        $('#oneselect input').each(function () {
            if ($(this).prop('checked')){
                // console.log($(this).parent().nextAll('.goodprice').attr('goodprice'))
                var price = $(this).parent().nextAll('.goodprice').attr('goodprice')
                // console.log($(this).parent().nextAll('.goodnum').attr('productnumber'))
                var number = $(this).parent().nextAll('.goodnum').attr('productnumber')
                sum += number * price
            }
        })

        // 显示
        $('.cartEmpty b').html('￥金额：'+sum)
    }


})