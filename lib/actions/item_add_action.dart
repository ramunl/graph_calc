import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

class ItemAddAction {
  final CalcExpression calcExpression;

  ItemAddAction(this.calcExpression);

  @override
  String toString() {
    return 'SaveExpressionAction{calcExpression: $calcExpression}';
  }
}
