// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Event',
      json,
      ($checkedConvert) {
        final val = Event(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          description: $checkedConvert(
            'description',
            (v) => v as String?,
            readValue: Event._description,
          ),
          startDate: $checkedConvert('field_start_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
          endDate: $checkedConvert('field_end_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'startDate': 'field_start_date',
        'endDate': 'field_end_date'
      },
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'field_start_date': instance.startDate?.toIso8601String(),
      'field_end_date': instance.endDate?.toIso8601String(),
    };
