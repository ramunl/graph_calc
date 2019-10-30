// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:graph_calc/mapper/expression_entity_mapper.dart';
import 'package:graph_calc/store/expression_entity.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/expression_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/float_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/int_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/leading_neg_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/number_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/operation_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/result_token.dart';

import 'calc_operation.dart';
import 'expression_state.dart';

/// An expression that can be displayed in a calculator. It is the result
/// of a sequence of user entries. It is represented by a sequence of tokens.
///
/// The tokens are not in one to one correspondence with the key taps because we
/// use one token per number, not one token per digit. A [CalcExpression] is
/// immutable. The `append*` methods return a new [CalcExpression] that
/// represents the appropriate expression when one additional key tap occurs.
class CalcExpression {
  CalcExpression(this.expressionTokenList, this.state)
      : id = generateEntityId();

  CalcExpression.withDefaultId(List<ExpressionToken> expressionTokenList)
      : this.id = generateEntityId(),
        this.expressionTokenList = expressionTokenList,
        this.state = ExpressionState.Result;

  CalcExpression.expression(
      String id, List<ExpressionToken> expressionTokenList)
      : this.id = id,
        this.expressionTokenList = expressionTokenList,
        this.state = ExpressionState.Result;

  CalcExpression.empty() : this(<ExpressionToken>[], ExpressionState.Start);

  CalcExpression.result(FloatToken result)
      : id = generateEntityId(),
        expressionTokenList = <ExpressionToken>[],
        state = ExpressionState.Result {
    expressionTokenList.add(result);
  }

  final String id;

  /// The tokens comprising the expression.
  final List<ExpressionToken> expressionTokenList;

  /// The state of the expression.
  final ExpressionState state;

  num maxValue;
  num minValue;

  setRange(num minValue, num maxValue) {
    this.minValue = minValue;
    this.maxValue = maxValue;
  }

  getRange() => [minValue, maxValue];

  /// The string representation of the expression. This will be displayed
  /// in the calculator's display panel.
  @override
  String toString() {
    final StringBuffer buffer = StringBuffer('');
    buffer.writeAll(expressionTokenList);
    return buffer.toString();
  }

  /// Append a digit to the current expression and return a new expression
  /// representing the result. Returns null to indicate that it is not legal
  /// to append a digit in the current state.
  CalcExpression appendDigit(int digit) {
    ExpressionState newState = ExpressionState.Number;
    ExpressionToken newToken;
    final List<ExpressionToken> outList = expressionTokenList.toList();
    switch (state) {
      case ExpressionState.Start:
        // Start a new number with digit.
        newToken = IntToken('$digit');
        break;
      case ExpressionState.LeadingNeg:
        // Replace the leading neg with a negative number starting with digit.
        outList.removeLast();
        newToken = IntToken('-$digit');
        break;
      case ExpressionState.Number:
        final ExpressionToken last = outList.removeLast();
        newToken = IntToken('${last.stringRep}$digit');
        break;
      case ExpressionState.Point:
      case ExpressionState.NumberWithPoint:
        final ExpressionToken last = outList.removeLast();
        newState = ExpressionState.NumberWithPoint;
        newToken = FloatToken('${last.stringRep}$digit');
        break;
      case ExpressionState.Result:
        // Cannot enter a number now
        return null;
    }
    outList.add(newToken);
    return CalcExpression(outList, newState);
  }

  /// Append a point to the current expression and return a new expression
  /// representing the result. Returns null to indicate that it is not legal
  /// to append a point in the current state.
  CalcExpression appendPoint() {
    ExpressionToken newToken;
    final List<ExpressionToken> outList = expressionTokenList.toList();
    switch (state) {
      case ExpressionState.Start:
        newToken = FloatToken('.');
        break;
      case ExpressionState.LeadingNeg:
      case ExpressionState.Number:
        final ExpressionToken last = outList.removeLast();
        newToken = FloatToken(last.stringRep + '.');
        break;
      case ExpressionState.Point:
      case ExpressionState.NumberWithPoint:
      case ExpressionState.Result:
        // Cannot enter a point now
        return null;
    }
    outList.add(newToken);
    return CalcExpression(outList, ExpressionState.Point);
  }

  /// Append an operation symbol to the current expression and return a new
  /// expression representing the result. Returns null to indicate that it is not
  /// legal to append an operation symbol in the current state.
  CalcExpression appendOperation(CalcOperation op) {
    switch (state) {
      case ExpressionState.Start:
      case ExpressionState.LeadingNeg:
      case ExpressionState.Point:
        // Cannot enter operation now.
        return null;
      case ExpressionState.Number:
      case ExpressionState.NumberWithPoint:
      case ExpressionState.Result:
        break;
    }
    final List<ExpressionToken> outList = expressionTokenList.toList();
    outList.add(OperationToken(op));
    return CalcExpression(outList, ExpressionState.Start);
  }

  /// Append a leading minus sign to the current expression and return a new
  /// expression representing the result. Returns null to indicate that it is not
  /// legal to append a leading minus sign in the current state.
  CalcExpression appendLeadingNeg() {
    switch (state) {
      case ExpressionState.Start:
        break;
      case ExpressionState.LeadingNeg:
      case ExpressionState.Point:
      case ExpressionState.Number:
      case ExpressionState.NumberWithPoint:
      case ExpressionState.Result:
        // Cannot enter leading neg now.
        return null;
    }
    final List<ExpressionToken> outList = expressionTokenList.toList();
    outList.add(LeadingNegToken());
    return CalcExpression(outList, ExpressionState.LeadingNeg);
  }

  /// Append a minus sign to the current expression and return a new expression
  /// representing the result. Returns null to indicate that it is not legal
  /// to append a minus sign in the current state. Depending on the current
  /// state the minus sign will be interpreted as either a leading negative
  /// sign or a subtraction operation.
  CalcExpression appendMinus() {
    switch (state) {
      case ExpressionState.Start:
        return appendLeadingNeg();
      case ExpressionState.LeadingNeg:
      case ExpressionState.Point:
      case ExpressionState.Number:
      case ExpressionState.NumberWithPoint:
      case ExpressionState.Result:
        return appendOperation(CalcOperation.Subtraction);
      default:
        return null;
    }
  }

  /// Computes the result of the current expression and returns a new
  /// ResultExpression containing the result. Returns null to indicate that
  /// it is not legal to compute a result in the current state.
  CalcExpression computeResult() {
    switch (state) {
      case ExpressionState.Start:
      case ExpressionState.LeadingNeg:
      case ExpressionState.Point:
      case ExpressionState.Result:
        // Cannot compute result now.
        return null;
      case ExpressionState.Number:
      case ExpressionState.NumberWithPoint:
        break;
    }

    // We make a copy of _list because CalcExpressions are supposed to
    // be immutable.
    final List<ExpressionToken> list = expressionTokenList.toList();
    // We obey order-of-operations by computing the sum of the 'terms',
    // where a "term" is defined to be a sequence of numbers separated by
    // multiplication or division symbols.
    num currentTermValue = removeNextTerm(list);
    while (list.isNotEmpty) {
      final OperationToken opToken = list.removeAt(0);
      final num nextTermValue = removeNextTerm(list);
      switch (opToken.operation) {
        case CalcOperation.Addition:
          currentTermValue += nextTermValue;
          break;
        case CalcOperation.Subtraction:
          currentTermValue -= nextTermValue;
          break;
        case CalcOperation.Multiplication:
        case CalcOperation.Division:
          // Logic error.
          assert(false);
      }
    }
    final List<ExpressionToken> outList = <ExpressionToken>[
      ResultToken(currentTermValue),
    ];
    return CalcExpression(outList, ExpressionState.Result);
  }

  /// Removes the next "term" from `list` and returns its numeric value.
  /// A "term" is a sequence of number tokens separated by multiplication
  /// and division symbols.
  static num removeNextTerm(List<ExpressionToken> list) {
    assert(list != null && list.isNotEmpty);
    final NumberToken firstNumToken = list.removeAt(0);
    num currentValue = firstNumToken.number;
    while (list.isNotEmpty) {
      bool isDivision = false;
      final OperationToken nextOpToken = list.first;
      switch (nextOpToken.operation) {
        case CalcOperation.Addition:
        case CalcOperation.Subtraction:
          // We have reached the end of the current term
          return currentValue;
        case CalcOperation.Multiplication:
          break;
        case CalcOperation.Division:
          isDivision = true;
      }
      // Remove the operation token.
      list.removeAt(0);
      // Remove the next number token.
      final NumberToken nextNumToken = list.removeAt(0);
      final num nextNumber = nextNumToken.number;
      if (isDivision)
        currentValue /= nextNumber;
      else
        currentValue *= nextNumber;
    }
    return currentValue;
  }
}
