// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:graph_calc/models/ArchSampleKeys.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/view/containers/app_loading.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/history/views/todo_item.dart';

import '../../localization.dart';
import 'views/loading_indicator.dart';


class TodoList extends StatelessWidget {
  final List<CalcExpression> todos;
  final Function(CalcExpression) onRemove;
  final Function(CalcExpression) onUndoRemove;

  TodoList({
    Key key,
    @required this.todos,
    @required this.onRemove,
    @required this.onUndoRemove,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading
          ? LoadingIndicator(key: ArchSampleKeys.todosLoading)
          : _buildListView();
    });
  }

  ListView _buildListView() {
    return ListView.builder(
      key: ArchSampleKeys.todoList,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final calcExpression = todos[index];
        return TodoItem(
          calcExpression: calcExpression,
          onTap: () => _onTodoTap(context, calcExpression),
         /* onCheckboxChanged: (complete) {
            onCheckboxChanged(calcExpression, complete);
          },*/
        );
      },
    );
  }

  void _removeTodo(BuildContext context, CalcExpression calcExpression) {
    onRemove(calcExpression);

    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).backgroundColor,
        content: Text(
          ArchSampleLocalizations.of(context).todoDeleted(calcExpression.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: ArchSampleLocalizations.of(context).undo,
          onPressed: () => onUndoRemove(calcExpression),
        )));
  }

  void _onTodoTap(BuildContext context, CalcExpression calcExpression) {
    /*Navigator
        .of(context)
        .push(MaterialPageRoute(
          builder: (_) => createFunc(id: calcExpression.id),
        ))
        .then((removedTodo) {
      if (removedTodo != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            key: ArchSampleKeys.snackbar,
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: Text(
              ArchSampleLocalizations.of(context).todoDeleted(calcExpression.id),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: ArchSampleLocalizations.of(context).undo,
              onPressed: () {
                onUndoRemove(calcExpression);
              },
            )));
      }
    });*/
  }
}
