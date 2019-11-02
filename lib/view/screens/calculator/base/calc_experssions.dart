import 'dart:ui';

import 'package:graph_calc/view/screens/calculator/model/calc_operation.dart';
import 'package:graph_calc/view/screens/calculator/model/expression_parser.dart';

import '../model/calc_expression.dart';

abstract class CalcExpressions {
  final List<CalcExpression> _expressionStack = <CalcExpression>[];
  CalcExpression _expression = CalcExpression.empty();

  CalcExpression get expression => _expression;

  // Make `expression` the current expression and push the previous current
  // expression onto the stack.
  void handleDelTap() {
    setState(() {
      popCalcExpression();
    });
  }

  void handleDivTap() {
    final CalcExpression expression =
        _expression.appendOperation(CalcOperation.Division);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handleEqualsTap() {
    final CalcExpression resultExpression = computeResult(_expression);
    if (resultExpression != null) {
      setState(() {
        setResult(resultExpression);
      });
    }
  }

  void handleMinusTap() {
    final CalcExpression expression = _expression.appendMinus();
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handleMultTap() {
    final CalcExpression expression =
        _expression.appendOperation(CalcOperation.Multiplication);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handleNumberTap(n) {
    final CalcExpression expression = _expression.appendDigit(n);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handlePlusTap() {
    final CalcExpression expression =
        _expression.appendOperation(CalcOperation.Addition);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handlePointTap() {
    final CalcExpression expression = _expression.appendPoint();
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handleRangeMax(num) {
    print("handleRangeMax $num");
    _expression.maxValue = num;
  }

  void handleRangeMin(num) {
    print("handleRangeMin $num");
    _expression.minValue = num;
  }

  void handleVariableTap() {
    final CalcExpression expression = _expression.appendVariable();
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  /// Pop the top expression off of the stack and make it the current expression.
  void popCalcExpression() {
    if (_expressionStack.isNotEmpty) {
      _expression = _expressionStack.removeLast();
    } else {
      _expression = CalcExpression.empty();
    }
  }

  void pushExpression(expression) {
    _expressionStack.add(_expression);
    _expression = expression;
  }

  /// Set `resultExpression` to the current expression and clear the stack.
  void setResult(resultExpression) {
    _expressionStack.clear();
    _expression = resultExpression;
  }

  void setState(VoidCallback fn);
}
