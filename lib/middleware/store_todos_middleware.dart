// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.


import 'package:path_provider/path_provider.dart';
import 'package:graph_calc/actions/add_todo_action.dart';
import 'package:graph_calc/actions/clear_completed_action.dart';
import 'package:graph_calc/actions/delete_todo_action.dart';
import 'package:graph_calc/actions/load_todos_action.dart';
import 'package:graph_calc/actions/todos_loaded_action.dart';
import 'package:graph_calc/actions/todos_not_loaded_action.dart';
import 'package:graph_calc/actions/toggle_all_action.dart';
import 'package:graph_calc/actions/update_todo_action.dart';
import 'package:graph_calc/mapper/expression_entity_mapper.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/selectors/selectors.dart';
import 'package:graph_calc/store/file_storage.dart';
import 'package:graph_calc/store/todos_repository.dart';
import 'package:redux/redux.dart';

import '../store/repository.dart';

List<Middleware<AppState>> createStoreTodosMiddleware([
  TodosRepository repository = const TodosRepositoryFlutter(
    fileStorage:
        const FileStorage('graph_store', getApplicationDocumentsDirectory),
  ),
]) {
  final saveTodos = _createSaveTodos(repository);
  final loadTodos = _createLoadTodos(repository);

  return [
    TypedMiddleware<AppState, LoadTodosAction>(loadTodos),
    TypedMiddleware<AppState, SaveExpressionAction>(saveTodos),
    TypedMiddleware<AppState, ClearCompletedAction>(saveTodos),
    TypedMiddleware<AppState, ToggleAllAction>(saveTodos),
    TypedMiddleware<AppState, UpdateTodoAction>(saveTodos),
    TypedMiddleware<AppState, TodosLoadedAction>(saveTodos),
    TypedMiddleware<AppState, DeleteTodoAction>(saveTodos),
  ];
}

Middleware<AppState> _createLoadTodos(TodosRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadTodos().then(
      (todos) {
        store.dispatch(
          TodosLoadedAction(
            todos.map(fromEntity).toList(),
          ),
        );
      },
    ).catchError((_) => store.dispatch(TodosNotLoadedAction()));

    next(action);
  };
}

Middleware<AppState> _createSaveTodos(TodosRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    repository.saveTodos(
      todosSelector(store.state)
          .map((calcExpression) => toEntity(calcExpression))
          .toList(),
    );
  };
}
