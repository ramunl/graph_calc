/// A token that composes an expression. There are several kinds of tokens
/// that represent arithmetic operation symbols, numbers and pieces of numbers.
/// We need to represent pieces of numbers because the user may have only
/// entered a partial expression so far.
class ExpressionToken {
  final String stringRep;

  ExpressionToken(this.stringRep);

  @override
  String toString() => stringRep;
}
