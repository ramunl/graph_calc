import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

class AddTodoAction {
  final CalcExpression calcExpression;

  AddTodoAction(this.calcExpression);

  @override
  String toString() {
    return 'AddTodoAction{calcExpression: $calcExpression}';
  }
}