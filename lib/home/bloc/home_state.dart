part of 'home_bloc.dart';

enum HomeStatus { choosing, success }

extension HomeStatusX on HomeStatus {
  bool get isChoosing => this == HomeStatus.choosing;
  bool get isSuccess => this == HomeStatus.success;
}

@JsonSerializable()
final class HomeState extends Equatable {
  HomeState({
    this.status = HomeStatus.choosing,
    this.desks = const [
      'Flex Desk 3.01',
      'Flex Desk 3.02',
      'Flex Desk 3.03',
      'Flex Desk 3.04',
      'Flex Desk 4.01',
      'Flex Desk 4.02',
      'Flex Desk 4.03',
      'Flex Desk 4.04',
    ],
    String? desk,
    this.reservedBy,
  }) : desk = desk ?? desks.first;

  final HomeStatus status;
  final List<String> desks;
  final String desk;
  final String? reservedBy;

  factory HomeState.fromJson(JsonMap json) => _$HomeStateFromJson(json);

  JsonMap toJson() => _$HomeStateToJson(this);

  HomeState copyWith({
    HomeStatus? status,
    List<String>? desks,
    String? desk,
    String? reservedBy,
    bool? checkedReservation,
  }) {
    return HomeState(
      status: status ?? this.status,
      desks: desks ?? this.desks,
      desk: desk ?? this.desk,
      reservedBy: reservedBy ?? this.reservedBy,
    );
  }

  @override
  List<Object?> get props => [status, desks, desk];
}
