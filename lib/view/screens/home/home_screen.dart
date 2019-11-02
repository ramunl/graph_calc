// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/view/screens/calculator/expression_create.dart';
import 'package:graph_calc/view/screens/history/history_list_store_сonnector.dart';

import '../../localization.dart';
import '../../routes.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: HistoryListStoreConnector(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addTodoFab,
        onPressed: () {

          final _mockPage = ExpressionCreate();
          Navigator.push(context, MaterialPageRoute(builder: (context) => _mockPage));
          //Navigator.pushNamed(context, ArchSampleRoutes.showCalculator);
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).saveFunction,
      ),
    );
  }

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }
}
