// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HomeState',
      json,
      ($checkedConvert) {
        final val = HomeState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$HomeStatusEnumMap, v) ??
                  HomeStatus.choosing),
          desk: $checkedConvert('desk', (v) => v as String? ?? ''),
          reservedBy: $checkedConvert('reserved_by', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'reservedBy': 'reserved_by'},
    );

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
      'status': _$HomeStatusEnumMap[instance.status]!,
      'desk': instance.desk,
      'reserved_by': instance.reservedBy,
    };

const _$HomeStatusEnumMap = {
  HomeStatus.choosing: 'choosing',
  HomeStatus.success: 'success',
};
