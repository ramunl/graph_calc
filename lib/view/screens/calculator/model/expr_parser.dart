import 'dart:collection';

import 'package:graph_calc/helper/ui_utils.dart';
import 'package:stack/stack.dart';

import 'calc_expression.dart';

class ExprParser {
  // Associativity constants for _operators
  final _left_assoc = 0;
  final _right_assoc = 1;
  List<String> rpnTokens;

  final HashMap<String, List> _operators = HashMap();

  ExprParser() {
    _operators[codePlus] = [0, _left_assoc];
    _operators[codeMinus] = [0, _left_assoc];
    _operators[codeMult] = [5, _left_assoc];
    _operators[codeDiv] = [5, _left_assoc];
  }

  num testFun(num x) {
    List<String> numTokens = List();
    for (var token in rpnTokens) {
      if (token == codeVariable) {
        numTokens.add(x.toString());
      } else {
        numTokens.add(token);
      }
    }
    final res = _tokensTonum(numTokens);
    return res;
  }

  parse(CalcExpression calcExpression) {
    final tokens = List<String>();
    for (var token in calcExpression.expressionTokenList) {
      tokens.add(token.toString());
    }
    rpnTokens = _infixToRPN(tokens);
  }

  bool _isOperator(String token) {
    return _operators.containsKey(token);
  }

  bool _isAssociative(String token, int type) {
    if (!_isOperator(token)) {
      throw Exception("Invalid token: " + token);
    }

    if (_operators[token][1] == type) {
      return true;
    }
    return false;
  }

  int _cmpPrecedence(String token1, String token2) {
    if (!_isOperator(token1) || !_isOperator(token2)) {
      throw Exception("Invalid tokens: " + token1 + " " + token2);
    }
    return _operators[token1][0] - _operators[token2][0];
  }

  num _tokensTonum(List<String> tokens) {
    Stack<String> stack = new Stack<String>();
    // For each token
    for (String token in tokens) {
      // If the token is a value push it onto the stack
      if (!_isOperator(token)) {
        stack.push(token);
      } else {
        // Token is an operator: pop top two entries
        num d2 = num.parse(stack.pop());
        num d1 = num.parse(stack.pop());

        //Get the result
        num result = token.compareTo(codePlus) == 0
            ? d1 + d2
            : token.compareTo(codeMinus) == 0
                ? d1 - d2
                : token.compareTo(codeMult) == 0 ? d1 * d2 : d1 / d2;
        // Push result onto stack
        stack.push(result.toString());
      }
    }
    return num.parse(stack.pop());
  }

  List<String> _infixToRPN(List<String> inputTokens) {
    List<String> out = new List<String>();
    Stack<String> stack = new Stack<String>();
    // For each token
    for (String token in inputTokens) {
      // If token is an operator
      if (_isOperator(token)) {
        // While stack not empty AND stack top element
        // is an operator
        while (stack.isNotEmpty && _isOperator(stack.top())) {
          if ((_isAssociative(token, _left_assoc) &&
                  _cmpPrecedence(token, stack.top()) <= 0) ||
              (_isAssociative(token, _right_assoc) &&
                  _cmpPrecedence(token, stack.top()) < 0)) {
            out.add(stack.pop());
            continue;
          }
          break;
        }
        // Push the new operator on the stack
        stack.push(token);
      }
      // If token is a left bracket '('
      else if (token == "(") {
        stack.push(token); //
      }
      // If token is a right bracket ')'
      else if (token == ")") {
        while (stack.isNotEmpty && stack.top() != "(") {
          out.add(stack.pop());
        }
        stack.pop();
      }
      // If token is a number
      else {
        out.add(token);
      }
    }
    while (stack.isNotEmpty) {
      out.add(stack.pop());
    }
    return out;
  }
}
