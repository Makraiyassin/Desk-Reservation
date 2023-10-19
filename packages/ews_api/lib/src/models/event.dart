import 'package:ews_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  const Event({
    required this.id,
    required this.title,
    this.description,
    this.startDate,
    this.endDate,
  });

  final String id;
  final String title;
  @JsonKey(readValue: _description)
  final String? description;
  @JsonKey(name: 'field_start_date')
  final DateTime? startDate;
  @JsonKey(name: 'field_end_date')
  final DateTime? endDate;

  static _description(Map map, _) => map['body']?['value'];

  Event copyWith({
    final String? id,
    final String? title,
    final String? description,
    final DateTime? startDate,
    final DateTime? endDate,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object> get props => [id, title];

  factory Event.fromJson(JsonMap json) => _$EventFromJson(json);

  JsonMap toJson() => _$EventToJson(this);
}
