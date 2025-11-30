from django.urls import include, path

from apps.tags.router import router

urlpatterns = [
    path('api/v1/', include(router.urls)),
]
