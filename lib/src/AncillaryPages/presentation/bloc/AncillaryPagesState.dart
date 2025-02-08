part of 'AncillaryPagesBloc.dart';

class AncillaryPagesState extends Equatable {
  final CurrentAppState loading;
  final AppException? appException;
  final AncillaryPagesModel? experiencesData;

  const AncillaryPagesState(
      {this.loading = CurrentAppState.INITIAL,
      this.appException,
      this.experiencesData});

  AncillaryPagesState copyWith({
    CurrentAppState? loading,
    AppException? appException,
    AncillaryPagesModel? experiencesData,
  }) {
    return AncillaryPagesState(
      appException: appException ?? this.appException,
      loading: loading ?? this.loading,
      experiencesData: experiencesData ?? this.experiencesData,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        appException,
        experiencesData,
      ];
}
