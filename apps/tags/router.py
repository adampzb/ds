from rest_framework_nested import routers

from apps.tags.views import (
    TagViewSet,
)

router = routers.SimpleRouter()

router.register(r'tags', TagViewSet)
