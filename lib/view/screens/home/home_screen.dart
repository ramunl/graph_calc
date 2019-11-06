// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:graph_calc/helper/ArchKeys.dart';
import 'package:graph_calc/helper/ui_utils.dart';
import 'package:graph_calc/view/screens/calculator/expression_create.dart';
import 'package:graph_calc/view/screens/history/views/history_list_store_%D1%81onnector.dart';

import '../../../res/localization.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: ArchKeys.homeScreen);

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
        onPressed: () {
          final _mockPage = ExpressionCreate(); //workaround for focus lost bug
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _mockPage));
        },
        child: Icon(Icons.add),
        tooltip: GraphLocalizations.of(context).commandAddFunc,
      ),
    );
  }

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }
}
