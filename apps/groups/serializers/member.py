from rest_framework import serializers
from apps.core.serializers import ModelReadOnlySerializer
from apps.groups.models import GroupMember
from apps.groups.serializers import GroupReadOnlyLightSerializer
from apps.profiles.serializers import UserReadOnlySerializer


class GroupMemberReadOnlySerializer(ModelReadOnlySerializer):
    group = GroupReadOnlyLightSerializer()

    class Meta:
        model = GroupMember
        fields = ('id', 'group', 'user', 'member_type', 'status')


class GroupMemberSerializer(serializers.ModelSerializer):
    group = GroupReadOnlyLightSerializer()
    user = UserReadOnlySerializer()
    
    class Meta:
        model = GroupMember
        fields = ('id', 'group', 'user', 'member_type', 'status')
