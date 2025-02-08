import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';
import 'package:novocinema/components/chips/CustomChip.dart';
import 'package:novocinema/src/Movies/presentation/screens/MoviesScreen.dart';
import '../../../../components/cards/MovieCard.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../components/shimmerloaders/MovieListShimmer.dart';
import '../../../../core/resources/enums.dart';

final List<Map<String, dynamic>> tabData = [
  {'Id': 0, 'Name': 'Now Showing'},
  {'Id': 1, 'Name': 'Coming Soon'},
  {'Id': 2, 'Name': 'Advance Booking'}
];

class PrivateMovies extends StatelessWidget {
  final Function onMovieSelected;
  const PrivateMovies({super.key, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.getScreenWidth(100),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        buildWhen: (previous, current) =>
            previous.loading != current.loading ||
            previous.selectedMovieType != current.selectedMovieType ||
            previous.toggleMovieLayout != current.toggleMovieLayout,
        builder: (context, moviesState) {


          if (moviesState.loading == CurrentAppState.SUCCESS) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose the Movie',
                  style: context.textThemeDecoration.titleMedium.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: context.colorPalette.whiteColor),
                ),
                SizedBox(
                  height: context.getScreenHeight(2),
                ),

                SizedBox(
                    height: context.getScreenHeight(5),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        final tabsData = tabData[index];
                        return CustomChip<Map<String,dynamic>>(
                          data: ChoiceChipData<Map<String,dynamic>>(tabsData['Id'], tabsData['Name'], tabsData),
                          selectedDate: moviesState.selectedMovieType ,
                          onPressEvent: (data) {
                            context.read<MoviesBloc>().add(SelectedMovieTypeEvent(data));

                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 12,);

                      }, itemCount: tabData.length,
                      scrollDirection: Axis.horizontal,
                    )
                ),



                SizedBox(height: context.getScreenHeight(2)),
                if (moviesState.moviesList.isEmpty) ...[
                  Container(
                      height: context.getScreenHeight(50),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text("No Data"))
                ] else ...[
                  SizedBox(
                    width: context.getScreenWidth(100),
                    // color : Colors.amber,
                    child: Wrap(
                      // spacing: context.getScreenWidth(5),
                      runSpacing: context.getScreenWidth(5),
                      alignment: WrapAlignment.spaceBetween,
                      children:
                          List.generate(moviesState.moviesList.length, (index) {
                        final movie = moviesState.moviesList[index];

                        if (moviesState.toggleMovieLayout == MovieLayoutType.GRID_VIEW) {
                          return MovieGridCard(
                            movieData: movie,
                            onPressEvent:(BuildContext context, MovieModel movie) {
                              onMovieSelected(movie);
                              // Navigator.pushNamed(
                              //     context, RoutesName.movieDetailScreen,
                              //     arguments: {
                              //       MOVIE_KEY: movie.movieId.toString(),
                              //       MOVIE_IMAGE_URL: movie.movieImageUrl
                              //     });
                            },
                          );
                        } else {
                          return MovieListCard(
                            movieData: movie,
                            onPressEvent:
                                (BuildContext context, MovieModel movie) {
                              onMovieSelected(movie);
                              // Navigator.pushNamed(
                              //     context, RoutesName.movieDetailScreen,
                              //     arguments: {
                              //       MOVIE_KEY: movie.movieId.toString(),
                              //       MOVIE_IMAGE_URL: movie.movieImageUrl
                              //     });
                            },
                          );
                        }
                      }).toList(),
                    ),
                  )
                ]
              ],
            );
          }
          if (moviesState.loading == CurrentAppState.ERROR) {
            return Container(
                alignment: Alignment.center,
                height: context.getScreenHeight(50),
                child: Text(moviesState.appException!.message.toString()));
          }
          return const MovieListShimmer();
        },
      ),
    );
  }
}
