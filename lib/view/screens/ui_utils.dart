
import 'package:flutter/widgets.dart';

const variableSymbol = '\u2717';

getFontSize(context) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return (orientation == Orientation.portrait) ? 28.0 : 24.0;
}
