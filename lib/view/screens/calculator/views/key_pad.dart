import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graph_calc/helper/ui_utils.dart';

import '../base/calc_experssions.dart';
import 'calc_key.dart';
import 'key_row.dart';
import 'number_input_field.dart';
import 'number_key.dart';

class KeyPad extends StatelessWidget {
  final CalcExpressions calcState;

  const KeyPad({this.calcState});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      primarySwatch: Colors.purple,
      brightness: Brightness.dark,
      platform: Theme.of(context).platform,
    );
    return Theme(
      data: themeData,
      child: Material(
        child: Row(
          children: <Widget>[
            Expanded(
              // We set flex equal to the number of columns so that the main keypad
              // and the op keypad have sizes proportional to their number of
              // columns.
              flex: 3,
              child: Column(
                children: <Widget>[
                  KeyRow(<Widget>[
                    NumberInputField(
                        calcState.handleRangeMin, calcState.minValue()),
                    Text(" < "),
                    CalcKey(codeVariable, calcState.handleVariableTap),
                    Text(" < "),
                    NumberInputField(
                        calcState.handleRangeMax, calcState.maxValue()),
                  ]),
                  KeyRow(<Widget>[
                    CalcKey(codeBrackerO, calcState.handleBracketOpenTap),
                    CalcKey(codeBrackerC, calcState.handleBracketCloseTap),
                    //CalcKey(codeSqrt, calcState.handleSqrtTap),
                  ]),
                  KeyRow(<Widget>[
                    NumberKey(7, calcState),
                    NumberKey(8, calcState),
                    NumberKey(9, calcState),
                  ]),
                  KeyRow(<Widget>[
                    NumberKey(4, calcState),
                    NumberKey(5, calcState),
                    NumberKey(6, calcState),
                  ]),
                  KeyRow(<Widget>[
                    NumberKey(1, calcState),
                    NumberKey(2, calcState),
                    NumberKey(3, calcState),
                  ]),
                  KeyRow(<Widget>[
                    CalcKey('.', calcState.handlePointTap),
                    NumberKey(0, calcState),
                    //  CalcKey('=', calcState.handleEqualsTap),
                  ]),
                ],
              ),
            ),
            Expanded(
              child: Material(
                // color: themeData.backgroundColor,
                child: Column(
                  children: <Widget>[
                    CalcKey(codeDel, calcState.handleDelTap),
                    CalcKey(codeDiv, calcState.handleDivTap),
                    CalcKey(codeMult, calcState.handleMultTap),
                    CalcKey('-', calcState.handleMinusTap),
                    CalcKey('+', calcState.handlePlusTap),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
