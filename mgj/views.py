import hashlib
import random
import time

from django.core.cache import cache
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from mgj.models import Productdetail, Goods, User


def mainPage(request):
    #首页需要渲染的商品
    goods = Goods.objects.all()
    products = Productdetail.objects.all()
    res = {
        'products': products,
        'goods':goods,
        'goods0' : goods[0],
        'goods1' : goods[1],
        'goods2' : goods[2],
        'goods3' : goods[3],
    }

    # 首先获取token 看是否已经登录
    res['user'] = None
    token = request.session.get('token')
    userid = cache.get(token)
    if userid:
        res['user'] = User.objects.get(pk=userid)

    return render(request,'mainPage/mainPage.html',context=res)


def productDetail(request,productid):
    res = {}
    token = request.session.get('token')
    userid = cache.get(token)
    res['user'] = None
    if userid:
        res['user'] = User.objects.get(pk=userid)


    product = Productdetail.objects.get(pk=productid)
    res['product'] = product

    return render(request,'productDetail/productDetail.html',context=res)


#密码加密
def generate_password(res):
    md5 = hashlib.md5()
    md5.update(res.encode('utf-8'))
    return md5.hexdigest()
#token 唯一标识
def generate_token():
    temp = str(time.time()) + str(random.random())
    md5 = hashlib.md5()
    md5.update(temp.encode('utf-8'))
    return md5.hexdigest()


def register(request):
    if request.method == 'GET': #请求登录界面

        return render(request,'register/register.html')
    elif request.method == 'POST':

        username = request.POST.get('username')
        password = generate_password( request.POST.get('password') )
        # print(username , password)

        user = User()
        user.username = username
        user.password = password
        user.save()
        #状态保持
        token = generate_token()
        cache.set(token,user.id,60*60*24*3)
        request.session['token'] = token


        return redirect('mgj:mainPage')


@csrf_exempt
def login(request):
    if request.method == 'GET':
        return render(request, 'login/login.html')
    elif request.method =='POST':
        username = request.POST.get('username')
        password = generate_password( request.POST.get('password') )
        # print(username,password)

        back = request.COOKIES.get('back')
        productId = request.COOKIES.get('productId')
        # print(back,productId)

        user = User.objects.filter(username=username).first()
        res = {'eero1':None,'eero2':None}
        if user:
            if password == user.password:

                #状态保持
                token = generate_token()
                cache.set(token, user.id,60*60*24*3)
                request.session['token'] = token

                #还可以为任何一个有登录的都不用a标签链接，用js点击事件都加back值
                if back == 'productDetail':

                    path = '../productDetail/' + productId
                    return redirect(path)
                else:
                    return redirect('mgj:mainPage')
            else:
                res['eero2'] = 1
                return render(request,'login/login.html',context=res)

        else:
            res['eero1'] = 1
            return render(request,'login/login.html',context=res)



def logout(request):
    request.session.flush()
    response = redirect('mgj:mainPage')
    response.delete_cookie('back')


    return response


def shopping(request):
    res = {}
    token = request.session.get('token')
    userid = cache.get(token)


    return render(request,'shopping/shopping.html')


def checkname(request):
    username = request.GET.get('username')
    # print('收到客服端ajax请求',username)

    user = User.objects.filter(username=username)
    if user.exists():
        response_data = {
            'status':0,
            'msg':'该用户名已被注册,请重新输入'
        }
    else:
        response_data = {
            'status':1,
            'msg':'用户名可用'
        }

    return JsonResponse(response_data)


def addtocart(request):
    print(request.GET.get('productid'))
    res = {}
    token = request.session.get('token')
    if token:
        userid = cache.get(token)
        if userid:
            res['status'] = 1
            res['msg'] = '已经登录'
            return JsonResponse(res)

    res['status'] = 0
    res['msg'] = '还未登录'

    return JsonResponse(res)