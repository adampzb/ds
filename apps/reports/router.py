from rest_framework_nested import routers

from apps.reports.views import ReportTypeViewSet

router = routers.SimpleRouter()

router.register('report_types', ReportTypeViewSet)
