// $(document).ready(function(){
// 	//页面跳转
// 	$(".home-fl").click(function(){
// 		window.location.href = "mainPage.html";
// 	});
// 	$(".show_register").click(function(){
// 		window.location.href = "register.html";
// 	});
// 	$(".show_login").click(function(){
// 		window.location.href = "login.html";
// 	});
// 	$(".nav-list li").eq(0).click(function(){
// 		window.location.href = "mainPage.html";
// 	})
// 	//显示隐藏
// 	$(".shoppingcar").mouseenter(function(){
// 		$(".empty_cart").show();
// 	})
// 	$(".shoppingcar").mouseleave(function(){
// 		$(".empty_cart").hide();
// 	})
// 	$(".customer_service").mouseenter(function(){
// 		$(".service_none").show();
// 	})
// 	$(".customer_service").mouseleave(function(){
// 		$(".service_none").hide();
// 	})
// 	$(".xiaodian").mouseover(function(){
// 		$(".myxiaodian").show();
// 	})
// 	$(".xiaodian").mouseout(function(){
// 		$(".myxiaodian").hide();
// 	})
// 	$(".user-info").mouseenter(function(){
// 		$(".shop_info").show();
// 		$(".shop_info").mouseenter(function(){
// 			$(".shop_info").show();
// 		})
// 	})
// 	$(".user-info").mouseleave(function(){
// 		$(".shop_info").hide();
// 	})
// 	$(".nav-list .all").mouseenter(function(){
// 		$(".sec_list").show();
// 		$(".sec_list").mouseenter(function(){
// 			$(".sec_list").show();
// 		})
// 		$(".sec_list").mouseleave(function(){
// 			$(".sec_list").hide();
// 		})
// 	})
// 	$(".nav-list .all").mouseleave(function(){
// 		$(".sec_list").hide();
// 	})
// 	//商品加减
// 	$(".minus").click(function(){
// 		var n = $(".countnum").val();
// 		if(n <= 1){
// 			return;
// 		}
// 		var num = parseInt(n)-1;
// 		$(".countnum").val(num);
// 	})
// 	$(".plus").click(function(){
// 		var n = $(".countnum").val();
// 		var i = $(".storenum").html();
// 		var stonum = parseInt(i);
// 		var num = parseInt(n)+1;
// 		if(num >= stonum){
// 			alert("所选商品数量大于库存数量");
// 			num = stonum;
// 		};
// 		$(".countnum").val(num);
// 	});
// 	//勾选
// 	$(".small-img li").css({borderColor:"#cfcfcf"});
// 	$(".small-img li").click(function(){
// 		$(this).css({borderColor:"red"}).siblings().css({borderColor:"#cfcfcf"});
// 	})
// 	$(".each-size li").css({background:"none"})
// 	$(".each-size li").click(function(){
// 		$(this).css({background:"url(detailsImg/gouxuan.png) 100% 100% no-repeat"}).siblings().css({background:"none"});
// 	})
// 	//先获取传入的title
// 	var myTitle = location.search.slice(1);
// 	$.get("json/productList.json",function(data){
// 		var obj = data;
// 		for(var i =0;i<obj.length;i++){
// 			if(obj[i].title == myTitle){
// 				$(".goodstitle span").append(obj[i].name);
// 				var img = $("<img>");
// 				img.attr("src",obj[i].img);
// 				$(".bigImg").append(img);
// 				$(".price-show .oldprice").append(obj[i].oldprice);
// 				$(".fl .price").append(obj[i].price)
// 				$(".salenum").append(obj[i].sales);
// 				$(".store .storenum").append(obj[i].store);
// 				//切换背景
// 				var bgimg = $("<img>");
// 				bgimg.attr("src",obj[i].beijing);
// 				$(".shopBanner").append(bgimg);
// 				var smallImg = $("<img>");
// 				smallImg.attr("src",obj[i].smallImg);
// 				var bigImg = $("<img class='bigimg'>");
// 				bigImg.attr("src",obj[i].img);
// 				$(".rebig").append(bigImg);
// 				//放大镜
// 				var smallImg = $(".bigImg")//小图
// 				var smallArea = $(".smallArea")//小区域
// 				var bigImg = $(".bigimg");//大图
// 				var bigArea = $(".rebig")//大区域
// 				//计算宽高
// 				//放大系数(放大倍数)
// 				var scale = bigImg.width() / smallImg.width();
// 				//console.log(scale)
// 				smallImg.mousemove(function(e){
// 					smallArea.show();
// 					bigArea.show();
// 					//移动小区域, 跟随鼠标移动
// 					var x = e.pageX - smallImg.offset().left - smallArea.width()/2;
// 					var y = e.pageY - smallImg.offset().top - smallArea.height()/2;
// 					//判断x不超出左边界,也不超出右边界
// 					if (x < 0) {
// 						x = 0;
// 					}
// 					else if (x > smallImg.width() - smallArea.width()) {
// 						x = smallImg.width() - smallArea.width();
// 					}
// 					//判断y不超出上边界,也不超出下边界
// 					if (y < 0) {
// 						y = 0;
// 					}
// 					else if (y > smallImg.height() - smallArea.height()) {
// 						y = smallImg.height() - smallArea.height();
// 					}
// 					smallArea.css({left: x, top: y});
// 					//移动大图
// 					bigImg.css({left: -x*scale, top: -y*scale});
// 				})
// 				//鼠标移出
// 				smallImg.mouseleave(function(){
// 					smallArea.hide(); //隐藏小区域
// 					bigArea.hide();
// 				})
// 			}
// 		}
// 	})
// 	//跳转到购物车
// 	$(".addtocart").click(function(){
// 		//将当前点击的商品加入购物车(使用cookie存储商品信息)
// 		var goodsId = myTitle //商品ID
// 		var goodsImg = $(".bigImg img").attr("src");
// 		var goodsName = $(".goodstitle span").html(); //商品名称
// 		var goodsPrice = $(".fl .price").html(); //商品价格
// 		var goodsList = $.cookie("cart") ? JSON.parse( $.cookie("cart") ) : [];
// 		var isExists = false; //表示是否存在相同商品
// 		for (var i=0; i<goodsList.length; i++) {
// 						//如果存在相同的商品, 则把数量++, 不需要重新添加新的商品
// 						if (goodsId == goodsList[i].id) {
// 							goodsList[i].num++;
// 							isExists = true; //表示存在相同商品
// 						}
// 					}
// 		//如果不存在相同商品, 则添加新商品
// 					if (!isExists) {
// 						//添加一个新商品到购物车
// 						var goods = {
// 							id: goodsId,
// 							name: goodsName,
// 							price: goodsPrice,
// 							Img:goodsImg,
// 							num: 1
// 						}
// 						goodsList.push(goods);
// 					}
// 					$.cookie("cart", JSON.stringify(goodsList), {expires:22, path:"/"});
// 					console.log( $.cookie("cart") );
// 	})
//
// 	$(".buynow").click(function(){
// 		window.location.href = "shopping.html";
// 	})

// })

$(function () {
		//显示隐藏
	$(".shoppingcar").mouseenter(function(){
		$(".empty_cart").show();
	})
	$(".shoppingcar").mouseleave(function(){
		$(".empty_cart").hide();
	})
	$(".customer_service").mouseenter(function(){
		$(".service_none").show();
	})
	$(".customer_service").mouseleave(function(){
		$(".service_none").hide();
	})
	$(".xiaodian").mouseover(function(){
		$(".myxiaodian").show();
	})
	$(".xiaodian").mouseout(function(){
		$(".myxiaodian").hide();
	})
	$(".user-info").mouseenter(function(){
		$(".shop_info").show();
		$(".shop_info").mouseenter(function(){
			$(".shop_info").show();
		})
	})
	$(".user-info").mouseleave(function(){
		$(".shop_info").hide();
	})
	$(".nav-list .all").mouseenter(function(){
		$(".sec_list").show();
		$(".sec_list").mouseenter(function(){
			$(".sec_list").show();
		})
		$(".sec_list").mouseleave(function(){
			$(".sec_list").hide();
		})
	})
	$(".nav-list .all").mouseleave(function(){
		$(".sec_list").hide();
	})

	// $('img').each(function () {
	// 	var path = $(this).attr('src')
	//
	// 	//{% static 'path'%}
	// 	var img_path = "{% static '" + path + "' %}"
	//
	// 	$(this).attr('src',img_path)
    // })
    // console.log('开始')
    // console.log($('body').html())
    // console.log(('结束'))
    //勾选
	$(".small-img li").css({borderColor:"#cfcfcf"});
	$(".small-img li").click(function(){
		$(this).css({borderColor:"red"}).siblings().css({borderColor:"#cfcfcf"});
	})
	$(".each-size li").css({background:"none"})
	$(".each-size li").click(function(){
		$(this).css({background:"url(../../static/detailsImg/gouxuan.png) 100% 100% no-repeat"}).siblings().css({background:"none"});
	})
    // 	//商品加减
	$(".minus").click(function(){
		// console.log(typeof ($(this).next().val()))
		// var inputnum_m = parseInt($(this).next().val()) - 1
		// // console.log(inputnum)
		// // console.log($('.store b').text())
		// var storenum_m = parseInt($('.store b').text())
		// if(inputnum_m>storenum_m){
		// 	$('.count .countnum').popover('show');
		// }else {
		// 	$('.count .countnum').popover('hide');
		// }
		$('.count .countnum').popover('hide');

		var n = $(".countnum").val();
		if(n <= 1){
			return;
		}
		var num = parseInt(n)-1;
		$(".countnum").val(num);
	})
	$(".plus").click(function(){
		// console.log($(this).prev().val())
		// console.log($('.store b').text())
		// var inputnum_p = parseInt($(this).prev().val())
		// var storenum_p = parseInt($('.store b').text())
		// console.log(inputnum_p,storenum_p)
		// if(inputnum_p>storenum_p){
		// 	$('.count .countnum').popover('show');
		// }else {
		// 	$('.count .countnum').popover('hide');
		// }

		var n = $(".countnum").val();
		var i = $(".storenum").html();
		var stonum = parseInt(i);
		var num = parseInt(n)+1;
		if(num >= stonum){
			// alert("所选商品数量大于库存数量");
			$('.count .countnum').popover('show');
			num = stonum;
		};
		$(".countnum").val(num);
	});


	//加入购物车
	$(".addtocart").click(function () {
		var $that = $(this)

		request_data = {
			'productid':$('.goodmain').	attr('productid'),
			'productnumber':$('.count input').val()
		}
		$.get(/addtocart/,request_data,function (response) {
			console.log(response)
			if (response.status == 0){
				//打开登录页面，并用cookie存参数，便于登陆后回到原页面而不是主页
				$.cookie('back','productDetail',{expires:3,path:'/'})
				$.cookie('productId',$('.goodmain').	attr('productid'),{expires: 3,path: '/'})

				window.open('/login/','_self')

			}else if (response.status == 1){
				alert('成功添加')
			}
		})

	})

	//为数量改变添加一个事件用来判断购买的东西，库存是否足够
    $('.count input').on('input propertychange',function(){
		// console.log($('.store b').text())
		var storenum_on = parseInt($('.store b').text())
    	if($(this).val()>storenum_on){
    		// console.log(1);
    		$('.count .countnum').popover('show');
    	}else{
    		$('.count .countnum').popover('hide');
    	}
    })


})