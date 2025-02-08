import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../components/chips/CustomMultipalChoiceChips.dart';
import '../../../../entities/models/GenreModel.dart';
import '../bloc/MoviesBloc.dart';

class FilterDialogBox extends StatelessWidget {
  const FilterDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child:
      Container(
        width: context.getScreenWidth(80),
        height: context.getScreenHeight(58),
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: context.colorPalette.backGroundColor,
            // border: Border.all(
            //     width: 1.3,
            //     color: context.colorPalette.accentColor.withOpacity(0.6)
            // ),
            borderRadius: BorderRadius.circular(20)),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, moviesState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genre",
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomMultipalChoiceChips(
                  borderColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                  bgColor: context.colorPalette.backGroundColor,
                  selectColor: context.colorPalette.accentColor,
                  selectItem: moviesState.selectedGenera ?? [],
                  checkColor: context.colorPalette.darkGreyColor,
                  selectedDataOnTap: (ChoiceChipData selectedData) {
                    context.read<MoviesBloc>().add(SelectedCategoryEvent(selectedData, (query) {
                      context .read<MoviesBloc>().add(GetAllFilteredMoviesEvent(query));
                    }));
                  },
                  dataList: moviesState.genreList
                      .map((toElement) => ChoiceChipData<GenreModel>(
                      toElement.id!, toElement.name!, toElement))
                      .toList(),
                  width: context.getScreenHeight(100),
                  isWrapable: false,
                  textColor: context.colorPalette.darkGreyColor,
                  unSelectedTextColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),


                Text(
                  "Language",
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomMultipalChoiceChips(
                  borderColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                  bgColor: context.colorPalette.backGroundColor,
                  selectColor: context.colorPalette.accentColor,
                  selectItem: moviesState.selectedLanguage ?? [],
                  checkColor: context.colorPalette.darkGreyColor,
                  selectedDataOnTap: (ChoiceChipData selectedData) {
                    context
                        .read<MoviesBloc>()
                        .add(SelectedLanguageEvent(selectedData, (query) {
                          context
                              .read<MoviesBloc>()
                              .add(GetAllFilteredMoviesEvent(query));
                        }));
                  },
                  dataList: moviesState.languageList
                      .map((toElement) => ChoiceChipData(
                          toElement.id!, toElement.name!, toElement))
                      .toList(),
                  width: context.getScreenHeight(100),
                  isWrapable: false,
                  textColor: context.colorPalette.darkGreyColor,
                  unSelectedTextColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Location",
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomMultipalChoiceChips(
                  borderColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                  bgColor: context.colorPalette.backGroundColor,
                  selectColor: context.colorPalette.accentColor,
                  selectItem: moviesState.selectedLocation ?? [],
                  checkColor: context.colorPalette.darkGreyColor,
                  selectedDataOnTap: (ChoiceChipData selectedData) {
                    context
                        .read<MoviesBloc>()
                        .add(SelectedLocationEvent(selectedData, (query) {
                          context
                              .read<MoviesBloc>()
                              .add(GetAllFilteredMoviesEvent(query));
                        }));
                  },
                  dataList: moviesState.locationList
                      .map((toElement) => ChoiceChipData(
                          toElement.id!, toElement.name!, toElement))
                      .toList(),
                  width: context.getScreenHeight(100),
                  isWrapable: false,
                  textColor: context.colorPalette.darkGreyColor,
                  unSelectedTextColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Experience",
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomMultipalChoiceChips(
                  borderColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                  bgColor: context.colorPalette.backGroundColor,
                  selectColor: context.colorPalette.accentColor,
                  selectItem: moviesState.selectedExperience ?? [],
                  checkColor: context.colorPalette.darkGreyColor,
                  selectedDataOnTap: (ChoiceChipData selectedData) {
                    context
                        .read<MoviesBloc>()
                        .add(SelectedExperienceEvent(selectedData, (query) {
                          context
                              .read<MoviesBloc>()
                              .add(GetAllFilteredMoviesEvent(query));
                        }));
                  },
                  dataList: moviesState.experienceList
                      .map((toElement) => ChoiceChipData(
                          toElement.id!, toElement.name!, toElement))
                      .toList(),
                  width: context.getScreenHeight(100),
                  isWrapable: false,
                  textColor: context.colorPalette.darkGreyColor,
                  unSelectedTextColor: context.isDarkMode
                      ? context.colorPalette.accentColor
                      : context.colorPalette.darkGreyColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      height: context.getScreenHeight(5),
                      backgroundColor: context.colorPalette.transparentColor,
                      text: 'Clear',
                      textColor: context.colorPalette.accentColor,
                      onTap: () async {
                        context.read<MoviesBloc>().add(ClearFiltersEvent(
                          (query) {
                            Navigator.pop(context);
                            context
                                .read<MoviesBloc>()
                                .add(GetAllFilteredMoviesEvent(query));
                          },
                        ));
                      },
                      borderColor: Border.all(
                          color: context.colorPalette.accentColor, width: 2.0),
                      width: context.getScreenWidth(20),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                      height: context.getScreenHeight(5),
                      backgroundColor: context.colorPalette.accentColor,
                      text: 'OK',
                      textColor: context.colorPalette.darkGreyColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      width: context.getScreenWidth(15),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
