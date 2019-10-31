import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_utils.dart';

class NumberInputField extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: TextFormField(
                style: TextStyle(
                    color: Colors.pinkAccent, fontSize: getFontSize(context)),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "0"))),
        width: 100.0,
        height: double.infinity);
  }
}
