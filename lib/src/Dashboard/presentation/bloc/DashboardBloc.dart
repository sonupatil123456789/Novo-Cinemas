

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/useCases/GetReservationDetailsUseCase.dart';
part 'DashboardEvent.dart';
part 'DashboardState.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  // final GetReservationDetailsUseCase getReservationDetailsUseCase;

  DashboardBloc(): super(const DashboardState()) {
    // on<SetSettingsChanged>(_setSettingsChanged);
  }

  // _setSettingsChanged(SetSettingsChanged event,Emitter<UserProfileState> emit)  {
  //   emit(state.copyWith(selectedSetting: event.settings));
  // }



  // _getReservationDetailsEvent(GetReservationDetailsEvent event,Emitter<TicketState> emit) async {
  //   emit(state.copyWith(loading: CurrentAppState.LOADING));
  //   final reservationData = await getReservationDetailsUseCase.call(event.reservationId);
  //
  //   switch (reservationData) {
  //
  //     case Success<ReservationDetailsModel>():
  //       emit(state.copyWith(loading: CurrentAppState.SUCCESS,reservationDetails:reservationData.data ));
  //     case Error<ReservationDetailsModel>():
  //       emit(state.copyWith(loading: CurrentAppState.ERROR,appException: reservationData.exception));
  //   }
  //   print(state.reservationDetails);
  // }
}

