import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/components/shimmerloaders/CrowselShimmer.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/components/CrowselSlider.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/Movies/presentation/components/FilterDialogBox.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../Movies/presentation/bloc/MoviesBloc.dart';
import '../../../Movies/presentation/components/Movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: context.getScreenHeight(33),
            width: context.getScreenWidth(100),
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.bannerState != current.bannerState,
              builder: (context, state) {
                if (state.bannerState == CurrentAppState.SUCCESS) {
                  return CrowselSlider(
                      onClick: () {}, data: state.topFiveBannersList);
                }

                if (state.bannerState == CurrentAppState.ERROR) {
                  return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(state.appException!.message.toString()));
                }
                return const CrowselShimmer();
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: context.getScreenHeight(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.language.getText('movies'),
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleLarge,
                      // locale: Locale('ar'),
                    ),
                    Text(
                      "Find & Book the movie of your choice",
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.paragraphLarge,
                    ),
                  ],
                )),
                BlocBuilder<MoviesBloc, MoviesState>(
                  builder: (context, homeState) {
                    return IgnorePointer(
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
                        child: Container(
                          width: context.getScreenWidth(10),
                          height: context.getScreenWidth(10),
                          decoration: BoxDecoration(
                              color: context.colorPalette.cardBackgroundColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                ImageConstants.settings,
                                width: 14,
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: context.getScreenHeight(1)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Movies(),
          )
        ],
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
