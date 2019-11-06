// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graph_calc/helper/ui_utils.dart';
import 'package:graph_calc/res/dimens.dart';
import 'package:graph_calc/view/screens/settings/prefs.dart';

import '../../../res/localization.dart';

class AppSettings extends StatefulWidget {
  @override
  AppSettingsState createState() => AppSettingsState();
}

class AppSettingsState extends State<AppSettings> {
  @override
  void initState() {
    print("initState");
    getBool(KEY_USE_WOLFRAM_API).then(updateState);
    print("super.initState");
    super.initState();
  }

  bool _useApiFlag = false;

  void updateState(bool useApiFlag) {
    print("updateState $useApiFlag");
    setState(() {
      _useApiFlag = useApiFlag;
    });
  }

  @override
  Widget build(context) {
    print("Settings State build");
    final localizations = GraphLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(localizations.screenTitleSettings),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.only(left: HORIZONTAL_PADDING, right: HORIZONTAL_PADDING),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _useApiFlag,
                  onChanged: (bool value) {
                    setBool(KEY_USE_WOLFRAM_API, value);
                    updateState(value);
                  },
                ),
                Text(
                  'To use Wolframalpha API',
                  style: TextStyle(fontSize: getFontSize(context)),
                ),
              ],
            )));
  }
}
