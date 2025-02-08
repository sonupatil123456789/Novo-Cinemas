import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/DirectFnB/presentation/bloc/DirectF&BBloc.dart';
import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../F&B/presentation/screens/FAndBScreen.dart';

class CinemaLocationCard extends StatelessWidget {
  final CinemaLocationModel data;

  const CinemaLocationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DirectFAndBBloc>().add(SelectedCinemaLocation(cinemaLocation: data));
        Navigator.pushNamed(context, RoutesName.directFnBSelectionScreen, arguments: {
          'reservationId': '',
          'cinemaId': data.id.toString(),
          'sessionId': "",
          'postConcessionUrl': ApiUrlConstants.postAllOnlyFoodAndBevRage,
          'fAndBType': FAndBType.TAKEAWAY_FNB
        });
      },
      child: Container(
        width: context.getScreenWidth(100),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: context.colorPalette.accentColor.withOpacity(0.2))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: context.colorPalette.textColor.withOpacity(0.12))),
              child: SvgPicture.asset(ImageConstants.novoLogo),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.language.getApiText(data.name, data.nameAr),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleMedium
                          .copyWith(color: context.colorPalette.accentColor)),
                  const SizedBox(height: 5),
                  Text(
                      context.language.getApiText(data.address, data.addressAr),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleMedium
                          .copyWith(fontSize: 14)),
                  const SizedBox(height: 10),
                  Text("Distance:",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleMedium
                          .copyWith(
                              fontSize: 14,
                              color: context.colorPalette.lightGreyColor
                                  .withOpacity(0.8))),
                  Text("",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleMedium
                          .copyWith(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
