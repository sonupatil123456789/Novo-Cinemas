import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Search/domain/models/SearchCinemaModel.dart';
import 'package:novocinema/src/Search/domain/models/SearchModel.dart';
import 'package:novocinema/src/Search/domain/models/SearchMovieModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/useCases/SearchUseCase.dart';

part 'SearchEvent.dart';

part 'SearchState.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;

  SearchBloc(this.searchUseCase) : super(SearchState()) {
    on<SearchMovieEvent>(_searchMovieEvent);
  }

  _searchMovieEvent(SearchMovieEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final searchData = await searchUseCase.call(event.search);
    switch (searchData) {
      case Success<SearchModel>():
        emit(state.copyWith(
            loading: CurrentAppState.SUCCESS,
            searchCinemaList: searchData.data.cinemas,
            searchMoviesList: searchData.data.movies));
      case Error<SearchModel>():
        emit(state.copyWith(loading: CurrentAppState.ERROR, appException: searchData.exception));
    }
  }
}
