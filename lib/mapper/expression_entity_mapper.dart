import 'package:graph_calc/store/expression_entity.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/calculator/model/expression_last_added.dart';
import 'package:graph_calc/view/screens/calculator/model/expression_state.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/expression_token.dart';

import '../helper/uuid.dart';

CalcExpression fromEntity(ExpressionEntity entity) {
  return CalcExpression.expression(
      entity.id,
      toExprTokenList(entity.tokenList),
      ExpressionState(ExpressionLastSymbAdded.Result,
          entity.minVal, entity.maxVal));
}

generateEntityId() => Uuid().generateV4();

ExpressionEntity toEntity(CalcExpression calcExpression) {
  return ExpressionEntity(
      calcExpression.id,
      toStrList(calcExpression.expressionTokenList),
      calcExpression.expressionState.minValue,
      calcExpression.expressionState.maxValue);
}

List<ExpressionToken> toExprTokenList(List<dynamic> expressions) {
  return expressions.map((expr) => ExpressionToken(expr as String)).toList();
}

List<String> toStrList(List<ExpressionToken> expressionTokens) {
  return expressionTokens.map((expr) => expr.toString()).toList();
}
