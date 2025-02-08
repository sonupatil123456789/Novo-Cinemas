import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/components/CircularLoader.dart';
import 'package:novocinema/src/Auth/presentation/bloc/AuthBloc.dart';
import 'package:novocinema/src/Auth/presentation/screens/LoginScreen.dart';
import 'package:novocinema/src/ShowTime/presentation/bloc/ShowTimeBloc.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';

import '../../../../components/shimmerloaders/MovieDetailsShimmer.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/theams/Utils.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';
import '../../../SeatLayout/presentation/screens/SeatLayoutScreen.dart';
import '../../domain/models/ShowTimeMoviesModel.dart';
import '../components/DateCard.dart';
import '../components/ShowTimeExpandedAccordianCard.dart';
import '../components/ShowTimeMovieCard.dart';

class ShowTimeScreen extends StatefulWidget {
  const ShowTimeScreen({
    super.key,
  });

  @override
  State<ShowTimeScreen> createState() => _ShowTimeScreenState();
}

class _ShowTimeScreenState extends State<ShowTimeScreen> {
  @override
  void initState() {
    context.read<ShowTimeBloc>().add(const GetAllMoviesWithSessionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(12);

    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {
        context.read<ShowTimeBloc>().add(const ClearShowTimeSessionStateEvent());
        Navigator.pop(context);
      },
        center: SizedBox(
          height: double.infinity,
          // color: Colors.green,
          child: Row(
            children: [
              Text('Showtime', style: context.textThemeDecoration.titleSmall.copyWith(
                  fontWeight: FontWeight.bold
              ),),
              const Spacer(),
            ],
          ),
        ),
      ),


      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          // context.read<MovieDetailsBloc>().add(const ClearSessionStateEvent());
        },
        child: BlocBuilder<ShowTimeBloc, ShowTimeState>(
          buildWhen: (previous, current) =>
              previous.loading != current.loading ||
              previous.selectedDate != current.selectedDate ||
              previous.selectedTiming != current.selectedTiming,
          builder: (BuildContext context, showTimeState) {
            if (showTimeState.loading == CurrentAppState.LOADING ||
                showTimeState.loading == CurrentAppState.INITIAL) {
              return const Center(child: CircularLoader());
            }
            if (showTimeState.loading == CurrentAppState.ERROR) {
              return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(showTimeState.appException!.message.toString()));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const ShowTimeExpandedAccordianCard(title: 'Select Location', children: []),
                        const SizedBox(height: 10,),
                        const ShowTimeExpandedAccordianCard(    title: 'Select Experience', children: []),
                        const SizedBox(  height: 10,  ),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.all(context.getScreenWidth(3)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.6),  width: 0.4)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: context.getScreenWidth(100),
                                height: context.getScreenHeight(8),
                                child: ListView.builder(
                                  itemBuilder: (BuildContext context, int index) {
                                    final data = showTimeState.showTimeData.showTimesData?.entries.toList()[index];

                                    return DateCard(
                                      date: data!,
                                      selectedDate: showTimeState.selectedDate,
                                      onPressEvent: (String date) {
                                        context.read<ShowTimeBloc>().add(OnDateSelectedEvent(date));
                                        // context.read<ShowTimeBloc>().add(OnMallTimeSelectedEvent(showTime: null, mallName: ''));
                                      },
                                    );
                                  },
                                  itemCount: showTimeState.showTimeData.showTimesData?.length ??0,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(
                                height: context.getScreenHeight(3),
                              ),
                              ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = showTimeState.showTimeData.showTimesData?[ showTimeState.selectedDate]?.mallLocation   ?.entries    .toList()[index];

                                  return ShowTimeExpandedAccordianCard(
                                      title: data!.key,
                                      children: data != null? data!.value.entries .map((mallEntry) {
                                                final moviesInMall = mallEntry.value.entries.map((movieEntry) {
                                                  final movie =movieEntry.value;
                                                  return ShowTimeMovieCard(
                                                    movieData: movie,
                                                    onPressEvent:(BuildContext context, ShowTimeMovieModel movie,  ShowTimeDetailsModel    showTime) {
                                                      context.read<ShowTimeBloc>() .add(OnMallTimeSelectedEvent(showTime:  showTime, mallName:data!.key,
                                                          callback: (selectedTiming){
                                                            context.read<AuthBloc>().add(AuthenticateUserEvent(onSuccess: (){
                                                              navigateToSeatLayout(context, selectedTiming );
                                                            }, onFailure: (){
                                                              Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: RoutesName.loginScreen),builder: (context){
                                                                return LogInScreen(onLogin: (bool isLogin){
                                                                  navigateToSeatLayout(context, selectedTiming);
                                                                });
                                                              }));
                                                            }));
                                                          },movieDetail: movie));
                                                    },
                                                    selectedShowTime: showTimeState.selectedTiming ?? const ShowTimeDetailsModel(),
                                                  );
                                                }).toList();
                                                return moviesInMall;
                                              })
                                              .expand( (widgetList) => widgetList)
                                              .toList()
                                          : []);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: showTimeState.showTimeData .showTimesData?[  showTimeState.selectedDate] ?.mallLocation    ?.entries .length ?? 0,
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToSeatLayout(BuildContext context, ShowTimeDetailsModel selectedTiming) {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.seatLayoutScreen,(route) => route.settings.name == RoutesName.showTimeScreen,
        arguments: {
          'cinemaId': selectedTiming?.cinemaId.toString(),
          'sessionId': selectedTiming?.sessionId,
          'ShowTimeData': MovieSelectionType.SHOW_TIME
        });
  }
}
