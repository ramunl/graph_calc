// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:graph_calc/mapper/expression_entity_mapper.dart';
import 'package:graph_calc/view/screens/calculator/base/expression_validate_result.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/expression_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/float_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/int_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/leading_neg_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/number_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/operation_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/result_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/variable_token.dart';

import '../../ui_utils.dart';
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
  final String id;

  /// The tokens comprising the expression.
  final List<ExpressionToken> expressionTokenList;

  /// The state of the expression.
  final ExpressionState state;

  num variableX = 0;
  num maxValue;
  num minValue;

  CalcExpression(
      this.expressionTokenList, this.state, this.minValue, this.maxValue)
      : id = generateEntityId();

  CalcExpression.empty()
      : this(<ExpressionToken>[], ExpressionState.Start, 0, 0);

  CalcExpression.expression(
      this.id, this.expressionTokenList, this.minValue, this.maxValue)
      : this.state = ExpressionState.Result;

  CalcExpression.result(this.expressionTokenList, FloatToken result)
      : id = generateEntityId(),
        state = ExpressionState.Result {
    expressionTokenList.add(result);
  }

  CalcExpression.withDefaultId(this.expressionTokenList)
      : this.id = generateEntityId(),
        this.state = ExpressionState.Result;

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

      case ExpressionState.Variable:
      case ExpressionState.Result:
        // Cannot enter a number now
        return null;
    }
    outList.add(newToken);
    return CalcExpression(outList, newState, minValue, maxValue);
  }

  /// Append a leading minus sign to the current expression and return a new
  /// expression representing the result. Returns null to indicate that it is not
  /// legal to append a leading minus sign in the current state.
  CalcExpression appendLeadingNeg() {
    switch (state) {
      case ExpressionState.Start:
        break;
      case ExpressionState.Variable:
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
    return CalcExpression(
        outList, ExpressionState.LeadingNeg, minValue, maxValue);
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
      case ExpressionState.Variable:
      case ExpressionState.Number:
      case ExpressionState.NumberWithPoint:
      case ExpressionState.Result:
        break;
    }
    final List<ExpressionToken> outList = expressionTokenList.toList();
    outList.add(OperationToken(op));
    return CalcExpression(outList, ExpressionState.Start, minValue, maxValue);
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
      case ExpressionState.Variable:
      case ExpressionState.Point:
      case ExpressionState.NumberWithPoint:
      case ExpressionState.Result:
        // Cannot enter a point now
        return null;
        // TODO: Handle this case.
        break;
    }
    outList.add(newToken);
    return CalcExpression(outList, ExpressionState.Point, minValue, maxValue);
  }

  CalcExpression appendVariable() {
    ExpressionState newState = ExpressionState.Variable;
    final List<ExpressionToken> outList = expressionTokenList.toList();
    var canBeAdded;
    CalcExpression res;
    if (outList.isEmpty || outList.last is OperationToken) {
      canBeAdded = true;
    } else {
      switch (state) {
        case ExpressionState.Start:
        case ExpressionState.LeadingNeg:
          canBeAdded = true;
          break;
        case ExpressionState.Number:
        case ExpressionState.Point:
        case ExpressionState.NumberWithPoint:
        case ExpressionState.Variable:
        case ExpressionState.Result:
          // Cannot add variable now.
          canBeAdded = false;
          break;
          // TODO: Handle this case.
          break;
      }
    }
    if (canBeAdded) {
      outList.add(VariableToken());
      res = CalcExpression(outList, newState, minValue, maxValue);
    }
    return res;
  }

  validateExpression() {
    var valid = false;
    var msg;
    if (maxValue > minValue) {
      final variableToken = expressionTokenList
          .firstWhere((el) => el is VariableToken, orElse: () => null);
      if (variableToken != null) {
        if (expressionTokenList.last is OperationToken) {
          msg = "Wrong expression!";
        } else {
          valid = true;
        }
      } else {
        msg = "The variable $variableSymbol is not added!";
      }
    } else {
      msg = "$variableSymbol range error. Max must be gretter than min!";
    }
    return ExpressionValidateResult(valid, msg);
  }

  getRange() => [minValue, maxValue];

  rangeAsStr() => ", range = ${getRange()}";

  getTitle() => "f($variableSymbol) = ${expressionTokenList.join()}";

  /// The string representation of the expression. This will be displayed
  /// in the calculator's display panel.
  @override
  String toString() {
    final StringBuffer buffer = StringBuffer('');
    buffer.writeAll(expressionTokenList);
    return buffer.toString();
  }
}
