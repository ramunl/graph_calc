import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graph_calc/actions/item_add_action.dart';
import 'package:graph_calc/actions/items_delete_action.dart';
import 'package:graph_calc/models/app_state.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:redux/redux.dart';

class HistoryViewModel {
  final List<CalcExpression> items;
  final bool loading;
  final Function() onRemove;
  final Function(CalcExpression) onUndoRemove;

  HistoryViewModel({
    @required this.items,
    @required this.loading,
    @required this.onRemove,
    @required this.onUndoRemove,
  });

  static HistoryViewModel fromStore(Store<AppState> store) {
    return HistoryViewModel(
      items: store.state.items,
      loading: store.state.isLoading,
      onRemove: () {
        store.dispatch(ItemsDeleteAction());
      },
      onUndoRemove: (calcExpression) {
        store.dispatch(ItemAddAction(calcExpression));
      },
    );
  }
}
