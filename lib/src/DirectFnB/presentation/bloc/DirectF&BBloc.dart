

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/UseCase.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/useCases/GetAllUpcomingBookingsUseCase.dart';
import '../../domain/useCases/GetUpcomingBookingsDetailsUseCase.dart';
part 'DirectF&BEvent.dart';
part 'DirectF&BState.dart';

class DirectFAndBBloc extends Bloc<DirectFAndBEvent, DirectFAndBState> {

  final GetAllUpcomingBookingsUseCase getAllUpcomingBookingsUseCase;
  final GetUpcomingBookingsDetailsUseCase getUpcomingBookingsDetailsUseCase;

  DirectFAndBBloc(this.getAllUpcomingBookingsUseCase,this.getUpcomingBookingsDetailsUseCase): super(const DirectFAndBState()) {
    on<OnBookingIdChanged>(_onBookingIdChanged);
    on<GetAllUpcomingBookingsEvent>(_getAllUpcomingBookingsEvent);
    on<GetUpcomingBookingsDetailsEvent>(_getUpcomingBookingsDetailsEvent);
    on<SelectedUpcomingBooking>(_selectedUpcomingBooking);
    on<SelectedCinemaLocation>(_selectedCinemaLocation);
    on<OnBookingIdError>(_onBookingIdError);
  }

  _selectedUpcomingBooking(SelectedUpcomingBooking event,Emitter<DirectFAndBState> emit)  {
    emit(state.copyWith(selectedReservationDetail: event.upcomingBooking, bookingId:event.upcomingBooking.vistaBookingId ));
    event.callback();
    Logger.customLogData('Selected Booking Detail', event.upcomingBooking);
  }

  _selectedCinemaLocation(SelectedCinemaLocation event,Emitter<DirectFAndBState> emit)  {
    emit(state.copyWith(selectedCinemaLocation: event.cinemaLocation));
    // Logger.customLogData('Selected Booking Detail', event.upcomingBooking);
  }


  _onBookingIdChanged(OnBookingIdChanged event,Emitter<DirectFAndBState> emit)  {
    emit(state.copyWith(bookingId: event.bookingId));
  }

  _onBookingIdError(OnBookingIdError event,Emitter<DirectFAndBState> emit)  {
    emit(state.copyWith(bookingIDError: event.errorMessage));
  }

  _getAllUpcomingBookingsEvent(GetAllUpcomingBookingsEvent event,Emitter<DirectFAndBState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final upcomingBookingData = await getAllUpcomingBookingsUseCase.call(EmptyParams());

    switch (upcomingBookingData) {
      case Success<List<ReservationDetailsModel>>():
        emit(state.copyWith(loading: CurrentAppState.SUCCESS,upcomingBookings:upcomingBookingData.data ));
      case Error<List<ReservationDetailsModel>>():
        emit(state.copyWith(loading: CurrentAppState.ERROR,appException: upcomingBookingData.exception));
    }
  }


  _getUpcomingBookingsDetailsEvent(GetUpcomingBookingsDetailsEvent event,Emitter<DirectFAndBState> emit) async {
    emit(state.copyWith(upcomingBookingDetailsState: CurrentAppState.LOADING));
    final upcomingBookingData = await getUpcomingBookingsDetailsUseCase.call(state.bookingId ?? '');

    switch (upcomingBookingData) {
      case Success<ReservationDetailsModel>():
        emit(state.copyWith(upcomingBookingDetailsState: CurrentAppState.SUCCESS, selectedReservationDetail:upcomingBookingData.data ));
        event.onSuccess(upcomingBookingData.data);
      case Error<ReservationDetailsModel>():
        emit(state.copyWith(upcomingBookingDetailsState: CurrentAppState.ERROR,appException: upcomingBookingData.exception));
        event.onFailure(upcomingBookingData.exception);
    }
  }
}

