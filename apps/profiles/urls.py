from django.urls import path, include, re_path
from apps.profiles.router import router
from apps.profiles.views import IsAuthenticatedView


urlpatterns = [
    path('api/v1/', include(router.urls)),

    re_path(r'^api/v1/is_authenticated/$',
        IsAuthenticatedView.as_view(),
        name='is_authenticated'),
]
