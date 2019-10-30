import 'number_token.dart';

/// A token that represents a floating point number.
class FloatToken extends NumberToken {
  FloatToken(String stringRep) : super(stringRep, _parse(stringRep));

  static double _parse(String stringRep) {
    String toParse = stringRep;
    if (toParse.startsWith('.')) toParse = '0' + toParse;
    if (toParse.endsWith('.')) toParse = toParse + '0';
    return double.parse(toParse);
  }
}