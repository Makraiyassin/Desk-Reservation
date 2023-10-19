import 'package:equatable/equatable.dart';
import 'package:ews_repository/ews_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_bloc.g.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  HomeBloc(this._ewsRepository) : super(HomeState()) {
    on<CheckReservation>(_checkReservation);
    on<DeskChanged>(_deskChanged);
  }

  final EWSRepository _ewsRepository;

  @override
  HomeState fromJson(JsonMap json) => HomeState.fromJson(json);

  @override
  JsonMap toJson(state) => state.toJson();

  void _checkReservation(
      CheckReservation event, Emitter<HomeState> emit) async {
    final reservedBy = await _ewsRepository.checkReservation(state.desk);

    emit(
      state.copyWith(reservedBy: reservedBy, status: HomeStatus.success),
    );
  }

  void _deskChanged(DeskChanged event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(desk: event.name, status: HomeStatus.choosing),
    );
  }

  // void _fetchMonthlyReward(
  //     FetchMonthlyReward event, Emitter<HomeState> emit) async {
  //   emit(state.copyWith(status: UpcomingMonthlyRewardHomeStatus.loading));

  //   try {
  //     final now = DateTime.now();
  //     final date = DateTime(now.year, now.month + 1, 1);
  //     final monthlyReward = await _drupalRepository.getMonthlyReward(date);

  //     emit(
  //       state.copyWith(
  //         status: UpcomingMonthlyRewardHomeStatus.success,
  //         monthlyReward: monthlyReward,
  //       ),
  //     );
  //   } on Exception {
  //     emit(state.copyWith(status: UpcomingMonthlyRewardHomeStatus.failure));
  //   }
  // }

  // void _refreshMonthlyReward(
  //     RefreshMonthlyReward event, Emitter<HomeState> emit) async {
  //   try {
  //     final now = DateTime.now();
  //     final date = DateTime(now.year, now.month + 1, 1);
  //     final monthlyReward = await _drupalRepository.getMonthlyReward(date);

  //     emit(
  //       state.copyWith(
  //         status: UpcomingMonthlyRewardHomeStatus.success,
  //         monthlyReward: monthlyReward,
  //       ),
  //     );
  //   } on Exception {
  //     emit(state);
  //   }
  // }

  // void _uninterestedChanged(
  //     UninterestedChanged event, Emitter<HomeState> emit) {
  //   emit(state.copyWith(uninterested: !state.uninterested, interested: false));
  // }
}
