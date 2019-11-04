import 'expression_last_added.dart';

/// As the user taps different keys the current expression can be in one
/// of several states.
class ExpressionState {
  /// The expression is empty or an operation symbol was just entered.
  /// A new number must be started now.
  ExpressionLastSymbAdded lastAdded;
  //bool isBracketOpen = false;
  bool isVariableAdded = false;
  num maxValue = 0;
  num minValue = 0;

  ExpressionState(this.lastAdded, this.minValue, this.maxValue);

  ExpressionState.start() : this.lastAdded = ExpressionLastSymbAdded.Start;
  ExpressionState.result() : this.lastAdded = ExpressionLastSymbAdded.Result;

  ExpressionState.copy(ExpressionState baseState)
      : this.lastAdded = baseState.lastAdded,
        this.maxValue = baseState.maxValue,
        this.minValue = baseState.minValue;
}
