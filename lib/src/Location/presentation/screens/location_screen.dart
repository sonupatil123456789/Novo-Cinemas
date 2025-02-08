import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/components/BackButtonNavbar.dart';
import 'package:novocinema/components/chips/CustomChoiceChips.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_event.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_state.dart';
import 'package:novocinema/src/Location/presentation/bloc/LocationBloc.dart';
import 'package:novocinema/src/Location/presentation/components/location_popup.dart';
import 'package:novocinema/src/Location/presentation/components/mall_info.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';
import 'package:novocinema/src/Movies/presentation/components/Movies.dart';
import 'package:shimmer/shimmer.dart';

class LocationScreenByCity extends StatefulWidget {
  const LocationScreenByCity({super.key});

  @override
  State<LocationScreenByCity> createState() => _LocationScreenByCityState();
}

class _LocationScreenByCityState extends State<LocationScreenByCity> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final locationBloc = context.read<LocationBloc>();
      final movieBloc = context.read<MoviesBloc>();
      locationBloc.add(GetAllCitiesEvent());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    final locationBloc = context.read<LocationBloc>();
    final cinemaExperienceBloc = context.read<CinemaExperienceBloc>();

    // Reset values when navigating back
    locationBloc.add(ClearSelectionEvent());
    cinemaExperienceBloc.add(ClearCinemaExperienceEvent());
    context.read<MoviesBloc>().add(ClearFiltersEvent(
      (query) {
        context.read<MoviesBloc>().add(GetAllFilteredMoviesEvent(query));
      },
    ));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final locationBloc = context.read<LocationBloc>();
        final cinemaExperienceBloc = context.read<CinemaExperienceBloc>();

        // Reset values when navigating back
        locationBloc.add(ClearSelectionEvent());
        cinemaExperienceBloc.add(ClearCinemaExperienceEvent());
        context.read<MoviesBloc>().add(ClearFiltersEvent(
          (query) {
            context.read<MoviesBloc>().add(GetAllFilteredMoviesEvent(query));
          },
        ));
        Navigator.pop(context);
        return true;
      },
      child: ArtBoard(
          header: BackButtonNavBar(
            onBackPress: () {
              final locationBloc = context.read<LocationBloc>();
              final cinemaExperienceBloc = context.read<CinemaExperienceBloc>();

              // Reset values when navigating back
              locationBloc.add(ClearSelectionEvent());
              cinemaExperienceBloc.add(ClearCinemaExperienceEvent());
              context.read<MoviesBloc>().add(ClearFiltersEvent(
                (query) {
                  context
                      .read<MoviesBloc>()
                      .add(GetAllFilteredMoviesEvent(query));
                },
              ));
              Navigator.pop(context);
            },
            backgroundColor: context.colorPalette.blackColor,
            center: Text(
              "Location",
              style: context.textThemeDecoration.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('assets/pngassets/location.png'),
                    const Padding(
                        padding: EdgeInsets.only(top: 70),
                        child: LocationSelection()),
                  ],
                ),
                SizedBox(
                  height: context.getScreenHeight(3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                      if (state.cinemaLocationState ==
                          CurrentAppState.LOADING) {
                        return Shimmer.fromColors(
                            baseColor: context.colorPalette.shimmerBaseColor,
                            highlightColor:
                                context.colorPalette.shimmerHighLightColor,
                            enabled: true,
                            child: Container(
                              height: context.getScreenHeight(80),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: context.colorPalette.accentColor,
                                    width: 1.4),
                                borderRadius: BorderRadius.circular(6),
                                color: context.colorPalette.accentColor,
                              ),
                            ));
                      } else if (state.cinemaLocationState ==
                          CurrentAppState.SUCCESS) {
                        if (state.filteredCinemaLocations.isEmpty) {
                          return const Text(
                            "No cinemas available for this city.",
                            style: TextStyle(color: Colors.white),
                          );
                        }

                        final cinemaNames = state.filteredCinemaLocations
                            .map((cinema) => cinema.name ?? "Unknown")
                            .toList();
                        final selectedCinema = (state.slectedCinema != null &&
                                cinemaNames.contains(state.slectedCinema))
                            ? state.slectedCinema
                            : cinemaNames.first; // Default to first cinema
                        return Column(
                          children: [
                            MallInformation(
                              mallName: selectedCinema ?? "",
                              latitude: double.tryParse(state
                                          .filteredCinemaLocations
                                          .firstWhere(
                                              (el) => el.name == selectedCinema)
                                          .lat ??
                                      "") ??
                                  0,
                              longitude: double.tryParse(state
                                          .filteredCinemaLocations
                                          .firstWhere(
                                              (el) => el.name == selectedCinema)
                                          .long ??
                                      "") ??
                                  0,
                            ),
                            Text.rich(
                              textAlign: TextAlign.start,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Experience @ ",
                                    style: context
                                        .textThemeDecoration.titleMedium
                                        .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: context.colorPalette.whiteColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: selectedCinema ?? "",
                                    style: context
                                        .textThemeDecoration.titleMedium
                                        .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: context.colorPalette.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: context.getScreenHeight(1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                  BlocBuilder<CinemaExperienceBloc, CinemaExperienceState>(
                    builder: (context, state) {
                      if (state.cinemaExperienceState == CurrentAppState.LOADING) {
                        return Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor:
                              context.colorPalette.shimmerHighLightColor,
                          enabled: true,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.colorPalette.accentColor,
                                width: 1.4,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              color: context.colorPalette.accentColor,
                            ),
                          ),
                        );
                      } else if (state.cinemaExperienceState == CurrentAppState.SUCCESS) {
                        if (state.cinemaExperiences.isEmpty) {
                          return const Text(
                            "No experiences available for this cinema.",
                            style: TextStyle(color: Colors.white),
                          );
                        }

                        final experienceNames = state.cinemaExperiences
                            .map((experience) =>
                                experience.experienceName ?? "Unknown")
                            .toList();

                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.cinemaExperiences.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Adjust based on UI design
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final experience = state.cinemaExperiences[index];
                            return GestureDetector(
                              onTap: () {
                                // context
                                //     .read<ExperienceBloc>()
                                //     .add(SelectExperienceEvent(experience.id));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .grey[800], // Change based on selection
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  experience.experienceName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Text(
                        "",
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: context.getScreenHeight(2),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                        if (state.cinemaLocationState ==
                            CurrentAppState.LOADING) {
                          return Shimmer.fromColors(
                              baseColor: context.colorPalette.shimmerBaseColor,
                              highlightColor:
                                  context.colorPalette.shimmerHighLightColor,
                              enabled: true,
                              child: Container(
                                height: context.getScreenHeight(80),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: context.colorPalette.accentColor,
                                      width: 1.4),
                                  borderRadius: BorderRadius.circular(6),
                                  color: context.colorPalette.accentColor,
                                ),
                              ));
                        } else if (state.cinemaLocationState ==
                            CurrentAppState.SUCCESS) {
                          if (state.filteredCinemaLocations.isEmpty) {
                            return const Text(
                              "No cinemas available for this city.",
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          final cinemaNames = state.filteredCinemaLocations
                              .map((cinema) => cinema.name ?? "Unknown")
                              .toList();
                          final selectedCinema = (state.slectedCinema != null &&
                                  cinemaNames.contains(state.slectedCinema))
                              ? state.slectedCinema
                              : cinemaNames.first;
                          return Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Movies @ ",
                                  style: context.textThemeDecoration.titleMedium
                                      .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: context.colorPalette.whiteColor,
                                  ),
                                ),
                                TextSpan(
                                  text: selectedCinema ?? "",
                                  style: context.textThemeDecoration.titleMedium
                                      .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: context.colorPalette.accentColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Text(
                          "jjjjjj",
                          style: TextStyle(color: Colors.white),
                        );
                      }),
                      Movies(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
