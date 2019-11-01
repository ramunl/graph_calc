import '../base/calc_experssions.dart';
import 'calc_key.dart';

class NumberKey extends CalcKey {
  NumberKey(int value, CalcExpressions calcState)
      : super('$value', () {
          calcState.handleNumberTap(value);
        });
}
