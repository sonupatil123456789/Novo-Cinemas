import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/AncillaryPages/domain/models/AncillaryPagesModel.dart';
import 'package:novocinema/src/AncillaryPages/presentation/bloc/AncillaryPagesBloc.dart';
import 'package:novocinema/src/AncillaryPages/presentation/bloc/AncillaryPagesBloc.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_state.dart';

class ExperiencesScreen extends StatelessWidget {
  const ExperiencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(ImageConstants.experienceHeader),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Experiences @\nNovo Cinemas",
                      style: context.textThemeDecoration.titleLarge
                          .copyWith(color: context.colorPalette.accentColor, fontSize: 24)),
                ),
              )
            ],
          ),
          SizedBox(height: context.getScreenHeight(5)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<CinemaExperienceBloc, CinemaExperienceState>(
                  builder: (context, state) {
                if (state.cinemaExperienceState == CurrentAppState.SUCCESS) {
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.6),
                      itemCount: state.cinemaExperiences.length,
                      itemBuilder: (context, index) =>
                          experienceCard(state.cinemaExperiences[index]));
                }
                if (state.cinemaExperienceState == CurrentAppState.ERROR) {
                  return const Center(child: Text("Unable to Load Data"));
                }
                if (state.cinemaExperienceState == CurrentAppState.LOADING) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              })),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: BlocBuilder<AncillaryPagesBloc, AncillaryPagesState>(
          //     builder: (context, state) {
          //       if (state.loading == CurrentAppState.SUCCESS) {
          //         GridView.builder(
          //             shrinkWrap: true,
          //             physics: const NeverScrollableScrollPhysics(),
          //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 2,
          //                 mainAxisSpacing: 30,
          //                 crossAxisSpacing: 20,
          //                 childAspectRatio: 0.9),
          //             itemCount: experienceData.featureArray.length,
          //             itemBuilder: (context, index) =>
          //                 featureCard(context, experienceData.featureArray[index]))
          //       ,
          //       }
          //       if (state.loading == CurrentAppState.ERROR) {
          //       return const Center(child: Text("Unable to Load Data"));
          //       }
          //       if (state.loading == CurrentAppState.LOADING) {
          //       return const Center(
          //       child: CircularProgressIndicator(),
          //       );
          //       }
          //       return
          //       const
          //       SizedBox
          //       (
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget experienceCard(CinemaExperienceModel data) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.experiencesDetailScreen, arguments: {
            'id': data.experienceId,
          });
        },
        child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.network(data.experienceImageUrl, fit: BoxFit.fill)),
      );
    });
  }
}
