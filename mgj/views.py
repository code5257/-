import hashlib
import random
import time

from django.core.cache import cache
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from mgj.models import Productdetail, Goods, User, Cart, Order, Orderproduct


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
                cache.set(token, user.id,60*60*24*7)
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

#购物车

def shopping(request):
    res = {}
    token = request.session.get('token')
    userid = cache.get(token)
    # print(userid)
    if userid:
        user = User.objects.get(pk=userid)
        res['user'] = user
        carts = user.cart_set.filter(productnumber__gt=0)

        isall = True
        for cart in carts:
            if  not cart.isselect:
                isall = False
        res['isall'] = isall
        res['carts'] = carts

        return render(request,'shopping/shopping.html',context=res)
    else:
        return redirect('mgj:login')

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
    # print(request.GET.get('productid'))
    res = {}
    token = request.session.get('token')
    if token:
        userid = cache.get(token)
        if userid:
            user = User.objects.get(pk=userid)
            productid = request.GET.get('productid')
            productnumber = request.GET.get(('productnumber'))
            # print(productid,productnumber)
            product = Productdetail.objects.get(pk=productid)

            carts = Cart.objects.filter(user=user).filter(productdetail=product)
            #判断购物车里是否存在这件商品
            if carts.exists():
                cart = carts.first()
                cart.productnumber += productnumber
                cart.save()
            else:
                cart = Cart()
                cart.user = user
                cart.productdetail = product
                cart.productnumber = productnumber
                cart.save()

            res['status'] = 1
            res['msg'] = '已经登录'
            return JsonResponse(res)

    res['status'] = 0
    res['msg'] = '还未登录'

    return JsonResponse(res)


def changeselect(request):
    cartid = request.GET.get('cartid')
    # print('收到服务端数据',cartid)
    cart = Cart.objects.get(pk = cartid)
    cart.isselect = not cart.isselect
    cart.save()

    res = {'sttus':1,
           'msg':'选中状态已改变',
           'isselect':cart.isselect,
           }


    return JsonResponse(res)


def allselect(request):
    res={}
    isall = request.GET.get('isall')
    token = request.session.get('token')
    userid = cache.get(token)
    user = User.objects.get(pk=userid)
    carts = user.cart_set.all()
    if isall=='true':
        isall = True
    elif isall == 'false':
        isall = False

    for cart in carts:
        cart.isselect = isall
        cart.save()
    res['status'] = 1
    res['msg'] = '全选状态已改变'

    return JsonResponse(res)

#生成订单号的方法
def generate_orderid():
    temp = str( int(time.time())) + str(random.randrange(1000,10000))
    return temp

def generateorder(request):
    #首先获取用户身份
    token = request.session.get('token')
    userid = cache.get(token)
    print(userid)
    user = User.objects.get(pk=userid)

    # 获取用户对应购物车中被选中下单的商品
    carts = user.cart_set.filter(isselect=True)
    if carts.exists():
        #生成订单
        order = Order()
        order.user = user
        order.orderid = generate_orderid()
        print(order.orderid)
        order.save()


        for cart in carts:
            orderproduct = Orderproduct()
            orderproduct.order = order
            orderproduct.products = cart.productdetail
            orderproduct.number = cart.productnumber
            orderproduct.save()
            # 购物车中移除
            cart.delete()
    orders = user.order_set.all()
    sum = 0
    for order in orders:
        for orderGoods in  order.orderproduct_set.all():
            sum += orderGoods.products.price * orderGoods.number

    res = {
        'orders':orders,
        'sum':sum
        }


    return render(request,'order/orderdetail.html',context=res)


def orderlist(request):
    # 首先获取用户身份
    token = request.session.get('token')
    userid = cache.get(token)
    user = User.objects.get(pk=userid)

    orders = user.order_set.all()
    sum = 0
    for order in orders:
        for orderGoods in order.orderproduct_set.all():
            sum += orderGoods.products.price * orderGoods.number
    res = {
        'orders': orders,
        'sum': sum
    }

    return render(request, 'order/orderdetail.html', context=res)


# def orderdetail(request):
#
#     return render(request,'order/orderdetail.html')