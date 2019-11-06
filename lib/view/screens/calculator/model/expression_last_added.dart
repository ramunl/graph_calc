/// As the user taps different keys the current expression can be in one
/// of several states.
enum ExpressionLastSymbAdded {
  /// The expression is empty or an operation symbol was just entered.
  /// A new number must be started now.
  Start,
  LeadingNeg,
  Number,
  Point,
  NumberWithPoint,
  Variable,
  Result,
  BracketClosed,
  BracketOpen
}
