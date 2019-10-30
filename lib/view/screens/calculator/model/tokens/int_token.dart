import 'number_token.dart';

/// A token that represents an integer.
class IntToken extends NumberToken {
  IntToken(String stringRep) : super(stringRep, int.parse(stringRep));
}