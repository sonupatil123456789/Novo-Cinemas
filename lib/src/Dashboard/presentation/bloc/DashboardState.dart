part of 'DashboardBloc.dart';

class DashboardState extends Equatable {
  final CurrentAppState loading;
  final AppException? appException;


  const DashboardState(
      {
      this.loading = CurrentAppState.INITIAL,
      this.appException});

  DashboardState copyWith(
      {AppException? appException,
      CurrentAppState? loading}) {
    return DashboardState(
        appException: appException ?? this.appException,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props =>
      [loading, appException, ];
}
