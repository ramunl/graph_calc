import 'package:flutter/widgets.dart';

class CalcDisplay extends StatelessWidget {
  final String content;

  const CalcDisplay({this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}
