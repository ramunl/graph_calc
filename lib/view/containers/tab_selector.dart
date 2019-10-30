// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graph_calc/actions/update_tab_action.dart';
import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/models/tab_info.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:graph_calc/actions/todos_not_loaded_action.dart';
import 'package:graph_calc/models/models.dart';

class TabSelector extends StatelessWidget {
  TabSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BottomNavigationBar(
            key: ArchSampleKeys.tabs,
            currentIndex: AppTab.values.indexOf(vm.activeTab),
            onTap: vm.onTabSelected,
            items: getBottomNavBar(context));
      },
    );
  }

  List<BottomNavigationBarItem> getBottomNavBar(context) {
    return AppTab.values.map((tab) {
      var info = TabInfo.getTabInfo(context, tab);
      return BottomNavigationBarItem(
        icon: Icon(info.icon),
        title: Text(info.title)
      );
    }).toList();
  }
}

class _ViewModel {
  final AppTab activeTab;
  final Function(int) onTabSelected;

  _ViewModel({
    @required this.activeTab,
    @required this.onTabSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.activeTab,
      onTabSelected: (index) {
        store.dispatch(UpdateTabAction((AppTab.values[index])));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;
}
