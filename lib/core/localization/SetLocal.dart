import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novocinema/core/localization/languages/Arabic.dart';
import 'package:novocinema/core/localization/languages/English.dart';

import 'LocalConfig.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': englishLanguage,
    'ar': arabicLanguage
  };

  // String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;

  String getText(String key) {
    return _localizedValues[locale.languageCode]![key]!;
  }

  String getApiText(String? english ,String? arabic) {
    if(locale.languageCode == 'en'){
      return english ?? '' ;
    }else{
      // return arabic ?? '';
      return  'توب غان مافريك';
    }
  }



}