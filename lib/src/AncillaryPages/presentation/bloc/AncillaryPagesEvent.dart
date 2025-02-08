part of 'AncillaryPagesBloc.dart';

sealed class AncillaryPagesEvent extends Equatable {
  const AncillaryPagesEvent();

  @override
  List<Object> get props => [];
}

class ExperiencesDataRequestEvent extends AncillaryPagesEvent {
  final String key;

  ExperiencesDataRequestEvent(this.key);

  @override
  List<Object> get props => [key];
}
