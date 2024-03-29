// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:graph_calc/store/app_state.dart';
import 'package:graph_calc/view/screens/history/views/history_list.dart';

import '../viewmodel/history_view_model.dart';

class HistoryListStoreConnector extends StatelessWidget {
  HistoryListStoreConnector() : super();

  @override
  Widget build(BuildContext cFontext) {
    return StoreConnector<AppState, HistoryViewModel>(
      converter: HistoryViewModel.fromStore,
      builder: (context, vm) {
        return HistoryList(calcExpressions: vm.items, onRemove: vm.onRemove);
      },
    );
  }
}
