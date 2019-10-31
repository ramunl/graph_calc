import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

import '../ui_utils.dart';

class GraphPainter extends CustomPainter {
  final CalcExpression calcExpression;

  GraphPainter(this.calcExpression);

  @override
  void paint(canvas, size) {
   drawAxis(canvas, size);

  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
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

  void drawAxisY(canvas, size) {
    final h = size.height;
    final w = size.width;
    final p1 = Offset(0, h);
    final p2 = Offset(w, h);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  void drawAxisX(canvas, size) {
    final h = size.height;
    final w = size.width;

    final p1 = Offset(0, 0);
    final p2 = Offset(0, h);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  void drawAxis(Canvas canvas, Size size) {
    drawAxisX(canvas, size);
    drawAxisY(canvas, size);

    const titleShift = 30.0;

    var offset = Offset(0, -titleShift);
    draAxisTitle(canvas, offset, size.width, calcExpression.getTitle());

    offset = Offset(size.width, size.height - titleShift);
    draAxisTitle(canvas, offset, size.width, variableSymbol);

    offset = Offset(-10, size.height);
    draAxisTitle(canvas, offset, size.width, "0");
  }
}
