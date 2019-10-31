/// As the user taps different keys the current expression can be in one
/// of several states.
enum ExpressionState {
  /// The expression is empty or an operation symbol was just entered.
  /// A new number must be started now.
  Start,

  /// A minus sign was entered as a leading negative prefix.
  LeadingNeg,

  /// We are in the midst of a number without a point.
  Number,

  /// A point was just entered.
  Point,

  /// We are in the midst of a number with a point.
  NumberWithPoint,

  Variable,

  /// A result is being displayed
  Result,
}