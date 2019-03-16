from django.conf.urls import url

from mgj import views

urlpatterns = [
    url(r'^$',views.mainPage,name='mainPage'),
    # url(r'^productDetail/$',views.productDetail,name='backproductDetail'),
    url(r'^productDetail/(\d+)/$',views.productDetail,name='productDetail'),

    url(r'^register/$',views.register,name='register'),
    url(r'^checkname/$',views.checkname,name='checkname'),#ajax请求路由，用来验证用户名
    url(r'^login/$',views.login,name='login'),
    url(r'^logout/$',views.logout,name='logout'),

    url(r'^shopping/$',views.shopping,name='shopping'),
    url(r'^addtocart/$',views.addtocart,name='addtocart'),#ajax请求添加购物车
    #ajax请求来控制选择和数据库中的选中状态的同步
    url(r'^changeselect/$',views.changeselect,name='changeselect'),
    url(r'^allselect/$',views.allselect,name='allselect'),

    #下单到订单详情以及订单列表
    url(r'^generateorder/$',views.generateorder,name='generateorder'),
    url(r'^orderlist/$',views.orderlist,name='orderlist'),#订单列表
    # url(r'^orderdetail/$',views.orderdetail,name='orderdetail'),#订单详情
]