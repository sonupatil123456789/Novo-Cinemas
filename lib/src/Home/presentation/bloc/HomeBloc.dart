import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/UseCase.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/entities/models/ExperienceModel.dart';
import 'package:novocinema/entities/models/LanguageModel.dart';
import 'package:novocinema/entities/models/LocationModel.dart';
import 'package:novocinema/src/Home/domain/models/BannerModel.dart';
import 'package:novocinema/entities/models/GenreModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookModel.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookSessionModel.dart';
import 'package:novocinema/src/Home/domain/useCases/QuickBookUseCase.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/models/QuickBookCinemaModel.dart';
import '../../domain/models/QuickBookMoviesModel.dart';
import '../../domain/useCases/GetAllBannersUseCase.dart';

part 'HomeEvent.dart';
part 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllBannersUseCase getAllBannersUseCase;

  final QuickBookUseCase quickBookUseCase;

  Map<String, dynamic> query = {};
  Map<String, dynamic> quickBook = {};

  HomeBloc(this.getAllBannersUseCase, this.quickBookUseCase): super(HomeState()) {
    on<GetAllBannersEvent>(_getAllBannersEvent);




    on<BuildSeatLayoutOnQuickBookTimeSelectedEvent>(_buildSeatLayoutOnQuickBookTimeSelectedEvent);

    on<ClearQuickBookEvent>(_clearQuickBookEvent);
    on<GetQuickBookEvent>(_getQuickBookEvent);


    on<SelectedQuickBookCinemaEvent>(_selectedQuickBookCinemaEvent);
    on<SelectedQuickBookMovieEvent>(_selectedQuickBookMovieEvent);
    on<SelectedQuickBookDateEvent>(_selectedQuickBookDateEvent);
    on<SelectedQuickBookTimeEvent>(_selectedQuickBookTimeEvent);



  }




  _selectedQuickBookTimeEvent(SelectedQuickBookTimeEvent event, Emitter<HomeState> emit)   {
    if(event.quickBookTime == state.selectedQuickBookTime){
      emit(state.copyWith(selectedQuickBookTime: ChoiceChipData(0, '',null)));
    }else{
      emit(state.copyWith(selectedQuickBookTime: event.quickBookTime));
    }
  }

  _selectedQuickBookDateEvent(SelectedQuickBookDateEvent event, Emitter<HomeState> emit)  {
    if(event.quickBookDate == state.selectedQuickBookDate){
      emit(state.copyWith(selectedQuickBookDate: ChoiceChipData(0, '',null)));
    }else{
      emit(state.copyWith(selectedQuickBookDate: event.quickBookDate));
    }
    Logger.customLogData("Selected QuickBook Date  {$quickBook}", state.selectedQuickBookDate.toString(),);
  }

  _selectedQuickBookMovieEvent(SelectedQuickBookMovieEvent event, Emitter<HomeState> emit) async {

    if(event.quickBookMovie == state.selectedQuickBookMovie){
      emit(state.copyWith(selectedQuickBookMovie: ChoiceChipData(0, '',null)));
      quickBook.remove('movie_id');
    }else{
      emit(state.copyWith(selectedQuickBookMovie: event.quickBookMovie));
      quickBook['movie_id'] = event.quickBookMovie.Id;
    }
    Logger.customLogData("Selected QuickBook Movie  {$quickBook}", state.selectedQuickBookMovie.toString(),);
    await _getQuickBookEvent(GetQuickBookEvent(quickBook), emit);

  }

  _selectedQuickBookCinemaEvent(SelectedQuickBookCinemaEvent event, Emitter<HomeState> emit) async {

    if(event.quickBookCinema == state.selectedQuickBookCinema){
      emit(state.copyWith(selectedQuickBookCinema: ChoiceChipData(0, '', null)));
      quickBook.remove('cinema_id');
    }else{
      emit(state.copyWith(selectedQuickBookCinema: event.quickBookCinema));
      quickBook['cinema_id'] = event.quickBookCinema.Id;
    }
    Logger.customLogData("Selected QuickBook Cinema  {$quickBook}", state.selectedQuickBookCinema.toString(),);
    await _getQuickBookEvent(GetQuickBookEvent(quickBook), emit);

  }

  _buildSeatLayoutOnQuickBookTimeSelectedEvent(BuildSeatLayoutOnQuickBookTimeSelectedEvent event, Emitter<HomeState> emit) async {
    if(event.showTime == state.selectedQuickBookTime){
      emit(state.copyWith(selectedQuickBookTime: ChoiceChipData(0, '',null)));
    }else{
      emit(state.copyWith(selectedQuickBookTime: event.showTime));
      final quickBookTimeData =  (state.selectedQuickBookTime?.data as QuickBookSessionModel);
      event.callBack(quickBookTimeData.sessionId!, quickBookTimeData.cinemaId.toString());
    }
  }

  _clearQuickBookEvent(ClearQuickBookEvent event, Emitter<HomeState> emit)  async{

    quickBook= {};
    emit(state.copyWith(
        selectedQuickBookCinema: ChoiceChipData(0, '',null),
        selectedQuickBookMovie: ChoiceChipData(0, '',null),
      selectedQuickBookDate: ChoiceChipData(0, '',null),
      selectedQuickBookTime: ChoiceChipData(0, '',null),
    ));
    await _getQuickBookEvent(GetQuickBookEvent(quickBook), emit);

  }

  _getQuickBookEvent(GetQuickBookEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(quickBookState: CurrentAppState.LOADING));
    final quickBookData = await quickBookUseCase.call(event.quickBookQuery);
    switch (quickBookData) {
      case Success<QuickBookModel>():
        emit(state.copyWith(quickBookData: quickBookData.data ,quickBookState: CurrentAppState.SUCCESS));
      case Error<QuickBookModel>():
        emit(state.copyWith(appException: quickBookData.exception,quickBookState: CurrentAppState.ERROR));
    }
    Logger.customLogData("Quick Book " ,state.quickBookData.toString(),);

  }


  _getAllBannersEvent(GetAllBannersEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(bannerState: CurrentAppState.LOADING));
    final bannerDataList = await getAllBannersUseCase.call(EmptyParams());

    switch (bannerDataList) {
      case Success<List<BannerModel>>():
        emit(state.copyWith(bannerState : CurrentAppState.SUCCESS, topFiveBannersList: bannerDataList.data));
      case Error<List<BannerModel>>():
        emit(state.copyWith(bannerState: CurrentAppState.ERROR, appException: bannerDataList.exception));
    }
  }




}
