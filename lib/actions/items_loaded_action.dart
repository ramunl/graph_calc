import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

class ItemsLoadedAction {
  final List<CalcExpression> items;

  ItemsLoadedAction(this.items);

  @override
  String toString() {
    return 'ItemsLoadedAction{items: $items}';
  }
}
