
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalcKey extends StatelessWidget {
  const CalcKey(this.text, this.onTap);

  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Expanded(
      child: InkResponse(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: (orientation == Orientation.portrait) ? 32.0 : 24.0
            ),
          ),
        ),
      ),
    );
  }
}