import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/components/AppBarSection.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/components/CustomButton.dart';
import 'package:novocinema/components/YutubePlayerDilaogBox.dart';
import 'package:novocinema/components/shimmerloaders/MovieDetailsShimmer.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Auth/presentation/bloc/AuthBloc.dart';
import 'package:novocinema/src/Auth/presentation/screens/LoginScreen.dart';
import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import 'package:novocinema/src/PrivateBooking/presentation/components/booking_stepper.dart';
import 'package:novocinema/src/PrivateBooking/presentation/components/private_moviedetails.dart';
import 'package:novocinema/src/PrivateBooking/presentation/components/private_movies.dart';
import 'package:novocinema/src/SeatLayout/presentation/components/BookingStepper.dart';

import '../../../../entities/models/ShowTimeDetailsModel.dart';

class PrivateBookingSteps extends StatefulWidget {
  const PrivateBookingSteps({super.key});

  @override
  State<PrivateBookingSteps> createState() => _PrivateBookingStepsState();
}

class _PrivateBookingStepsState extends State<PrivateBookingSteps> {
  int currentStep = 0;
  String movieId = "";
  String imageUrl = "";

  void onStepSelected(int step) {
    setState(() {
      currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: AppBarSection(screenIndex: 1),
      footer: currentStep == 1
          ? BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, movieState) {
                if (movieState.loading == CurrentAppState.SUCCESS ||
                    movieState.loading == CurrentAppState.ERROR) {
                  return Container(
                    color: context.colorPalette.backGroundColor,
                    width: context.getScreenWidth(100),
                    height: context.getScreenHeight(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          height: context.getScreenHeight(6),
                          backgroundColor:
                              context.colorPalette.transparentColor,
                          iconSpacing: 10,
                          text: 'Trailer',
                          textColor: context.colorPalette.accentColor,
                          onTap: () async {
                            showDialog(
                              context: context,
                              useRootNavigator: false,
                              builder: (context) {
                                return YutubePlayerDialogBox(
                                  title: movieState.movieDetails.movieTitle,
                                  trailerUrl:
                                      'https://youtu.be/8oIsZEhnqtA?si=IQC1e3IklVgx3MN6',
                                );
                              },
                            );
                          },
                          borderColor: Border.all(
                              color: context.colorPalette.accentColor,
                              width: 2.0),
                          width: context.getScreenWidth(30),
                          type: ButtonType.ICON_BUTTON,
                          icon: ImageConstants.playButton,
                        ),
                        CustomButton(
                          height: context.getScreenHeight(6),
                          backgroundColor: context.colorPalette.accentColor,
                          text: 'Continue',
                          textColor: context.colorPalette.darkGreyColor,
                          onTap: () {
                            if (movieState.selectedTiming != null &&
                                movieState.selectedTiming !=
                                    const ShowTimeDetailsModel()) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthenticateUserEvent(onSuccess: () {
                                    // navigateToSeatLayout(context, movieState);
                                  }, onFailure: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name: RoutesName.loginScreen),
                                            builder: (context) {
                                              return LogInScreen(
                                                  onLogin: (bool isLogin) {
                                                // navigateToSeatLayout(
                                                //     context, movieState);
                                              });
                                            }));
                                  }));
                            }
                          },
                          width: context.getScreenWidth(50),
                          isDisabled: movieState.selectedTiming != null &&
                                  movieState.selectedTiming !=
                                      const ShowTimeDetailsModel()
                              ? false
                              : true,
                        ),
                      ],
                    ),
                  );
                }
                return buttonShimmer(context, BorderRadius.circular(12));
              },
            )
          : null,
      body: Column(
        children: [
          SizedBox(height: context.getScreenHeight(3)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BookingStepperPrivate(
              currentStep: currentStep,
            ),
          ),
          SizedBox(height: context.getScreenHeight(5)),
          if (currentStep == 0)
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrivateMovies(
                      onMovieSelected: (MovieModel movie) {
                        setState(() {
                          currentStep = 1;
                          movieId = movie.movieId.toString();
                          imageUrl = movie.movieImageUrl ?? "";
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (currentStep == 1)
            Expanded(
              child: ListView(
                children: [
                  PrivateMovieDetailScreen(
                      movieId: movieId, imageUrl: imageUrl),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
