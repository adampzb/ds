from django.shortcuts import render
from .models import Tag
from apps.core.views import BaseViewSet
from apps.tags.serializers import TagSerializer
from .filters import TagFilterSet


class TagViewSet(BaseViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    filterset_class = TagFilterSet
    ordering = ['-created_at']
