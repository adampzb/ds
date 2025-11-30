from rest_framework import serializers
from apps.core.serializers import ModelReadOnlySerializer
from apps.groups.models import GroupRule


class GroupRuleReadOnlySerializer(ModelReadOnlySerializer):
    class Meta:
        model = GroupRule
        fields = ('id', 'group', 'title', 'rule_type', 'description')


class GroupRuleSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupRule
        fields = ('id', 'group', 'title', 'rule_type', 'description')
