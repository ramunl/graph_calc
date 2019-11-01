// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:graph_calc/actions/add_todo_action.dart';
import 'package:graph_calc/models/models.dart';
import 'package:redux/redux.dart';

import 'expression_сalculate.dart';

class ExpressionCreate extends StatelessWidget {
  ExpressionCreate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnSaveCallback>(
      converter: (Store<AppState> store) {
        return (expression) {
          store.dispatch(SaveExpressionAction(expression));
        };
      },
      builder: (BuildContext context, OnSaveCallback onSave) {
        return Calculator(onSave: onSave);
      },
    );
  }
}
