import 'package:flutter/widgets.dart';

class CalcDisplay extends StatelessWidget {
  const CalcDisplay({ this.content });

  final String content;

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