import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

class UpdateTodoAction {
  final String id;
  final CalcExpression updatedTodo;

  UpdateTodoAction(this.id, this.updatedTodo);

  @override
  String toString() {
    return 'UpdateTodoAction{id: $id, updatedTodo: $updatedTodo}';
  }
}
