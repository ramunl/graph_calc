import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

class TodosLoadedAction {
  final List<CalcExpression> todos;

  TodosLoadedAction(this.todos);

  @override
  String toString() {
    return 'TodosLoadedAction{todos: $todos}';
  }
}
