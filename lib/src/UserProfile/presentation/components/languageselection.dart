import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'हिंदी', 'code': 'hi'},
    {'name': 'عربي', 'code': 'ar'},
    {'name': 'বাংলা', 'code': 'bn'},
    {'name': 'മലയാളം', 'code': 'ml'},
    {'name': 'తెలుగు', 'code': 'te'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: languages.map((language) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedLanguage = language['name']!;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                  color: context.colorPalette.accentColor.withOpacity(.20)),
              color: selectedLanguage == language['name']
                  ? context.colorPalette.accentColor
                  : context.colorPalette.accentColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language['name']!,
                  style: context.textThemeDecoration.paragraphLarge.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: selectedLanguage == language['name']
                        ? context.colorPalette.blackColor
                        : context.colorPalette.whiteColor,
                  ),
                ),
                Icon(
                  selectedLanguage == language['name']
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: selectedLanguage == language['name']
                      ? Colors.black
                      : context.colorPalette.accentColor.withOpacity(.4),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
