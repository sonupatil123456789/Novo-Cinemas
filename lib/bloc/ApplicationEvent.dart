part of 'ApplicationBloc.dart';

sealed class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class SetLocalEvent extends ApplicationEvent {
  final Locale locale;
  const SetLocalEvent(this.locale);

  @override
  List<Object> get props => [locale];
}

class IsUserLogInEvent extends ApplicationEvent {
  const IsUserLogInEvent();

  @override
  List<Object> get props => [];
}

class SetIsUserLogInEvent extends ApplicationEvent {
  final bool isLogIn;
  const SetIsUserLogInEvent(this.isLogIn);

  @override
  List<Object> get props => [isLogIn];
}

class GetLocalUserDetailsEvent extends ApplicationEvent {
  const GetLocalUserDetailsEvent();

  @override
  List<Object> get props => [];
}





