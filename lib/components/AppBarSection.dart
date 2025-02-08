import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/dartassets/novoHeaderLogo.dart';
import 'package:novocinema/di.dart';
import 'package:novocinema/src/Auth/data/dto/UserAuthDto.dart';
import 'package:novocinema/src/Auth/domain/models/UserAuthModel.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/DatabaseKeyConstants.dart';
import '../core/constants/ImageConstants.dart';
import '../core/resources/SeassionManager.dart';
import '../core/resources/enums.dart';
import '../src/Auth/data/local/LocalDatasource.dart';
import '../src/Auth/presentation/bloc/AuthBloc.dart';
import '../src/Auth/presentation/screens/LoginScreen.dart';
import '../src/Home/presentation/components/QuickBookDialogBox.dart';
import 'CustomButton.dart';

class AppBarSection extends StatefulWidget {
  int screenIndex;
  AppBarSection({super.key, required this.screenIndex});

  @override
  State<AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<AppBarSection> {
  UserAuthModel user = const UserAuthModel();

  getData() async {
    try {
      final localDataSource = getIt<AuthLocalDatasource>();
      final userData = await localDataSource.getUserData();

      setState(() {
        user = UserAuthDto.toDomainModel(userData);
      });
    } catch (error) {
      print("Error in app bar =================$user========================");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.getScreenWidth(4)),
      // color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              SvgPicture.string(
                novoHeaderLogo(context),
                width: context.getScreenWidth(10),
                height: context.getScreenHeight(4),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.searchScreen);
                  },
                  child: SvgPicture.asset(ImageConstants.search,
                      width: context.getScreenWidth(6),
                      height: context.getScreenWidth(6))),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.sideBar);
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: '',
                    width: context.getScreenWidth(9),
                    height: context.getScreenWidth(9),
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor:
                              context.colorPalette.shimmerHighLightColor,
                          enabled: true,
                          child: Container(
                            color: context.colorPalette.accentColor,
                          ));
                    },
                    errorWidget: (context, url, error) => Image.asset(
                      ImageConstants.fallBackImage,
                      width: context.getScreenWidth(9),
                      height: context.getScreenWidth(9),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          // if (widget.screenIndex == 0) ...[
          //   BlocBuilder<HomeBloc, HomeState>(
          //     builder: (BuildContext context, HomeState homeState) {
          //       var isLoading =
          //           homeState.quickBookState == CurrentAppState.LOADING
          //               ? true
          //               : false;

          //       return CustomButton(
          //         height: context.getScreenHeight(6),
          //         backgroundColor: context.colorPalette.accentColor,
          //         text: isLoading ? 'Loading...' : 'Quick Book',
          //         textColor: context.colorPalette.darkGreyColor,
          //         onTap: () {
          //           showDialog(
          //             context: context,
          //             useRootNavigator: false,
          //             routeSettings: const RouteSettings(
          //                 name: RoutesName.seatLayoutScreen),
          //             builder: (context) {
          //               return const QuickBookDialogBox();
          //             },
          //           );
          //         },
          //         width: context.getScreenWidth(100),
          //         isDisabled: isLoading ? true : false,
          //       );
          //     },
          //   )
          // ]
        ],
      ),
    );
  }

  void navigateToUserProfile(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.userProfileScreen,
        (route) => route.settings.name == RoutesName.mainSection);
  }
}
