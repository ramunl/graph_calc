// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/view/screens/calculator/expression_%D1%81alculate.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

import '../../localization.dart';
import 'graph_painter.dart';

class FuncPlotter extends StatelessWidget {
  final CalcExpression calcExpression;

  FuncPlotter(this.calcExpression, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(localizations.plotFuncTitle),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: GraphPainter(calcExpression),
          ),
        ));
  }
}
