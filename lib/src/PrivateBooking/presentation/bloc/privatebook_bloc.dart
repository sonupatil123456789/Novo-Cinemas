import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'privatebook_event.dart';
part 'privatebook_state.dart';

class PrivatebookBloc extends Bloc<PrivatebookEvent, PrivatebookState> {
  PrivatebookBloc() : super(PrivatebookInitial()) {
    on<PrivatebookEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
