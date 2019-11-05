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

import '../../../../helper/ui_utils.dart';
import 'calc_operation.dart';
import 'expression_state.dart';
import 'expression_last_added.dart';

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
  ExpressionState expressionState = ExpressionState.start(); //set by default

  num variableX = 0;

  CalcExpression(this.expressionTokenList, this.expressionState)
      : id = generateEntityId();

  CalcExpression.empty() : this(<ExpressionToken>[], ExpressionState.start());

  CalcExpression.expression(
      this.id, this.expressionTokenList, ExpressionState expressionState)
      : this.expressionState = ExpressionState.copy(expressionState);

  /// Append a digit to the current expression and return a new expression
  /// representing the result. Returns null to indicate that it is not legal
  /// to append a digit in the current state.
  CalcExpression appendDigit(int digit) {
    ExpressionToken newToken;
    final List<ExpressionToken> outList = expressionTokenList.toList();
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.Start:
      case ExpressionLastSymbAdded.BracketOpen:
        // Start a new number with digit.
        newToken = IntToken('$digit');
        break;
      case ExpressionLastSymbAdded.LeadingNeg:
        // Replace the leading neg with a negative number starting with digit.
        outList.removeLast();
        newToken = IntToken('-$digit');
        break;
      case ExpressionLastSymbAdded.Number:
        final ExpressionToken last = outList.removeLast();
        newToken = IntToken('${last.stringRep}$digit');
        break;
      case ExpressionLastSymbAdded.Point:
      case ExpressionLastSymbAdded.NumberWithPoint:
        final ExpressionToken token = outList.removeLast();
        //last = ExpressionLastSymbAdded.NumberWithPoint;
        newToken = FloatToken('${token.stringRep}$digit');
        break;

      case ExpressionLastSymbAdded.Variable:
      case ExpressionLastSymbAdded.Result:
      case ExpressionLastSymbAdded.BracketClosed:
        // Cannot enter a number now
        return null;
    }
    outList.add(newToken);
    return makeNewExpression(outList, ExpressionLastSymbAdded.Number);
  }

  makeNewExpression(List<ExpressionToken> outList,
      ExpressionLastSymbAdded expressionLastSymbAdded) {
    final expressionStateTemp = ExpressionState.copy(expressionState);
    expressionStateTemp.lastAdded = expressionLastSymbAdded;
    return CalcExpression(outList, expressionStateTemp);
  }

  /// Append a leading minus sign to the current expression and return a new
  /// expression representing the result. Returns null to indicate that it is not
  /// legal to append a leading minus sign in the current state.
  CalcExpression appendLeadingNeg() {
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.Start:
        break;
      case ExpressionLastSymbAdded.Variable:
      case ExpressionLastSymbAdded.LeadingNeg:
      case ExpressionLastSymbAdded.Point:
      case ExpressionLastSymbAdded.Number:
      case ExpressionLastSymbAdded.NumberWithPoint:
      case ExpressionLastSymbAdded.Result:
      case ExpressionLastSymbAdded.BracketClosed:
      case ExpressionLastSymbAdded.BracketOpen:
        // Cannot enter leading neg now.
        return null;
    }
    final List<ExpressionToken> outList = expressionTokenList.toList();
    outList.add(LeadingNegToken());

    return makeNewExpression(outList, ExpressionLastSymbAdded.LeadingNeg);
  }

  /// Append a minus sign to the current expression and return a new expression
  /// representing the result. Returns null to indicate that it is not legal
  /// to append a minus sign in the current state. Depending on the current
  /// state the minus sign will be interpreted as either a leading negative
  /// sign or a subtraction operation.
  CalcExpression appendMinus() {
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.Start:
        return appendLeadingNeg();
      case ExpressionLastSymbAdded.LeadingNeg:
      case ExpressionLastSymbAdded.Point:
      case ExpressionLastSymbAdded.Number:
      case ExpressionLastSymbAdded.NumberWithPoint:
      case ExpressionLastSymbAdded.Result:
      case ExpressionLastSymbAdded.BracketClosed:
      case ExpressionLastSymbAdded.Variable:
        return appendOperation(CalcOperation.Subtraction);
      default:
        return null;
    }
  }

  CalcExpression appendBracketOpen() {
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.Start:
        return doAppendOperation(
            CalcOperation.BracketOpen, ExpressionLastSymbAdded.BracketOpen);
      default:
        return null;
        break;
    }
  }

  CalcExpression appendBracketClose() {
    CalcExpression res;
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.Number:
      case ExpressionLastSymbAdded.Variable:
        res = doAppendOperation(
            CalcOperation.BracketClose, ExpressionLastSymbAdded.BracketClosed);
        break;
      default:
        res = null;
        break;
    }
    return res;
  }

  /// Append an operation symbol to the current expression and return a new
  /// expression representing the result. Returns null to indicate that it is not
  /// legal to append an operation symbol in the current state.
  CalcExpression appendOperation(CalcOperation op) {
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.Start:
      case ExpressionLastSymbAdded.LeadingNeg:
      case ExpressionLastSymbAdded.Point:
      case ExpressionLastSymbAdded.BracketOpen:
        // Cannot enter operation now.
        return null;
      case ExpressionLastSymbAdded.BracketClosed:
      case ExpressionLastSymbAdded.Variable:
      case ExpressionLastSymbAdded.Number:
      case ExpressionLastSymbAdded.NumberWithPoint:
      case ExpressionLastSymbAdded.Result:
        return doAppendOperation(op, ExpressionLastSymbAdded.Start);
    }
  }

  doAppendOperation(
      CalcOperation op, ExpressionLastSymbAdded expressionLastSymbAdded) {
    final List<ExpressionToken> outList = expressionTokenList.toList();
    outList.add(OperationToken(op));
    return makeNewExpression(outList, expressionLastSymbAdded);
  }

  /// Append a point to the current expression and return a new expression
  /// representing the result. Returns null to indicate that it is not legal
  /// to append a point in the current state.
  CalcExpression appendPoint() {
    var pointCanBeAdded = true;
    ExpressionToken newToken;
    final List<ExpressionToken> outList = expressionTokenList.toList();
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.BracketOpen:
      case ExpressionLastSymbAdded.Start:
        newToken = FloatToken('.');
        break;
      case ExpressionLastSymbAdded.LeadingNeg:
      case ExpressionLastSymbAdded.Number:
        final ExpressionToken last = outList.removeLast();
        newToken = FloatToken(last.stringRep + '.');
        break;
      case ExpressionLastSymbAdded.Variable:
      case ExpressionLastSymbAdded.Point:
      case ExpressionLastSymbAdded.NumberWithPoint:
      case ExpressionLastSymbAdded.Result:
      case ExpressionLastSymbAdded.BracketClosed:
        // Cannot enter a point now
        pointCanBeAdded = false;
        break;
    }

    if (pointCanBeAdded) {
      outList.add(newToken);
      return makeNewExpression(outList, ExpressionLastSymbAdded.Point);
    }
    return null;
  }

  CalcExpression appendVariable() {
    final List<ExpressionToken> outList = expressionTokenList.toList();
    var canBeAdded;
    CalcExpression res;
    switch (expressionState.lastAdded) {
      case ExpressionLastSymbAdded.BracketOpen:
      case ExpressionLastSymbAdded.Start:
      case ExpressionLastSymbAdded.LeadingNeg:
        canBeAdded = true;
        break;
      case ExpressionLastSymbAdded.Number:
      case ExpressionLastSymbAdded.Point:
      case ExpressionLastSymbAdded.NumberWithPoint:
      case ExpressionLastSymbAdded.Variable:
      case ExpressionLastSymbAdded.Result:
      case ExpressionLastSymbAdded.BracketClosed:
        // Cannot add variable now.
        canBeAdded = false;
        break;
    }

    if (canBeAdded) {
      outList.add(VariableToken());
      return makeNewExpression(outList, ExpressionLastSymbAdded.Variable);
      ;
    }
    return res;
  }

  validateExpression() {
    var valid = false;
    var msg;
    if (expressionState.maxValue > expressionState.minValue) {
      if (expressionTokenList.last.toString() != codeBrackerC && // special case
      expressionTokenList.last is OperationToken) {
        msg = "Wrong expression!";
      } else {
        valid = true;
      }
    } else {
      msg = "$codeVariable range error. Max must be gretter than min!";
    }
    return ExpressionValidateResult(valid, msg);
  }

  getRange() => [expressionState.minValue, expressionState.maxValue];

  rangeAsStr() => ", range = ${getRange()}";

  getTitle() => "f($codeVariable) = ${expressionTokenList.join()}";

  /// The string representation of the expression. This will be displayed
  /// in the calculator's display panel.
  @override
  String toString() {
    return expressionTokenList.join(" ").toString();
  }

  CalcExpression copy() =>
      CalcExpression(this.expressionTokenList, this.expressionState);
}
