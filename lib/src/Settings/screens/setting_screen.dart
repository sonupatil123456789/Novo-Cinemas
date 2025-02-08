import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/components/BackButtonNavbar.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: Container(
          height: double.infinity,
          child: Row(
            children: [
              Text(
                'Settings',
                style: context.textThemeDecoration.titleSmall
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          ListView(shrinkWrap: true, children: [
            ...List.generate(sideNavigationBar.length, (index) {
              final setting = sideNavigationBar[index];
              return sideBarCard(
                  context: context,
                  onPress: () {
                    Navigator.pushNamed(context, setting.navigationRouteName);
                  },
                  name: setting.title,
                  icon: setting.iconAsset,
                  colour: context.colorPalette.whiteColor);
            }),
          ]),
        ]),
      ),
    );
  }

  Widget sideBarCard(
      {required BuildContext context,
      required Function onPress,
      required String name,
      required String icon,
      required Color colour}) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: context.getScreenWidth(100),
          height: context.getScreenHeight(6),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: context.colorPalette.lightGreyColor.withOpacity(0.6),
                    width: 0.6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                icon,
                width: context.getScreenWidth(5),
                height: context.getScreenWidth(5),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: context.textThemeDecoration.subTitleSmall.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w400, color: colour),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                size: context.getScreenWidth(5),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<SideNavigationData> sideNavigationBar = [
  SideNavigationData('Location', ImageConstants.currentLocation,
      RoutesName.locationsScreen, false),
];

class SideNavigationData {
  String title;
  String iconAsset;
  String navigationRouteName;
  bool requiredAuth;

  SideNavigationData(
      this.title, this.iconAsset, this.navigationRouteName, this.requiredAuth);
}
