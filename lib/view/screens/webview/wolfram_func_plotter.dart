// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graph_calc/helper/consts.dart';
import 'package:graph_calc/helper/ui_utils.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../res/localization.dart';

class WolframFuncPlotter extends StatelessWidget {
  final CalcExpression calcExpression;

  WolframFuncPlotter(this.calcExpression, {Key key}) : super(key: key);

  @override
  Widget build(context) {
    final localizations = GraphLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.screenTitlePlotFunc),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
      ),
      body: WebView(
        initialUrl: getUrl(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  String getUrl() {
    final function = calcExpression.expressionTokenList
        .join(" ")
        .replaceAll(codeVariable, "x")
        .replaceAll(codePlus, "plus")
        .replaceAll(" ", "+");

    final range = calcExpression.getRange();
    final rangeParam = "${range[0]}<x<${range[1]}";
    final url =
        "${WOLFRAM_URL_BASE}appid=$WOLFRAM_APP_ID&i=plot+$function,$rangeParam";
    print("function $url");
    return url;
    //Plot[2 x + 4, {x, 0, 5}]
  }
}
