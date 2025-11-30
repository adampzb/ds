from apps.posts.views import PostViewSet, PostSelfViewSet
from rest_framework_nested import routers
from apps.bookmarks.views import PostBookmarkViewSet
from apps.comments.views import PostCommentViewSet
from apps.followers.views import PostFollowerViewSet
from apps.reports.views import PostReportViewSet

router = routers.SimpleRouter()
router.register(r'posts', PostViewSet)
router.register(r'post/self', PostSelfViewSet, basename='post-self')

post_router = routers.NestedSimpleRouter(
    router, r'posts', lookup='post'
)
post_router.register(r'comments', PostCommentViewSet)
post_router.register(r'bookmarks', PostBookmarkViewSet)
post_router.register(r'reports', PostReportViewSet)
post_router.register(r'followers', PostFollowerViewSet)
