import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graph_calc/actions/add_todo_action.dart';
import 'package:graph_calc/actions/delete_todo_action.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/selectors/selectors.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:redux/redux.dart';

class HistoryViewModel {
  final List<CalcExpression> todos;
  final bool loading;
  //final Function(CalcExpression, bool) onCheckboxChanged;
  final Function(CalcExpression) onRemove;
  final Function(CalcExpression) onUndoRemove;

  HistoryViewModel({
    @required this.todos,
    @required this.loading,
    @required this.onRemove,
    @required this.onUndoRemove,
  });

  static HistoryViewModel fromStore(Store<AppState> store) {
    return HistoryViewModel(
      todos: filteredTodosSelector(
        todosSelector(store.state),
        activeFilterSelector(store.state),
      ),
      loading: store.state.isLoading,
      onRemove: (calcExpression) {
        store.dispatch(DeleteTodoAction(calcExpression.id));
      },
      onUndoRemove: (calcExpression) {
        store.dispatch(SaveExpressionAction(calcExpression));
      },
    );
  }
}
