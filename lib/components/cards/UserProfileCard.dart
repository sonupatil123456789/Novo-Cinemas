import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/ImageConstants.dart';
import '../../core/theams/TextTheamStyle.dart';
import '../../di.dart';
import '../../src/Auth/data/dto/UserAuthDto.dart';
import '../../src/Auth/data/local/LocalDatasource.dart';
import '../../src/Auth/domain/models/UserAuthModel.dart';
import '../QrCodeGenerater.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({super.key});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {


  final BorderRadius borderRadius = BorderRadius.circular(12);


  UserAuthModel user = const UserAuthModel();

  getUserData() async {
    try{
      final localDataSource = getIt<AuthLocalDatasource>();
      final userData = await localDataSource.getUserData();
      setState(() {
        user = UserAuthDto.toDomainModel(userData);
      });
    }catch(error) {
      print(error);
    }
  }


  @override
  void initState() {
    getUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: context.getScreenHeight(25),
      width: context.getScreenWidth(100),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
                width: 1,
                color: context.colorPalette.accentColor.withOpacity(0.2))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.getScreenWidth(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap: (){

                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: '',
                      width: context.getScreenWidth(16),
                      height: context.getScreenWidth(16),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) {
                        return Shimmer.fromColors(
                            baseColor: context.colorPalette.shimmerBaseColor,
                            highlightColor: context.colorPalette.shimmerHighLightColor,
                            enabled: true,
                            child: Container(
                              color: context.colorPalette.accentColor,
                            ));
                      },
                      errorWidget: (context, url, error) => Image.asset(
                        ImageConstants.fallBackImage,
                        width: context.getScreenWidth(16),
                        height: context.getScreenWidth(16),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15,),


                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: context.textThemeDecoration.subTitleMedium.copyWith(
                            color: context.colorPalette.accentColor
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                          user.userName ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: context.textThemeDecoration.subTitleLarge.copyWith(
                              fontFamily: TextThemeDecoration.HamburgerFont
                          )
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            height: context.getScreenHeight(10),
            width: context.getScreenWidth(100),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                  side: BorderSide(
                      width: 1,
                      color: context.colorPalette.accentColor.withOpacity(0.2))),
            ),
            child: Row(

              children: [
                QrCodeGenerater(qrSize: context.getScreenHeight(8), data: "Data",),
                const SizedBox(width: 10,),
                Expanded(
                  child: Text(
                    "Scan the personal QR code for all the transactions",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textThemeDecoration.subTitleMedium.copyWith(
                        color: context.colorPalette.accentColor
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
