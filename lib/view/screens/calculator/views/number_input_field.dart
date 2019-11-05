import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../helper/ui_utils.dart';

class NumberInputField extends StatelessWidget {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final controller = TextEditingController();

  NumberInputField(Function(num) handleRangeMin, num initValue) {
    //  print("NumberInputField init: $initValue");
    if (initValue != 0) controller.text = initValue.toString();
    controller.addListener(() => {
          if (controller.text.isNotEmpty)
            {handleRangeMin(num.parse(controller.text))}
        });
  }

  @override
  Widget build(context) {
    return Container(
        child: Center(
            child: TextFormField(
                controller: controller,
                style: TextStyle(
                    color: Colors.pinkAccent, fontSize: getFontSize(context)),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "0"))),
        width: 100.0,
        height: double.infinity);
  }
}
