import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get detailRate => "Comments";
  String get dialogLoading => "Loading ...";
  String get hello => "Hello";
  String get homeEmptyList => "No results";
  String get homeRecommend => "Recommend";
  String get homeSearchHint => "Search ...";
  String get title => "Hello world App";
}

class $de extends S {
  const $de();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get homeSearchHint => "Suche ...";
  @override
  String get dialogLoading => "Wird geladen ...";
  @override
  String get homeEmptyList => "Keine Ergebnisse";
  @override
  String get hello => "Hello De";
  @override
  String get detailRate => "Bemerkungen";
  @override
  String get title => "Hello world De";
  @override
  String get homeRecommend => "Empfehlen";
}

class $zh_TW extends S {
  const $zh_TW();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get homeSearchHint => "搜索 ...";
  @override
  String get dialogLoading => "載入中 ...";
  @override
  String get homeEmptyList => "沒有結果";
  @override
  String get hello => "Hello";
  @override
  String get detailRate => "評論";
  @override
  String get title => "Hello world App";
  @override
  String get homeRecommend => "推介";
}

class $ja extends S {
  const $ja();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get homeSearchHint => "検索 ...";
  @override
  String get dialogLoading => "読み込み中 ...";
  @override
  String get homeEmptyList => "結果なし";
  @override
  String get hello => "Hello";
  @override
  String get detailRate => "コメント";
  @override
  String get title => "Hello world アプリ";
  @override
  String get homeRecommend => "おすすめ";
}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("de", ""),
      Locale("zh", "TW"),
      Locale("ja", ""),
      Locale("en", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "de":
          return SynchronousFuture<S>(const $de());
        case "zh_TW":
          return SynchronousFuture<S>(const $zh_TW());
        case "ja":
          return SynchronousFuture<S>(const $ja());
        case "en":
          return SynchronousFuture<S>(const $en());
        default:
          // NO-OP.
      }
    }
    return SynchronousFuture<S>(const S());
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
