

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/useCases/GetReservationDetailsUseCase.dart';
part 'TicketEvent.dart';
part 'TicketState.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {

  final GetReservationDetailsUseCase getReservationDetailsUseCase;

  TicketBloc(this.getReservationDetailsUseCase): super(const TicketState()) {
    on<GetReservationDetailsEvent>(_getReservationDetailsEvent);
  }

  _getReservationDetailsEvent(GetReservationDetailsEvent event,Emitter<TicketState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final reservationData = await getReservationDetailsUseCase.call(event.reservationId);

    switch (reservationData) {
      case Success<ReservationDetailsModel>():
        emit(state.copyWith(loading: CurrentAppState.SUCCESS,reservationDetails:reservationData.data ));
      case Error<ReservationDetailsModel>():
        emit(state.copyWith(loading: CurrentAppState.ERROR,appException: reservationData.exception));
    }
  }
}

