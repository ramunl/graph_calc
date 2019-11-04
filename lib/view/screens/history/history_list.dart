// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/history/app_loading.dart';
import 'package:graph_calc/view/screens/history/views/history_list_item.dart';
import 'package:graph_calc/view/screens/history/views/view_list_empty.dart';
import 'package:graph_calc/view/screens/plotting/func_plotter.dart';

import '../../localization.dart';
import 'views/loading_indicator.dart';

class HistoryList extends StatelessWidget {
  final List<CalcExpression> calcExpressions;
  final Function() onRemove;

  HistoryList(
      {Key key, @required this.onRemove, @required this.calcExpressions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("_CalculatorState build");
    final localizations = ArchSampleLocalizations.of(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(localizations.historyTitle),
          actions: [
            IconButton(
              tooltip: localizations.saveFunction,
              key: ArchSampleKeys.saveFunction,
              icon: Icon(Icons.delete),
              onPressed: () {
                onRemove();
              },
            )
          ],
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
        ),
        body: AppLoading(builder: (context, loading) {
          if (loading) {
            return LoadingIndicator(key: ArchSampleKeys.todosLoading);
          } else {
            if (calcExpressions.isNotEmpty) {
              return _buildListView();
            } else {
              return ListEmpty(key: ArchSampleKeys.listEmpty);
            }
          }
        }));
  }

  ListView _buildListView() {
    return ListView.builder(
      key: ArchSampleKeys.todoList,
      itemCount: calcExpressions.length,
      itemBuilder: (BuildContext context, int index) {
        final calcExpression = calcExpressions[index];
        return HistoryListItem(
          calcExpression: calcExpression,
          onTap: () => _onHistoryItemClicked(context, calcExpression),
        );
      },
    );
  }

  void _removeTodo(BuildContext context) {}

  void _onHistoryItemClicked(
      BuildContext context, CalcExpression calcExpression) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FuncPlotter(calcExpression);
        },
      ),
    );
  }
}
