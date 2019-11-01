import '../calc_operation.dart';
import 'expression_token.dart';

/// A token that represents an arithmetic operation symbol.
class OperationToken extends ExpressionToken {
  CalcOperation operation;

  OperationToken(this.operation) : super(opString(operation));

  static String opString(CalcOperation operation) {
    switch (operation) {
      case CalcOperation.Addition:
        return ' + ';
      case CalcOperation.Subtraction:
        return ' - ';
      case CalcOperation.Multiplication:
        return '  \u00D7  ';
      case CalcOperation.Division:
        return '  \u00F7  ';
    }
    assert(operation != null);
    return null;
  }
}
