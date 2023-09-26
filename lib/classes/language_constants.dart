import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code

const String HINDI = 'hi';
const String ENGLISH = 'en';
const String FRENCH = 'fr';
const String SPANISH = 'es';
const String PORTUGUESE = 'pt';
const String INDONESIAN = 'id';
const String KOREAN = 'ko';
const String JAPANESE = 'ja';
const String RUSSIAN = 'ru';
const String LAO = 'lo';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case HINDI:
      return const Locale(HINDI, "");
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case FRENCH:
      return const Locale(FRENCH, "");
    case SPANISH:
      return const Locale(SPANISH, "");
    case PORTUGUESE:
      return const Locale(PORTUGUESE, "");
    case INDONESIAN:
      return const Locale(INDONESIAN, "");
    case KOREAN:
      return const Locale(KOREAN, "");
    case JAPANESE:
      return const Locale(JAPANESE, "");
    case RUSSIAN:
      return const Locale(RUSSIAN, "");
    case LAO:
      return const Locale(LAO, "");
    default:
      return const Locale(ENGLISH, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context);
}
