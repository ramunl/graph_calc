import 'package:flutter/material.dart';
import 'package:graph_calc/models/ArchKeys.dart';
import 'package:graph_calc/view/screens/calculator/views/%D1%81alc_display.dart';

import '../../localization.dart';
import 'base/calc_experssions.dart';
import 'model/calc_expression.dart';
import 'views/key_pad.dart';

typedef OnSaveCallback = Function(CalcExpression expression);

class Calculator extends StatefulWidget {
  final OnSaveCallback onSave;

  const Calculator({Key key, @required this.onSave}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> with CalcExpressions {
  /// As the user taps keys we update the current `_expression` and we also
  /// keep a stack of previous expressions so we can return to earlier states
  /// when the user hits the DEL key.

  @override
  Widget build(BuildContext context) {
    print("_CalculatorState build");
    final localizations = ArchSampleLocalizations.of(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(localizations.screenTitleAddFunction),
        actions: [
          IconButton(
            tooltip: localizations.commandAddFunc,
            icon: Icon(Icons.save),
            onPressed: () {
              final res = expression.validateExpression();
              print(res.toString());
              if (res.isSuccess) {
                Navigator.pop(context);
                widget.onSave(expression);
              } else {
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(res.messageInfo,
                      style: TextStyle(fontSize: 18.0, color: Colors.white)),
                );
                print("showSnackBar ${res.messageInfo}");
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }
            },
          )
        ],
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
