import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../app.dart';

class AppLocalizations {
  final BuildContext context;

  AppLocalizations(this.context);

  // call this method only firstTime when open app You can see splash_screen.dart
  Future<void> load() async {
    final List<Map<String, String>> allTexts = [];

    List<dynamic> jsonData = json.decode(
      await DefaultAssetBundle.of(context)
          .loadString('lib/language/lang/language_text.json'),
    );

    jsonData.forEach((value) {
      if (value is Map && value['text_id'] != null) {
        Map<String, String> texts = {};
        texts['text_id'] = value['text_id'] ?? '';
        texts['en'] = value['en'] ?? '';
        texts['fr'] = value['fr'] ?? '';
        texts['ar'] = value['ar'] ?? '';
        texts['ja'] = value['ja'] ?? '';
        allTexts.add(texts);
      }
    });

  }



  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localization = AppLocalizations(applicationcontext!);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
