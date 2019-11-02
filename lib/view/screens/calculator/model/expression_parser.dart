import 'package:graph_calc/view/screens/calculator/model/tokens/expression_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/number_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/operation_token.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/result_token.dart';

import 'calc_expression.dart';
import 'calc_operation.dart';
import 'expression_state.dart';

/// Computes the result of the current expression and returns a new
/// ResultExpression containing the result. Returns null to indicate that
/// it is not legal to compute a result in the current state.
CalcExpression computeResult(CalcExpression calcExpression) {
  // We make a copy of _list because CalcExpressions are supposed to
  // be immutable.
  final List<ExpressionToken> list =
      calcExpression.expressionTokenList.toList();
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
        break;
    }
  }
  final List<ExpressionToken> outList = <ExpressionToken>[
    ResultToken(currentTermValue),
  ];
  return CalcExpression(outList, ExpressionState.Result,
      calcExpression.minValue, calcExpression.maxValue);
}

/// Removes the next "term" from `list` and returns its numeric value.
/// A "term" is a sequence of number tokens separated by multiplication
/// and division symbols.
num removeNextTerm(List<ExpressionToken> list) {
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
        break;
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
