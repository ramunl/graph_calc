import 'package:flutter/widgets.dart';

class KeyRow extends StatelessWidget {
  const KeyRow(this.keys);

  final List<Widget> keys;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys,
      ),
    );
  }
}