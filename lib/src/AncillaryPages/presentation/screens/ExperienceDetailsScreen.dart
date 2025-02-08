import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/entities/models/ExperienceModel.dart';
import 'package:novocinema/src/AncillaryPages/domain/models/AncillaryPagesModel.dart';
import 'package:novocinema/src/AncillaryPages/domain/models/ExperiencesModel.dart';

import '../../../../components/BackButtonNavbar.dart';
import '../bloc/AncillaryPagesBloc.dart';

class ExperienceDetailsScreen extends StatelessWidget {
  final int experienceId;

  const ExperienceDetailsScreen({super.key, required this.experienceId});

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
                  'Events',
                  style:
                      context.textThemeDecoration.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: body());
  }

  Widget body() {
    return BlocBuilder<AncillaryPagesBloc, AncillaryPagesState>(
      builder: (context, state) {
        AncillaryPagesDataModel? data;
        ExperiencesModel? experienceData;
        for (var element in state.experiencesData!.data) {
          final ExperiencesModel element2 = element.pageJson;
          if (experienceId == element2.ogId) {
            data = element;
            experienceData = element2;
            break;
          }
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SvgPicture.network(
                    experienceData!.banner,
                    height: context.getScreenHeight(30),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: context.getScreenWidth(80),
                        child: Text(data!.pageName,
                            overflow: TextOverflow.clip,
                            style: context.textThemeDecoration.titleLarge
                                .copyWith(color: context.colorPalette.accentColor)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.getScreenHeight(5)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(experienceData.descriptionTitle,
                        style: context.textThemeDecoration.subTitleLarge
                            .copyWith(color: context.colorPalette.accentColor)),
                    const SizedBox(height: 20),
                    Text(data.pageDesc, style: context.textThemeDecoration.paragraphLarge),
                    SizedBox(height: context.getScreenHeight(5)),
                    Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: SvgPicture.network(
                            experienceData.feature,
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: context.getScreenHeight(3)),
                            Text("You'll Enjoy",
                                style: context.textThemeDecoration.subTitleLarge.copyWith(
                                    color: context.colorPalette.accentColor, fontSize: 24)),
                            SizedBox(height: context.getScreenHeight(5)),
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 30,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 0.9),
                                itemCount: experienceData.featureArray.length,
                                itemBuilder: (context, index) =>
                                    featureCard(context, experienceData!.featureArray[index])),
                            SizedBox(height: context.getScreenHeight(5)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Image.network(data.)
            ],
          ),
        );
      },
    );
  }

  Widget featureCard(BuildContext context, FeatureModel data) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.network(
            data.icon,
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 10),
          Text(data.feature,
              style: context.textThemeDecoration.titleSmall
                  .copyWith(color: context.colorPalette.accentColor)),
          const SizedBox(height: 15),
          Text(data.desc, style: context.textThemeDecoration.paragraphLarge),
        ],
      ),
    );
  }
}
