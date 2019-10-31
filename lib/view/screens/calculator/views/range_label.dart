import 'package:flutter/material.dart';

import '../../ui_utils.dart';

class RangeLabelField extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
          decoration:
          InputDecoration(labelText: 'min'),
          style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: getFontSize(context))),
    );
  }
}
