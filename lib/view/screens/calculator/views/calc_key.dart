import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../helper/ui_utils.dart';

class CalcKey extends StatelessWidget {
  final String text;

  final GestureTapCallback onTap;

  const CalcKey(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkResponse(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: getFontSize(context)),
          ),
        ),
      ),
    );
  }
}
