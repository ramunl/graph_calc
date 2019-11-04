import 'package:graph_calc/view/screens/ui_utils.dart';

import 'expression_token.dart';

/// A token that represents the unary minus prefix.
class LeadingNegToken extends ExpressionToken {
  LeadingNegToken() : super(codeMinus);
}
