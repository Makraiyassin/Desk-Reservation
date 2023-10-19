part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class CheckReservation extends HomeEvent {}

final class DeskChanged extends HomeEvent {
  const DeskChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
