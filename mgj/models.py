from django.db import models

class Goods(models.Model):
    img = models.CharField(max_length=100)
    title = models.CharField(max_length=100)
    decription = models.CharField(max_length=100)


class Productdetail(models.Model):
    img = models.CharField(max_length=100)
    smallImg = models.CharField(max_length=100)
    name = models.CharField(max_length=100)
    price = models.FloatField()
    status = models.CharField(max_length=20,default='')
    sales = models.CharField(max_length=100)
    oldprice = models.FloatField()
    store = models.IntegerField()
    background = models.CharField(max_length=100)
    type = models.CharField(max_length=100,default='')


class User(models.Model):
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)


class Cart(models.Model):
    user = models.ForeignKey(User)

    productdetail = models.ForeignKey(Productdetail)

    productnumber = models.IntegerField()

    # 是否选中(用于下单时候)
    isselect = models.BooleanField(default=True)
    # 是否删除(用于下单后，购物车中删除)
    isdelete = models.BooleanField(default=False)

#订单 对应哪个用户(user)和订单商品(orderproduct)
class Order(models.Model):
    user = models.ForeignKey(User)

    #创建时间
    createtime = models.DateTimeField(auto_now_add=True)
    #更新时间
    updatetime = models.DateTimeField(auto_now=True)
    #订单状态 默认为0 未支付状态
    status = models.IntegerField(default=0)
    #订单号
    orderid = models.CharField(max_length=256)
    # #订单金额
    # ordermoney = models.IntegerField()

#对应订单(order)和商品(productdetail)
class Orderproduct(models.Model):
    # 订单
    order = models.ForeignKey(Order)
    # 商品
    products = models.ForeignKey(Productdetail)

    ## 商品数量
    number = models.IntegerField()
    #此订单数额