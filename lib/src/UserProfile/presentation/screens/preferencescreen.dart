import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/UserProfile/presentation/components/languageselection.dart';

class Preferencescreen extends StatefulWidget {
  const Preferencescreen({super.key});

  @override
  State<Preferencescreen> createState() => _PreferencescreenState();
}

class _PreferencescreenState extends State<Preferencescreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(
              color: context.colorPalette.accentColor.withOpacity(.20),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Personal details",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(
              height: context.getScreenHeight(.5),
            ),
            Divider(color: context.colorPalette.accentColor, thickness: 1),
            SizedBox(
              height: context.getScreenHeight(3),
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: context.colorPalette.accentColor,
                        )),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.face),
                        Text("Horror"),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: context.getScreenHeight(4),
            ),
            Text("Favourite Language",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(
              height: context.getScreenHeight(.5),
            ),
            const Divider(color: Colors.yellow, thickness: 1),
            SizedBox(
              height: context.getScreenHeight(3),
            ),
            const LanguageSelection(),
            SizedBox(
              height: context.getScreenHeight(4),
            ),
            Text(
              "Favorite cinema",
              style: context.textThemeDecoration.titleMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: context.colorPalette.accentColor,
              ),
            ),
            SizedBox(
              height: context.getScreenHeight(.5),
            ),
            const Divider(color: Colors.yellow, thickness: 1),
            SizedBox(
              height: context.getScreenHeight(3),
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: context.colorPalette.accentColor,
                        borderRadius: BorderRadius.circular(14)),
                  );
                })
          ],
        ),
      ),
    );
  }
}
