import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';

class BottomNavigationBarSection extends StatelessWidget {
  Function(int index) item;
  int selectedItem = 0;

  BottomNavigationBarSection(
      {super.key, required this.item, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.getScreenWidth(100),
      height: context.getScreenHeight(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.isDarkMode
              ? const [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(140, 0, 0, 0),
                  Color.fromARGB(80, 0, 0, 0),
                  Colors.transparent,
                ]
              : const [
                  Color.fromARGB(255, 255, 255, 255),
                  // Inverted from black (255, 0, 0, 0)
                  Color.fromARGB(200, 255, 255, 255),
                  // Inverted from (200, 0, 0, 0)
                  Color.fromARGB(135, 255, 255, 255),
                  // Inverted from (135, 0, 0, 0)
                  Color.fromARGB(135, 255, 250, 250),
                  // Inverted from (80, 0, 0, 0)
                  Colors.transparent,
                ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.0, 0.6, 0.80, 0.90, 1.0],
        ),
      ),
      child: ListView.separated(
        itemCount: bottomBar.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final bottombarItem = bottomBar[index];
          return InkWell(
              onTap: () {
                item(index);
              },
              child: SizedBox(
                // color: Colors.greenAccent,
                width: context.getScreenWidth(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      bottombarItem.icon,
                      width: context.getScreenWidth(5.2),
                      height: context.getScreenWidth(5.2),
                      colorFilter: ColorFilter.mode(
                          selectedItem == index
                              ? context.colorPalette.accentColor
                              : context.colorPalette.lightGreyColor,
                          BlendMode.srcIn),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      bottombarItem.title,
                      style: context.textThemeDecoration.paragraphSmall
                          .copyWith(
                              color: selectedItem == index
                                  ? context.colorPalette.accentColor
                                  : context.colorPalette.lightGreyColor),
                    ),
                  ],
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: context.getScreenWidth(4),
          );
        },
      ),
    );
  }
}

List<BottomBarItems> bottomBar = [
  BottomBarItems("Home", ImageConstants.navigationItem0),
  BottomBarItems("Direct F&B", ImageConstants.navigationItem2),
  BottomBarItems("Offers", ImageConstants.navigationItem1),
  BottomBarItems("Experiences", ImageConstants.navigationItem5),
  BottomBarItems("Private Booking", ImageConstants.navigationItem4),
];

class BottomBarItems {
  String title;
  String icon;

  BottomBarItems(this.title, this.icon);
}
