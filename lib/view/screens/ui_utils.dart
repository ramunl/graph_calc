
import 'package:flutter/cupertino.dart';

getFontSize(BuildContext context) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return (orientation == Orientation.portrait) ? 28.0 : 24.0;
}

const variableSymbol = '\u2717';