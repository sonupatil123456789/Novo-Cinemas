part of 'privatebook_bloc.dart';

sealed class PrivatebookState extends Equatable {
  const PrivatebookState();
  
  @override
  List<Object> get props => [];
}

final class PrivatebookInitial extends PrivatebookState {}
