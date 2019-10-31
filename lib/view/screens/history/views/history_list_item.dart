// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graph_calc/models/ArchSampleKeys.dart';

import 'package:graph_calc/models/models.dart';

import '../../calculator/model/calc_expression.dart';
import '../../ui_utils.dart';

class HistoryListItem extends StatelessWidget {
  // final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;

//  final ValueChanged<bool> onCheckboxChanged;
  final CalcExpression calcExpression;

  HistoryListItem({
//    @required this.onDismissed,
    @required this.onTap,
    //  @required this.onCheckboxChanged,
    @required this.calcExpression,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: onTap, // handle your onTap here
          child: Padding(
              padding: EdgeInsets.only(bottom: 8.0,top: 8.0),
              child: Card(
                key: ArchSampleKeys.todoItem(calcExpression.id),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  child: Text(
                    calcExpression.getTitle(),
                    style: TextStyle(
                      fontSize: 18.0,
                      height: 1.6,
                    ),
                  ),
                ),
              ))
      ),
    );
  }
}
