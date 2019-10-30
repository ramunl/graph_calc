import 'expression_token.dart';

/// A token that represents the unary minus prefix.
class LeadingNegToken extends ExpressionToken {
  LeadingNegToken() : super('-');
}