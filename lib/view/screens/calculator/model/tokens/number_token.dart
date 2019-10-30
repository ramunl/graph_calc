import 'expression_token.dart';

/// A token that represents a number.
class NumberToken extends ExpressionToken {
  NumberToken(String stringRep, this.number) : super(stringRep);

  NumberToken.fromNumber(num number) : this('$number', number);

  final num number;
}
