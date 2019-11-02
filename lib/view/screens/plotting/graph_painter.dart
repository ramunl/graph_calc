import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/plotting/model/AdaptivePlot.dart';

import '../ui_utils.dart';

class GraphPainter extends CustomPainter {
  final CalcExpression calcExpression;
  AdaptivePlot adaptivePlot;
  final graphPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2;

  GraphPainter(this.calcExpression) {
    adaptivePlot = AdaptivePlot.test();
    adaptivePlot.computePlot();
  }

  void draAxisTitle(canvas, offset, width, title) {
    final textStyle = ui.TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
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

  void drawAxis(Canvas canvas, zeroOffset) {
    drawAxisX(canvas, zeroOffset);
    drawAxisY(canvas, zeroOffset);

    const titleShift = 30.0;

    var offset = Offset(zeroOffset.dx, -titleShift);
    final rightBorder = zeroOffset.dx * 2;

    draAxisTitle(canvas, offset, rightBorder, calcExpression.getTitle());

    offset = Offset(rightBorder, zeroOffset.dy - titleShift);
    draAxisTitle(canvas, offset, rightBorder, variableSymbol);

    offset = Offset(zeroOffset.dx, zeroOffset.dy);
    draAxisTitle(canvas, offset, rightBorder, "0");
  }

  void drawAxisX(canvas, Offset zeroOffset) {
    final p1 = Offset(zeroOffset.dx, 0);
    final p2 = Offset(zeroOffset.dx, zeroOffset.dy * 2);
    canvas.drawLine(p1, p2, graphPaint);
  }

  void drawAxisY(canvas, Offset zeroOffset) {
    final p1 = Offset(0, zeroOffset.dy);
    final p2 = Offset(zeroOffset.dx * 2, zeroOffset.dy);
    canvas.drawLine(p1, p2, graphPaint);
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

  void plotFunc(canvas, zeroOffset) {
    final points = adaptivePlot.plot.toList(growable: true);
    var p1, p2;
    print("points.length = ${points.length}");
    print("points = ${points.join(",").toString()}");
    for (var i = 0; i < points.length - 1; i++) {
      p1 = zeroOffset + Offset(points[i].x, -points[i].y);
      p2 = zeroOffset + Offset(points[i + 1].x, -points[i + 1].y);
      canvas.drawLine(p1, p2, graphPaint);
    }
  }
}
