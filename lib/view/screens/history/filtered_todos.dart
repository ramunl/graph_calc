// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/view/screens/history/todo_list.dart';
import 'package:graph_calc/models/models.dart';
import 'model/history_view_model.dart';

class FilteredTodos extends StatelessWidget {


  FilteredTodos() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HistoryViewModel>(
      converter: HistoryViewModel.fromStore,
      builder: (context, vm) {
        return TodoList(
          todos: vm.todos,
          //onCheckboxChanged: vm.onCheckboxChanged,
          onRemove: vm.onRemove,
          onUndoRemove: vm.onUndoRemove,
        );
      },
    );
  }
}
