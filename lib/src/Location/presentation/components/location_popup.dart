import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/components/chips/CustomChoiceChips.dart';
import 'package:novocinema/components/shimmerloaders/CinemaLocationShimmer.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_event.dart';
import 'package:novocinema/src/Location/presentation/bloc/LocationBloc.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';
import 'package:shimmer/shimmer.dart';

class LocationSelection extends StatefulWidget {
  const LocationSelection({super.key});

  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colorPalette.blackColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.colorPalette.accentColor.withOpacity(.20),
            width: 1,
          ),
        ),
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "LOCATION",
              style: context.textThemeDecoration.titleMedium.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.colorPalette.accentColor,
              ),
            ),
            SizedBox(height: context.getScreenHeight(3)),
            Divider(
              color: context.colorPalette.accentColor.withOpacity(.5),
              thickness: 1,
            ),
            SizedBox(height: context.getScreenHeight(3)),
            BlocBuilder<LocationBloc, LocationState>(
              buildWhen: (previous, current) {
                return previous.cityState != current.cityState ||
                    previous.selectedCity != current.selectedCity;
              },
              builder: (context, state) {
                if (state.cityState == CurrentAppState.LOADING) {
                  return Shimmer.fromColors(
                      baseColor: context.colorPalette.shimmerBaseColor,
                      highlightColor:
                          context.colorPalette.shimmerHighLightColor,
                      enabled: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.colorPalette.accentColor,
                              width: 1.4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ));
                } else if (state.cityState == CurrentAppState.SUCCESS) {
                  final cities =
                      state.cities.map((city) => city.cityName ?? "").toList();

                  return _buildDropdown(
                    value: state.selectedCity ?? cities.first,
                    items: cities,
                    onChanged: (value) {
                      final selectedCity = state.cities
                          .firstWhere((city) => city.cityName == value);
                      context.read<LocationBloc>().add(
                            CitySelectedEvent(
                              selectedCity.cityId!,
                              selectedCity.cityName,
                            ),
                          );
                      context.read<LocationBloc>().add(
                            GetAllCinemaLocationEvent(
                              cityId: selectedCity.cityId.toString(),
                              callback: () {
                                context.read<CinemaExperienceBloc>().add(
                                      GetCinemaExperiencesEvent(state
                                          .filteredCinemaLocations.first.id!),
                                    );
                                context
                                    .read<MoviesBloc>()
                                    .add(SingleLocationEvent(
                                        state.filteredCinemaLocations.first.id
                                            .toString(), (query) {
                                      context.read<MoviesBloc>().add(
                                            GetAllFilteredMoviesEvent(
                                              query,
                                            ),
                                          );
                                    }));
                              },
                            ),
                          );
                    },
                  );
                }
                return const Text("Failed to load cities.");
              },
            ),
            SizedBox(height: context.getScreenHeight(2)),
            BlocBuilder<LocationBloc, LocationState>(
              buildWhen: (previous, current) {
                return previous.cinemaLocationState !=
                        current.cinemaLocationState ||
                    previous.filteredCinemaLocations !=
                        current.filteredCinemaLocations ||
                    previous.slectedCinema != current.slectedCinema;
              },
              builder: (context, state) {
                if (state.cityState == CurrentAppState.LOADING ||
                    state.cinemaLocationState == CurrentAppState.LOADING) {
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
                              width: 1.4),
                          borderRadius: BorderRadius.circular(6),
                          color: context.colorPalette.accentColor,
                        ),
                      ));
                } else if (state.cinemaLocationState ==
                    CurrentAppState.SUCCESS) {
                  print("filter location");
                  print(state.filteredCinemaLocations);
                  if (state.filteredCinemaLocations.isEmpty) {
                    return const Text(
                      "No cinemas available for this city.",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  if (state.slectedCinema == null ||
                      state.slectedCinema!.isEmpty) {
                    context.read<CinemaExperienceBloc>().add(
                          GetCinemaExperiencesEvent(
                              state.filteredCinemaLocations.first.id!),
                        );
                    context.read<MoviesBloc>().add(SingleLocationEvent(
                            state.filteredCinemaLocations.first.id.toString(),
                            (query) {
                          context
                              .read<MoviesBloc>()
                              .add(GetAllFilteredMoviesEvent(query));
                        }));
                  }
                  final cinemaNames = state.filteredCinemaLocations
                      .map((cinema) => cinema.name ?? "Unknown")
                      .toList();
                  final selectedCinema = (state.slectedCinema != null &&
                          cinemaNames.contains(state.slectedCinema))
                      ? state.slectedCinema
                      : cinemaNames.first;
                  return _buildDropdown(
                    value: selectedCinema ?? "",
                    items: cinemaNames,
                    onChanged: (value) {
                      final selectedCinemas = state.filteredCinemaLocations
                          .firstWhere((cinema) => cinema.name == value);
                      context.read<LocationBloc>().add(CinemaSelectionEvent(
                            selectedCinemas.id!,
                            selectedCinemas.name,
                          ));

                      context
                          .read<CinemaExperienceBloc>()
                          .add(GetCinemaExperiencesEvent(selectedCinemas.id!));

                      context.read<MoviesBloc>().add(SingleLocationEvent(
                              selectedCinemas.id.toString(), (query) {
                            context
                                .read<MoviesBloc>()
                                .add(GetAllFilteredMoviesEvent(query));
                          }));
                    },
                  );
                }
                return const Text(
                  "",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorPalette.accentColor, width: 1.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: context.colorPalette.accentColor,
          ),
          dropdownColor: Colors.black,
          style: context.textThemeDecoration.paragraphMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.colorPalette.accentColor,
          ),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: context.colorPalette.accentColor,
                    ),
                  if (icon != null) const SizedBox(width: 5),
                  Text(item),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
