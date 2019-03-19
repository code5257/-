import hashlib
import random
import time
from urllib.parse import parse_qs

from django.core.cache import cache
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from mgj.alipay import alipay
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
                cart.productnumber += int(productnumber)
                cart.cartmoney = cart.productnumber*cart.productdetail.price
                cart.save()
            else:
                cart = Cart()
                cart.user = user
                cart.productdetail = product
                cart.productnumber = int(productnumber)
                cart.cartmoney = cart.productnumber*cart.productdetail.price
                cart.save()

            res['status'] = 1
            res['msg'] = '已经登录'
            return JsonResponse(res)

    res['status'] = 0
    res['msg'] = '还未登录'

    return JsonResponse(res)


def removecart(request):
    cartid = request.GET.get('cartid')
    token = request.session.get('token')
    userid = cache.get(token)
    user = User.objects.get(pk=userid)
    # print(cartid)
    cart = user.cart_set.get(pk=cartid)
    cart.delete()

    res={
        'status':1,
        'smg':'成功移除此商品',
    }

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
    # (userid)

    user = User.objects.get(pk=userid)
    # 获取用户对应购物车中被选中下单的商品
    carts = user.cart_set.filter(isselect=True)

    #生成订单
    order = Order()
    order.user = user
    order.orderid = generate_orderid()
    # print(order.orderid)
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
        # print(sum)
        order.ordermoney = sum
        order.save()
        sum = 0

    res = {
        'orders':orders,
        # 'sum':sum
        }

    return render(request,'order/orderdetail.html',context=res)

# 直接购买，直接下单，跳过加购物车下单步骤
def grtorder(request,productid):
    # 首先获取用户身份
    token = request.session.get('token')
    userid = cache.get(token)
    # print(userid)
    user = User.objects.get(pk=userid)
    # 生成订单
    order = Order()
    order.user = user
    order.orderid = generate_orderid()
    # print(order.orderid)
    order.save()

    orderproduct = Orderproduct()
    orderproduct.order = order
    # print(Productdetail.objects.get(pk=productid))
    orderproduct.products =Productdetail.objects.get(pk=productid)
    orderproduct.number = 1
    orderproduct.save()



    orders = user.order_set.all()
    sum = 0
    for order in orders:
        for orderGoods in  order.orderproduct_set.all():
            sum += orderGoods.products.price * orderGoods.number
        # print(sum)
        orderid = order.id
        # print(sum)
        # print(orderid)
        # orders.filter(orderid=orderid).update(ordermoney=sum)
        order = Order.objects.get(pk=orderid)
        order.ordermoney =  sum

        # print(order)
        order.save()
        sum = 0
    orders1 = user.order_set.all()
    res = {
        'orders': orders1,
        # 'sum':sum
    }
    return render(request,'order/orderdetail.html',context=res)





#我的订单
def orderlist(request):
    # 首先获取用户身份
    token = request.session.get('token')
    userid = cache.get(token)
    if userid:
        user = User.objects.get(pk=userid)

        orders = user.order_set.all()
        sum = 0
        for order in orders:
            for orderGoods in order.orderproduct_set.all():
                sum += orderGoods.products.price * orderGoods.number
            order.ordermoney = sum
            # print(sum)
            order.save()
            sum = 0

        res = {
            'orders': orders,
            # 'sum': sum
        }

        return render(request, 'order/orderdetail.html', context=res)
    return redirect('mgj:login')

# def orderdetail(request):
#
#     return render(request,'order/orderdetail.html')


#
# def randomtest(request):
#     return None


def returnurl(request):
    return redirect('mgj:orderlist')

@csrf_exempt
def appnotifyurl(request):
    if request.method == 'POST':
        # 获取到参数
        body_str = request.body.decode('utf-8')

        # 通过parse_qs函数
        post_data = parse_qs(body_str)

        # 转换为字典
        post_dic = {}
        for k,v in post_data.items():
            post_dic[k] = v[0]

        # 获取订单号
        out_trade_no = post_dic['out_trade_no']

        # 更新状态
        Order.objects.filter(orderid=out_trade_no).update(status=1)


    return JsonResponse({'msg':'success'})



def pay(request):
    # print(request.GET.get('orderid'))

    orderId = request.GET.get('orderId')
    order = Order.objects.get(pk=orderId)
    sum = order.ordermoney
    # sum = 0
    # for orderGoods in order.ordergoods_set.all():
    #     sum += orderGoods.goods.price * orderGoods.number

    # 支付地址信息
    data = alipay.direct_pay(
        subject='MackBookPro [256G 8G 灰色]',  # 显示标题
        out_trade_no=order.orderid,  # 爱鲜蜂 订单号
        total_amount=str(sum),  # 支付金额
        return_url='http://39.96.66.69/returnurl/'
    )

    # 支付地址
    alipay_url = 'https://openapi.alipaydev.com/gateway.do?{data}'.format(data=data)

    response_data = {
        'msg': '调用支付接口',
        'alipayurl': alipay_url,
        'status': 1
    }

    return JsonResponse(response_data)

