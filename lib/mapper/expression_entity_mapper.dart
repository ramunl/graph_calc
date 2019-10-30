import 'package:graph_calc/store/expression_entity.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/calculator/model/tokens/expression_token.dart';

import '../uuid.dart';


ExpressionEntity toEntity(CalcExpression calcExpression) {
  return ExpressionEntity(
      calcExpression.id, toStrList(calcExpression.expressionTokenList));
}

CalcExpression fromEntity(ExpressionEntity entity) {
  return CalcExpression.expression(
      entity.id, toExprTokenList(entity.tokenList));
}

List<ExpressionToken> toExprTokenList(List<String> expressions) {
  return expressions.map((expr) => ExpressionToken(expr)).toList();
}

List<String> toStrList(List<ExpressionToken> expressionTokens) {
  return expressionTokens.map((expr) => expr.toString()).toList();
}

generateEntityId() => Uuid().generateV4();
