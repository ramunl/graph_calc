import 'dart:ui';

import 'package:graph_calc/view/screens/calculator/model/calc_operation.dart';
import 'package:graph_calc/view/screens/calculator/model/expr_parser.dart';
import 'package:graph_calc/view/screens/ui_utils.dart';

import '../model/calc_expression.dart';

abstract class CalcExpressions {
  final List<CalcExpression> _expressionStack = <CalcExpression>[];
  CalcExpression _expression = CalcExpression.empty();

  num maxValue() => expression.expressionState.maxValue;
  num minValue() => expression.expressionState.minValue;

  get expression => _expression;

  // Make `expression` the current expression and push the previous current
  // expression onto the stack.
  void handleDelTap() {
    setState(() {
      popCalcExpression();
    });
  }

  void handleEqualsTap() {
    final exprParser = ExprParser();
    final res = exprParser.parse(_expression);
    print("_expression res = $res");
    /*final CalcExpression resultExpression = computeResult(_expression);
    /if (resultExpression != null) {
      setState(() {
        setResult(resultExpression);
      });
    }*/
  }

  void handleDivTap() {
    appendOperation(CalcOperation.Division);
  }

  void handleMinusTap() {
    pushExpression(_expression.appendMinus());
  }

  void handleMultTap() {
    appendOperation(CalcOperation.Multiplication);
  }

  void handleBracketOpenTap() {
    pushExpression(_expression.appendBracketOpen());
  }

  void handleBracketCloseTap() {
    pushExpression(_expression.appendBracketClose());
  }

  void handleSqrtTap() {
    appendOperation(CalcOperation.Sqrt);
  }

  void handlePlusTap() {
    appendOperation(CalcOperation.Addition);
  }

  void handleNumberTap(n) {
    pushExpression(_expression.appendDigit(n));
  }

  void handlePointTap() {
    pushExpression(_expression.appendPoint());
  }

  void handleRangeMax(num) {
    print("handleRangeMax $num");
    _expression.expressionState.maxValue = num;
  }

  void handleRangeMin(num) {
    print("handleRangeMin $num");
    _expression.expressionState.minValue = num;
  }

  void handleVariableTap() {
    pushExpression(_expression.appendVariable());
  }

  void appendOperation(CalcOperation calcOperation) {
    pushExpression(_expression.appendOperation(calcOperation));
  }

  void pushExpression(CalcExpression expressionTemp) {
    if (expressionTemp != null) {
      setState(() {
        _expressionStack.add(_expression.copy());
        _expression = expressionTemp;
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

  /// Set `resultExpression` to the current expression and clear the stack.
  void setResult(resultExpression) {
    _expressionStack.clear();
    _expression = resultExpression;
  }

  void setState(VoidCallback fn);
}
