// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../messages_all.dart';

class ArchSampleLocalizations {
  final Locale locale;

  ArchSampleLocalizations(this.locale);

  String get screenTitleHistory => Intl.message(
    'History',
    name: 'history',
    args: [],
    locale: locale.toString(),
  );

  String get screenTitleAddFunction => Intl.message(
    'Add function',
    name: 'addFunction',
    args: [],
    locale: locale.toString(),
  );

  String get screenTitlePlotFunc => Intl.message(
    'Func plotting',
    name: 'plotFunc',
    args: [],
    locale: locale.toString(),
  );

  String get commandAddFunc => Intl.message(
    'Add Function',
    name: 'addFunction',
    args: [],
    locale: locale.toString(),
  );


  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(
        context, ArchSampleLocalizations);
  }
}

class ArchSampleLocalizationsDelegate
    extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");

  @override
  Future<ArchSampleLocalizations> load(Locale locale) =>
      ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;
}

class ReduxLocalizations {
  String get appTitle => "Func calculator";

  static ReduxLocalizations of(BuildContext context) {
    return Localizations.of<ReduxLocalizations>(
      context,
      ReduxLocalizations,
    );
  }
}

class ReduxLocalizationsDelegate
    extends LocalizationsDelegate<ReduxLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");

  @override
  Future<ReduxLocalizations> load(Locale locale) =>
      Future(() => ReduxLocalizations());

  @override
  bool shouldReload(ReduxLocalizationsDelegate old) => false;
}
