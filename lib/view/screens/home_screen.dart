// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/view/containers/active_tab.dart';
import 'package:graph_calc/view/containers/extra_actions_container.dart';
import 'package:graph_calc/view/containers/filter_selector.dart';
import 'package:graph_calc/view/containers/filtered_todos.dart';
import 'package:graph_calc/view/containers/stats.dart';
import 'package:graph_calc/view/containers/tab_selector.dart';

import '../localization.dart';
import '../routes.dart';


class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: ArchSampleKeys.homeScreen);

  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(ReduxLocalizations.of(context).appTitle),
            actions: [
              FilterSelector(visible: activeTab == AppTab.todos),
              ExtraActionsContainer(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}
