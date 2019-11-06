import 'package:flutter/widgets.dart';

class KeyRow extends StatelessWidget {
  final List<Widget> keys;

  const KeyRow(this.keys);

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
