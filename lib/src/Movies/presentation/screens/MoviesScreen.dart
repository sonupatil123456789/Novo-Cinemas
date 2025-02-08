import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../components/FilterDialogBox.dart';
import '../components/Movies.dart';

enum MovieLayoutType {
  GRID_VIEW(0, 'Grid View', Icons.window),
  LIST_VIEW(1, 'List View', Icons.list);

  final int Id;
  final String name;

  final IconData iconName;

  const MovieLayoutType(this.Id, this.name, this.iconName);
}

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    context
        .read<MoviesBloc>()
        .add(const GetAllFilteredMoviesEvent(<String, dynamic>{}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: Container(
          height: double.infinity,
          // color: Colors.green,
          child: Row(
            children: [
              Text(
                'Movies',
                style: context.textThemeDecoration.titleSmall
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, homeState) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.searchScreen);
                        },
                        child: SvgPicture.asset(
                          ImageConstants.search,
                          width: 20,
                          height: 20,
                          color: context.colorPalette.accentColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      IgnorePointer(
                        ignoring: homeState.loading == CurrentAppState.SUCCESS
                            ? false
                            : true,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              useRootNavigator: false,
                              builder: (context) {
                                return const FilterDialogBox();
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            ImageConstants.settings,
                            width: 20,
                            height: 20,
                            color: context.colorPalette.accentColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    previous.toggleMovieLayout != current.toggleMovieLayout,
                builder: (BuildContext context, movieState) {
                  return Container(
                      width: context.getScreenWidth(100),
                      height: context.getScreenHeight(7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: context.colorPalette.transparentColor,
                          border: Border.all(
                              width: 1,
                              color: context.colorPalette.accentColor
                                  .withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: List.generate(MovieLayoutType.values.length,
                            (index) {
                          final layout = MovieLayoutType.values.toList()[index];

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<MoviesBloc>()
                                    .add(ToggleLayoutViewEvent(layout));
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    color: movieState.toggleMovieLayout ==
                                            layout
                                        ? context.colorPalette.accentColor
                                        : context.colorPalette.transparentColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Icon(
                                  layout.iconName,
                                  size: context.getScreenWidth(4),
                                  color: movieState.toggleMovieLayout == layout
                                      ? context.colorPalette.blackColor
                                      : context.colorPalette.whiteColor,
                                ),
                              ),
                            ),
                          );
                        }),
                      ));
                },
              ),
              SizedBox(height: context.getScreenHeight(2)),
              const Movies(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CinemaSeatLayout(
//   rows: 8,
//   seatsPerRow: 10,
// ),

// q and b    syber source

// SizedBox(height: 20,),
//
// GestureDetector(
//   onTap: () {
//     Navigator.pushNamed(context, RoutesName.movieDetailScreen, arguments: {DEEP_LINK_MOVIE_KEY: "1234567890"});
//   },
//   child: Container(
//     width: 100,
//     height: 100,
//     color: Colors.black38,
//     alignment: Alignment.center,
//     child: const Text("Movie Detail"),
//   ),
// )
