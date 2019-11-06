import 'number_token.dart';

/// A token that represents a number that is the result of a computation.
class ResultToken extends NumberToken {
  ResultToken(num number) : super.fromNumber(round(number));

  /// rounds `number` to 14 digits of precision. A double precision
  /// floating point number is guaranteed to have at least this many
  /// decimal digits of precision.
  static num round(num number) {
    if (number is int) return number;
    return double.parse(number.toStringAsPrecision(14));
  }
}
