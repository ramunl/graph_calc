import 'package:flutter/widgets.dart';

const codePlus = '\u002B';
const codeMinus = '\u002D';
const codeVariable = '\u2717';
const codeMult = '\u00D7';
const codeDiv = '\u00F7';
const codeDel = '\u232B';
const codeBrackerO = '\u0028';
const codeBrackerC = '\u0029';
const codeSqrt = '\u221A';

getFontSize(context) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return (orientation == Orientation.portrait) ? 20.0 : 16.0;
}
