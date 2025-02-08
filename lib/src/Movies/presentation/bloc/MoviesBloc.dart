import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/entities/models/ExperienceModel.dart';
import 'package:novocinema/entities/models/LanguageModel.dart';
import 'package:novocinema/entities/models/LocationModel.dart';
import 'package:novocinema/entities/models/GetAllMoviesModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../entities/models/GenreModel.dart';
import '../../domain/useCases/GetAllFilterMoviesUseCase.dart';
import '../components/Movies.dart';
import '../screens/MoviesScreen.dart';

part 'MoviesEvent.dart';
part 'MoviesState.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetAllFilterMoviesUseCase getAllFilterMoviesUseCase;

  Map<String, dynamic> query = {};
  final List<MovieModel> movies = [];

  MoviesBloc(this.getAllFilterMoviesUseCase) : super(MoviesState(
      selectedMovieType: ChoiceChipData<Map<String,dynamic>>(0,'',null))) {
    on<GetAllFilteredMoviesEvent>(_getAllFilteredMoviesEvent);

    on<SelectedLanguageEvent>(_selectedLanguageEvent);
    on<SelectedExperienceEvent>(_selectedExperienceEvent);
    on<SelectedLocationEvent>(_selectedLocationEvent);

    on<SelectedCategoryEvent>(_selectedCategoryEvent);
    on<ClearFiltersEvent>(_clearFiltersEvent);
    on<SelectedMovieTypeEvent>(_selectedMovieTypeEvent);

    on<LikeMovieEvent>(_likeMovieEvent);

    on<ToggleLayoutViewEvent>(_toggleLayoutViewEvent);
  }


  _toggleLayoutViewEvent(
      ToggleLayoutViewEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(toggleMovieLayout: event.toggleMovieLayout));
    Logger.customLogData(
      "Selected View  {$query}",
      state.toggleMovieLayout.toString(),
    );
  }

  _likeMovieEvent(LikeMovieEvent event, Emitter<MoviesState> emit) {
    int movieData = List<MovieModel>.of(state.moviesList)
        .indexWhere((movie) => movie.vistaFilmId == event.movie.vistaFilmId);
    final likedMovie = [...state.moviesList];
    likedMovie.removeAt(movieData);
    likedMovie.add(event.movie.copyWith(isMovieLiked: event.liked));
    emit(state.copyWith(moviesList: likedMovie));
    // Logger.customLogData('Movie Liked data', likedMovie);
  }

  _selectedMovieTypeEvent(
      SelectedMovieTypeEvent event, Emitter<MoviesState> emit) async {
    List<MovieModel> filterMovies = [];

    if (event.selectedMovieType.title == 'Coming Soon') {
      filterMovies = movies
          .map((toElement) => toElement)
          .where((test) => test.isMovieLiked == true)
          .toList();
    } else if (event.selectedMovieType.title == 'Advance Booking') {
      filterMovies = movies
          .map((toElement) => toElement)
          .where((test) => test.isAdvanceBookingAvailable == true)
          .toList();
    } else {
      filterMovies = movies.map((toElement) => toElement).toList();
    }
    emit(state.copyWith(
        selectedMovieType: event.selectedMovieType, moviesList: filterMovies));
    Logger.customLogData(
      "Selected Movie Type  ",
      event.selectedMovieType.toString(),
    );
  }

  _clearFiltersEvent(ClearFiltersEvent event, Emitter<MoviesState> emit) async {
    query = {};
    emit(MoviesState(selectedMovieType: ChoiceChipData<Map<String,dynamic>>(0,'',null)));
    await event.query(query);
  }

  _selectedCategoryEvent(
      SelectedCategoryEvent event, Emitter<MoviesState> emit) async {
    final category = List<ChoiceChipData>.from(state.selectedGenera ?? []);
    if (category.contains(event.selectedCategory)) {
      category.remove(event.selectedCategory);
    } else {
      category.add(event.selectedCategory);
    }
    query['genreId'] = category.map((genra) => genra.Id.toString()).join(",");
    emit(state.copyWith(selectedGenera: category));
    Logger.customLogData(
      "Selected Category  {$query}",
      state.selectedGenera.toString(),
    );
    await event.query(query);
  }

  _selectedLocationEvent(
      SelectedLocationEvent event, Emitter<MoviesState> emit) async {
    final locations = List<ChoiceChipData>.from(state.selectedLocation ?? []);
    if (locations.contains(event.selectedLocation)) {
      locations.remove(event.selectedLocation);
    } else {
      locations.add(event.selectedLocation);
    }
    query['locationId'] =
        locations.map((location) => location.Id.toString()).join(",");
    emit(state.copyWith(selectedLocation: locations));
    Logger.customLogData(
      "Selected Location  {$query}",
      state.selectedLocation.toString(),
    );
    await event.query(query);
  }

  _selectedExperienceEvent(
      SelectedExperienceEvent event, Emitter<MoviesState> emit) async {
    final experience =
        List<ChoiceChipData>.from(state.selectedExperience ?? []);
    if (experience.contains(event.selectedExperience)) {
      experience.remove(event.selectedExperience);
    } else {
      experience.add(event.selectedExperience);
    }
    query['experienceId'] =
        experience.map((experience) => experience.Id.toString()).join(",");
    emit(state.copyWith(selectedExperience: experience));
    Logger.customLogData(
      "Selected Experienc  {$query}",
      state.selectedExperience.toString(),
    );
    await event.query(query);
  }

  _selectedLanguageEvent(
      SelectedLanguageEvent event, Emitter<MoviesState> emit) async {
    final language = List<ChoiceChipData>.from(state.selectedLanguage ?? []);
    if (language.contains(event.selectedLanguage)) {
      language.remove(event.selectedLanguage);
    } else {
      language.add(event.selectedLanguage);
    }
    query['languageId'] =
        language.map((language) => language.Id.toString()).join(",");
    emit(state.copyWith(selectedLanguage: language));
    Logger.customLogData(
      "Selected Language  {$query}",
      state.selectedLanguage.toString(),
    );
    await event.query(query);
  }

  _getAllFilteredMoviesEvent(
      GetAllFilteredMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    movies.clear();

    final List<dynamic> responses = await Future.wait([
      getAllFilterMoviesUseCase.call(
        GetAllFilterMoviesParams('/all', query),
      ),
      getAllFilterMoviesUseCase.call(
        GetAllFilterMoviesParams('/comingsoon', query),
      ),
    ]);

    final moviesDataList = responses[0] as DataResult<GetAllMoviesModel>;
    final moviesDataComingSoon = responses[1] as DataResult<GetAllMoviesModel>;

    if (moviesDataList is Success<GetAllMoviesModel> &&
        moviesDataComingSoon is Success<GetAllMoviesModel>) {
      movies.addAll(moviesDataList.data.movies?.toList() ?? []);
      // movies.addAll(moviesDataComingSoon.data.movies?.toList() ?? []);

      emit(state.copyWith(
          loading: CurrentAppState.SUCCESS,
          locationList: moviesDataList.data.filters!.locations,
          experienceList: moviesDataList.data.filters!.experiences,
          languageList: moviesDataList.data.filters!.languages,
          genreList: moviesDataList.data.filters!.genres,
          toggleMovieLayout: MovieLayoutType.values.first,
          moviesList: movies,
          selectedMovieType:  ChoiceChipData(tabData[0]['Id'], tabData[0]['Name'], tabData[0])));
    }
    if (moviesDataList is Error<GetAllMoviesModel>) {
      emit(state.copyWith(
          loading: CurrentAppState.ERROR,
          appException: moviesDataList.exception));
    }
    if (moviesDataComingSoon is Error<GetAllMoviesModel>) {
      emit(state.copyWith(
          loading: CurrentAppState.ERROR,
          appException: moviesDataComingSoon.exception));
    }
  }
}
