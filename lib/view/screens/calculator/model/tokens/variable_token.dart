import 'package:graph_calc/helper/ui_utils.dart';

import 'expression_token.dart';

/// A token that represents an arithmetic operation symbol.
class VariableToken extends ExpressionToken {
  VariableToken() : super(opString());

  static String opString() {
    return codeVariable;
  }
}
