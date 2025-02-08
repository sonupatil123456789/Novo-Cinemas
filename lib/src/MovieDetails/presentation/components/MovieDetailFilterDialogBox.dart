// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:novocinema/core/theams/Utils.dart';
// import 'package:novocinema/src/MovieDetails/presentation/bloc/ShowTimeBloc.dart';
// import '../../../../components/CustomButton.dart';
// import '../../../../components/chips/CustomChoiceChips.dart';
// import '../../../../components/chips/CustomMultipalChoiceChips.dart';
//
// class MovieDetailFilterDialogBox extends StatelessWidget {
//   const MovieDetailFilterDialogBox({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: context.getScreenWidth(80),
//         // height: context.getScreenHeight(46),
//         padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
//         decoration: BoxDecoration(
//             color: context.colorPalette.backGroundColor, borderRadius: BorderRadius.circular(20)),
//         child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
//           builder: (context, movieState) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Location",
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textThemeDecoration.titleSmall,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomMultipalChoiceChips(
//                   borderColor: context.isDarkMode
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.darkGreyColor,
//                   bgColor: context.colorPalette.backGroundColor,
//                   selectColor: context.colorPalette.accentColor,
//                   selectItem: movieState.selectedLocations ?? [],
//                   checkColor: context.colorPalette.darkGreyColor,
//                   selectedDataOnTap: (ChoiceChipData selectedData) {
//                     context.read<MovieDetailsBloc>().add(SelectedLocationEvent(selectedData));
//                   },
//                   dataList: movieState.movieFilterData.locations!
//                       .map((toElement) => ChoiceChipData(toElement.id, toElement.name, null))
//                       .toList(),
//                   width: context.getScreenHeight(100),
//                   isWrapable: true,
//                   textColor: context.colorPalette.darkGreyColor,
//                   unSelectedTextColor: context.isDarkMode
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.darkGreyColor,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "Experiences",
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textThemeDecoration.titleSmall,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomMultipalChoiceChips(
//                   borderColor: context.isDarkMode
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.darkGreyColor,
//                   bgColor: context.colorPalette.backGroundColor,
//                   selectColor: context.colorPalette.accentColor,
//                   selectItem: movieState.selectedExperiences ?? [],
//                   checkColor: context.colorPalette.darkGreyColor,
//                   selectedDataOnTap: (ChoiceChipData selectedData) {
//                     context.read<MovieDetailsBloc>().add(SelectedExperienceEvent(selectedData));
//                   },
//                   dataList: movieState.movieFilterData.formats!
//                       .map((toElement) => ChoiceChipData(toElement.id, toElement.name, null))
//                       .toList(),
//                   width: context.getScreenHeight(100),
//                   isWrapable: true,
//                   textColor: context.colorPalette.darkGreyColor,
//                   unSelectedTextColor: context.isDarkMode
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.darkGreyColor,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "Timings",
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textThemeDecoration.titleSmall,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomMultipalChoiceChips(
//                   borderColor: context.isDarkMode
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.darkGreyColor,
//                   bgColor: context.colorPalette.backGroundColor,
//                   selectColor: context.colorPalette.accentColor,
//                   selectItem: movieState.selectedTimings ?? [],
//                   checkColor: context.colorPalette.darkGreyColor,
//                   selectedDataOnTap: (ChoiceChipData selectedData) {
//                     context.read<MovieDetailsBloc>().add(SelectedTimingEvent(selectedData));
//                   },
//                   dataList: movieState.movieFilterData.timings!
//                       .map((toElement) => ChoiceChipData(0, toElement, null))
//                       .toList(),
//                   width: context.getScreenHeight(100),
//                   isWrapable: true,
//                   textColor: context.colorPalette.darkGreyColor,
//                   unSelectedTextColor: context.isDarkMode
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.darkGreyColor,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     CustomButton(
//                       height: context.getScreenHeight(5),
//                       backgroundColor: context.colorPalette.transparentColor,
//                       text: 'Clear',
//                       textColor: context.colorPalette.accentColor,
//                       onTap: () async {
//                         context.read<MovieDetailsBloc>().add(const ClearMovieFilters());
//                       },
//                       borderColor: Border.all(color: context.colorPalette.accentColor, width: 2.0),
//                       width: context.getScreenWidth(20),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     CustomButton(
//                       height: context.getScreenHeight(5),
//                       backgroundColor: context.colorPalette.accentColor,
//                       text: 'OK',
//                       textColor: context.colorPalette.darkGreyColor,
//                       onTap: () {
//                         String? selectedCinemaIds =
//                             movieState.selectedLocations?.map((element) => element.Id).join(",");
//                         String? selectedFormatIds =
//                             movieState.selectedExperiences?.map((element) => element.Id).join(",");
//                         String? selectedTimings =
//                             movieState.selectedTimings?.map((element) => element.title).join(",");
//                         if (selectedCinemaIds != null ||
//                             selectedFormatIds != null ||
//                             selectedTimings != null) {
//                           context.read<MovieDetailsBloc>().add(GetMovieDetailsEvent(
//                               movieState.movieDetails.movieId.toString(),
//                               cinemaId: selectedCinemaIds,
//                               formatId: selectedFormatIds,
//                               timing: selectedTimings));
//                         }
//                         Navigator.pop(context);
//                       },
//                       width: context.getScreenWidth(15),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                   ],
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
