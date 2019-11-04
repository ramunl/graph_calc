import '../../../ui_utils.dart';
import '../calc_operation.dart';
import 'expression_token.dart';

/// A token that represents an arithmetic operation symbol.
class OperationToken extends ExpressionToken {
  CalcOperation operation;

  OperationToken(this.operation) : super(opString(operation));

   static String getCode(CalcOperation operation) {
    switch (operation) {
      case CalcOperation.Addition:
        return codePlus;
      case CalcOperation.Subtraction:
        return codeMinus;
      case CalcOperation.Multiplication:
        return codeMult;
      case CalcOperation.Division:
        return codeDiv;
      case CalcOperation.BracketOpen:
        return codeBrackerO;
      case CalcOperation.BracketClose:
        return codeBrackerC;
      case CalcOperation.Sqrt:
        return codeSqrt;
    }
    assert(operation != null);
    return null;
  }

  static String opString(CalcOperation operation) {
    return getCode(operation);
  }
}
