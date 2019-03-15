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