import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

class SaveExpressionAction {
  final CalcExpression calcExpression;

  SaveExpressionAction(this.calcExpression);

  @override
  String toString() {
    return 'SaveExpressionAction{calcExpression: $calcExpression}';
  }
}
