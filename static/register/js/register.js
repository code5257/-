// $(document).ready(function(){
// 	//登录页面跳转
// 	$(".toLogin").click(function(){
// 		window.location.href = "login.html";
// 	});
// 	$(".header a img").click(function(){
// 		window.location.href = "mainPage.html";
// 	})
// 	var b1 = false;//用户名
// 	var b2 = false;
// 	var b3 = false;
// 	//用户名验证
// 	$(".name").blur(function(){
// 		var userName = $(".name").val();
// 		if(userName.length == ""){
// 			alert("用户名不能为空！");
// 			b1 = false;
// 			//用户名由 3-10位的字母下划线和数字组成。不能以数字或下划线开头。只能已字母开头。允许全部是字母
// 		}else if(!/^[a-zA-z][a-zA-Z0-9_]{2,9}$/.test(userName)){
// 			alert("用户名格式错误，请重新输入！");
// 			b1 = false;
// 		}
// 		else {
// 			b1 = true;
// 		}
// 	});
// 	//密码验证
// 	$(".pwd").blur(function(){
// 		var password = $(".pwd").val();
// 		if(password.length == ""){
// 			b2 = false;
// 			alert("密码不能为空！");
// 			//以字母开头，长度在6~18之间，只能包含字符、数字和下划线
// 		}else if(!/^[a-zA-Z]\w{5,17}$/.test(password)){
// 			b2 = false;
// 			alert("密码格式错误，请重新输入！");
// 		}else {
// 			b2 = true;
// 		}
// 	});
// 	//判断如果已经存在该用户
// 	$(".register").click(function(){
// 		if($(".checked").val() == $(".pwd").val()){
// 			alert("密码验证成功，请登录！");
// 			b3 = true;
// 			window.location.href = "login.html";
// 		}else{
// 			alert("两次输入的密码不一致！");
// 			b3 = false;
// 		}
// 		if (!(b1 && b2 && b3)) {
// 			alert("用户名或密码错误！");
// 			return;
// 		}
// 		var users = $.cookie("users") ? JSON.parse($.cookie("users")) : [];
// 		console.log(users);//空数组
// 		for(var i = 0;i<users.length;i++){
// 			if(users[i].name == $(".name").val()){
// 				console.log("用户名已存在! 不能注册相同的用户");
// 				return;
// 			}else{
// 				console.log("用户名注册成功！");
// 			}
// 		}
// 		//注册新用户
// 		var user = {
// 			name:$(".name").val(),
// 			pwd:$(".pwd").val(),
// 		};
// 		users.push(user);
// 		$.cookie("users", JSON.stringify(users), {expires:22, path:"/"});
// 		console.log($.cookie("users"));
// 	})
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


    // var b1 = false;//用户名
	// var b2 = false;
	// var b3 = false;
	// var b4 = false;
	//用户名验证
	$(".name").blur(function(){
	    $that = $('form b')


		var userName = $(".name").val();
		if(userName.length == ""){
			// alert("用户名不能为空！");
			$that.eq(0).html("用户名不能为空！").css('color','red')
			// b1 = false;
			//用户名由 3-10位的字母下划线和数字组成。不能以数字或下划线开头。只能已字母开头。允许全部是字母
		}else if(!/^[a-zA-z][a-zA-Z0-9_]{2,9}$/.test(userName)){
			// alert("用户名格式错误，请重新输入！");
			$that.eq(0).html("用户名格式错误，请重新输入！").css('color','red')
			// b1 = false;
		}
		else {

		    request_data ={
	        'username':$(this).val()
        }
	    $.get('../checkname/',request_data,function (response) {
	        if(!response.status) {
                // alert(response.msg);
                // console.log($(this).next())
                $that.eq(0).html(response.msg).css('color','red')
            }else {
	            $that.eq(0).html('')
	            // b4 = true
	            // console.log(response.msg)
            }
        })
			// b1 = true;
		}
	});
	//密码验证
	$(".pwd").blur(function(){
	    $that = $('form b')

		var password = $(".pwd").val();
		if(password.length == ""){
			// b2 = false;
			// alert("密码不能为空！");
			$that.eq(1).html("密码不能为空！").css('color','red')
			//以字母开头，长度在6~18之间，只能包含字符、数字和下划线
		}else if(!/^[a-zA-Z]\w{5,17}$/.test(password)){
			// b2 = false;
			// alert("密码格式错误，请重新输入！");
			$that.eq(1).html("密码格式错误，请重新输入！").css('color','red')
		}else {
		    $that.eq(1).html("")
			// b2 = true;
		}
	});
	//判断如果已经存在该用户
	$(".register").click(function() {
	    $that = $('form b')
        $imput = $('form input')
        if ($(".checked").val() == $(".pwd").val()) {   //两次输入的密码一样
            // alert("密码验证成功，请登录！");
            // b3 = true;
             $that.eq(2).html("")
            console.log('可以进行注册')
            $('.wrapper form').submit()

        } else {
            // alert("两次输入的密码不一致！");
            $imput.eq(2).val('')
            $that.eq(2).html("两次输入的密码不一致！").css('color','red')
            // b3 = false;
        }
        // if (!(b1 && b2 && b4)) {
        //     alert("用户名或密码错误！");
        //     return;
        // }
    })



})