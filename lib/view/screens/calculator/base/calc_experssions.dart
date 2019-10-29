import 'dart:ui';

import '../../logic.dart';

abstract class CalcExpressions {
  final List<CalcExpression> _expressionStack = <CalcExpression>[];
  CalcExpression _expression = CalcExpression.empty();

  CalcExpression get expression => _expression;

  // Make `expression` the current expression and push the previous current
  // expression onto the stack.
  void pushExpression(CalcExpression expression) {
    _expressionStack.add(_expression);
    _expression = expression;
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
  void setResult(CalcExpression resultExpression) {
    _expressionStack.clear();
    _expression = resultExpression;
  }

  void handleNumberTap(int n) {
    final CalcExpression expression = _expression.appendDigit(n);
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

  void handlePlusTap() {
    final CalcExpression expression =
        _expression.appendOperation(Operation.Addition);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
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
        _expression.appendOperation(Operation.Multiplication);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handleDivTap() {
    final CalcExpression expression =
        _expression.appendOperation(Operation.Division);
    if (expression != null) {
      setState(() {
        pushExpression(expression);
      });
    }
  }

  void handleEqualsTap() {
    final CalcExpression resultExpression = _expression.computeResult();
    if (resultExpression != null) {
      setState(() {
        setResult(resultExpression);
      });
    }
  }

  void handleDelTap() {
    setState(() {
      popCalcExpression();
    });
  }

  void setState(VoidCallback fn);
}
