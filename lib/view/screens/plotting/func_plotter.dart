// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

import '../../../res/localization.dart';
import 'graph_painter.dart';

class FuncPlotter extends StatelessWidget {
  final CalcExpression calcExpression;

  FuncPlotter(this.calcExpression, {Key key}) : super(key: key);

  @override
  Widget build(context) {
    final localizations = GraphLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(localizations.screenTitlePlotFunc),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: GraphPainter(calcExpression),
          ),
        ));
  }
}
