import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/calculator/model/expr_parser.dart';
import 'package:graph_calc/view/screens/plotting/model/AdaptivePlot.dart';

import '../../../helper/ui_utils.dart';

class GraphPainter extends CustomPainter {
  final exprParser = ExprParser();
  final CalcExpression calcExpression;
  AdaptivePlot adaptivePlot;

  final axisPaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1;

  final graphPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2;

  final textStyle = ui.TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  GraphPainter(this.calcExpression) {
    print("GraphPainter");
  }

  void draText(canvas, offset, width, title) {
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(title);
    final constraints = ui.ParagraphConstraints(width: width);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    canvas.drawParagraph(paragraph, offset);
  }

  void drawAxis(Canvas canvas, Offset zeroOffset) {
    //drawAxisX(canvas, zeroOffset, calcExpression.getRange());
    drawAxisX(canvas, zeroOffset, calcExpression.getRange());
    var textPos = Offset(0, 0);
    final rightBorder = zeroOffset.dx * 2;
    draText(canvas, textPos, rightBorder, calcExpression.getTitle());
    textPos = Offset(rightBorder, zeroOffset.dy - 30);
    draText(canvas, textPos, rightBorder, codeVariable);

    //textPos = Offset(zeroOffset.dx, zeroOffset.dy);
    // draText(canvas, textPos, rightBorder, "0");
  }

  //          |
  //          |
  //          |
  //----------------------
  //0         |w/2       w
  //          |
  //          |
  //          |
  //          |
  // w - maxVal
  // x - ?
  // 0 - minVal

  /* void drawAxisX(canvas, Offset zeroOffset, range) {
    print("range = $range");
    final p1 = Offset(zeroOffset.dx, 0);
    final p2 = Offset(zeroOffset.dx, zeroOffset.dy * 2);
    canvas.drawLine(p1, p2, graphPaint);
    var textPos = Offset(0, zeroOffset.dy);

    final screenW = zeroOffset.dx * 2;

    draText(canvas, textPos, screenW, range[0].toString());

    textPos = Offset(screenW, zeroOffset.dy);

    draText(canvas, textPos, screenW, range[1].toString());
  }*/

  //          |
  //          |
  //          |
  //----------------------
  //0         |w/2       w
  //          |
  //          |
  //          |
  //          |
  // w - maxVal
  // x - ?
  // 0 - minVal

  void drawAxisX(canvas, Offset zeroOffset, range) {
    final p1 = Offset(0, zeroOffset.dy);
    final p2 = Offset(zeroOffset.dx * 2, zeroOffset.dy);
    canvas.drawLine(p1, p2, axisPaint);

    var textPos = Offset(0, zeroOffset.dy);

    final screenW = zeroOffset.dx * 2;

    draText(canvas, textPos, screenW, range[0].toString());

    textPos = Offset(screenW, zeroOffset.dy);

    draText(canvas, textPos, screenW, range[1].toString());
  }

  @override
  void paint(canvas, Size size) {
    final zeroOffset = Offset(size.width / 2, size.height / 2);
    drawAxis(canvas, zeroOffset);
    plotFunc(canvas, zeroOffset);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

  void plotFunc(canvas, Offset zeroOffset) {
    final exprState = calcExpression.expressionState;
    //zeroOffset.x*2  - maxVal
    //x             - points[i].x
    final maxW = zeroOffset.dx * 2.0;
    final maxH = zeroOffset.dy * 2.0;

    final stepX = maxW / (exprState.maxValue - exprState.minValue);
    // maxVal  - maxW
    //      -
    exprParser.parse(calcExpression);
    adaptivePlot = AdaptivePlot(exprParser.testFun, exprState.minValue * stepX,
        exprState.maxValue * stepX, maxW);

    adaptivePlot.computePlot();

    final points = adaptivePlot.plot.toList(growable: true);
    final plotH = adaptivePlot.maxY - adaptivePlot.minY;
    final stepY = maxH / plotH/2;
    print("plot maxY = ${adaptivePlot.maxY} minY = ${adaptivePlot.minY} stepY = $stepY");

    var p1, p2;
    print("points.length = ${points.length}");
    //final range = calcExpression.getRange();

    for (var i = 0; i < points.length - 1; i++) {
      p1 = zeroOffset +
          Offset(
              points[i].x.toDouble(), -points[i].y.toDouble() * stepY);
      p2 = zeroOffset +
          Offset(points[i + 1].x.toDouble(),
              -points[i + 1].y.toDouble() * stepY);

      if (p2.dx > 0 && p1.dx < maxW && p1.dy < maxH && p2.dy < maxH) {
        canvas.drawLine(p1, p2, graphPaint);
      }
    }
  }
}
