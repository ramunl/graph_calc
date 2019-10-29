
import 'package:flutter/material.dart';
import 'package:graph_calc/view/screens/calculator/views/%D1%81alc_display.dart';

import '../logic.dart';
import 'base/calc_experssions.dart';
import 'views/key_pad.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> with CalcExpressions {
  /// As the user taps keys we update the current `_expression` and we also
  /// keep a stack of previous expressions so we can return to earlier states
  /// when the user hits the DEL key.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Give the key-pad 3/5 of the vertical space and the display 2/5.
          Expanded(
            flex: 2,
            child: CalcDisplay(content: expression.toString()),
          ),
          const Divider(height: 1.0),
          Expanded(
            flex: 3,
            child: KeyPad(calcState: this),
          ),
        ],
      ),
    );
  }
}

