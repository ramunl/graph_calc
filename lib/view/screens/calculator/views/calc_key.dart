
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../ui_utils.dart';

class CalcKey extends StatelessWidget {
  const CalcKey(this.text, this.onTap);

  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkResponse(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: getFontSize(context)
            ),
          ),
        ),
      ),
    );
  }
}