import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/shimmerloaders/SearchShimmer.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/nativeServices/DeepLinkServices.dart';
import '../../domain/models/SearchCinemaModel.dart';
import '../../domain/models/SearchMovieModel.dart';
import '../bloc/SearchBloc.dart';
import '../components/SearchLocationCard.dart';
import '../components/SearchMovieCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce = null;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      context.read<SearchBloc>().add(SearchMovieEvent(_searchController.text.toString()));
    });
  }

  @override
  void initState() {
    context.read<SearchBloc>().add(const SearchMovieEvent(""));
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: context.getScreenWidth(70),
              height: context.getScreenHeight(6),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _searchController,
                cursorColor: context.colorPalette.accentColor,
                onChanged: (value) {
                  _onSearchChanged();
                },
                decoration: InputDecoration.collapsed(
                    hintText: "Search here ...",
                    hintStyle: context.textThemeDecoration.subTitleLarge
                        .copyWith(
                        color: context.isDarkMode
                            ? context.colorPalette.accentColor
                            : context.colorPalette.lightGreyColor)),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, SearchState searchState) {



            if(searchState.loading == CurrentAppState.SUCCESS){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 30),
                width: context.getScreenWidth(100),
                child: Wrap(
                    runSpacing: context.getScreenWidth(5),
                    alignment: WrapAlignment.spaceBetween,
                    children:[
                      ...(List.generate(searchState.searchMoviesList.length, (index) {
                        final movie = searchState.searchMoviesList[index];
                        return SearchMovieCard(
                          movieData: movie,
                          onPressEvent:(BuildContext context, SearchMovieModel movie) {
                            Navigator.pushNamed(context, RoutesName.movieDetailScreen,
                                arguments: {
                                  MOVIE_KEY: movie.id.toString(),
                                  MOVIE_IMAGE_URL: movie.imageUrl
                                });
                          },
                        );
                      }).toList()),
                      ...(List.generate(searchState.searchCinemaList.length, (index) {
                        final location = searchState.searchCinemaList[index];
                        return SearchLocationCard(
                          locationData: location,
                          onPressEvent: (BuildContext context, SearchCinemaModel searchLocation) {  },
                        );
                      }).toList())
                    ]
                ),
              );
            }

            if(searchState.loading == CurrentAppState.ERROR){
              return Container(
                  alignment: Alignment.center,
                  height: context.getScreenHeight(50),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:Text(searchState.appException!.message.toString()));
            }

            return const SearchShimmer();

          },
        ),
      ),
    );
  }



}
