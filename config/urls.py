from django.contrib import admin
from django.urls import path
from mydjangoin.views import Home

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', Home, name='home')
]
