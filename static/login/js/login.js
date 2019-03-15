// $(document).ready(function(){
// 	//登录方式切换
// 	$(".loginpic").click(function(){
// 		$(".login-content").hide();
// 		$(".-hidden").show();
// 	});
// 	$(".tonormal").click(function(){
// 		$(".-hidden").hide();
// 		$(".login-content").show();
// 	});
// 	//页面跳转
// 	$(".header a img").click(function(){
// 		window.location.href = "mainPage.html";
// 	});
// 	$(".newUser").click(function(){
// 		window.location.href = "register.html";
// 	});
//
// 	$(".loginBtn").click(function(){
// 		//读取cookie
// 		var users = $.cookie("users")
// 		console.log(users);
// 		if(users){
// 			users = JSON.parse(users); //cookie中的所有注册过的用户
// 			//console.log(users);[Object, Object]
//  			var isExists = false; //表示是否存在该用户
//  			for(var i =0;i<users.length;i++){
//  				if(users[i].name == $(".login_name").val()&&users[i].pwd == $(".login_pwd").val()){
//  					alert("登录成功！");
// 					window.location.href = "mainPage.html"
//  					isExists = true;
//  				}
//  			}
//  			if(!isExists){
//  				console.log("用户名或密码错误, 请重新输入!")
//  			}
// 		}
// 		else{
// 			console.log("不存在用户, 请先注册!");
// 		}
// 	})
//
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






})