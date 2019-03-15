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
]