import 'package:flutter/widgets.dart';
import 'package:graph_calc/helper/ui_utils.dart';

class CalcDisplay extends StatelessWidget {
  final String content;

  const CalcDisplay({this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: TextStyle(fontSize: getFontSize(context)),
      ),
    );
  }
}
