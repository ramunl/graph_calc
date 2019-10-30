// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:graph_calc/store/expression_entity.dart';
import 'package:graph_calc/store/todos_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:graph_calc/actions/todos_not_loaded_action.dart';
import 'package:graph_calc/middleware/store_todos_middleware.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/reducers/app_state_reducer.dart';

class MockTodosRepository extends Mock implements TodosRepository {}

main() {
  group('Save State Middleware', () {
    test('should load the todos in response to a LoadTodosAction', () {
      final repository = MockTodosRepository();
      final store = Store<AppState>(
        appReducer,
        initialState: AppState.loading(),
        middleware: createStoreTodosMiddleware(repository),
      );
      final todos = [
        ExpressionEntity("Moin", "1", "Note", false),
      ];

      when(repository.loadTodos()).thenAnswer((_) => Future.value(todos));

      store.dispatch(LoadTodosAction());

      verify(repository.loadTodos());
    });

    test('should save the state on every update action', () {
      final repository = MockTodosRepository();
      final store = Store<AppState>(
        appReducer,
        initialState: AppState.loading(),
        middleware: createStoreTodosMiddleware(repository),
      );
      final calcExpression = CalcExpression("Hallo");

      store.dispatch(AddTodoAction(calcExpression));
      store.dispatch(ClearCompletedAction());
      store.dispatch(ToggleAllAction());
      store.dispatch(TodosLoadedAction([CalcExpression("Hi")]));
      store.dispatch(ToggleAllAction());
      store.dispatch(UpdateTodoAction("", CalcExpression("")));
      store.dispatch(DeleteTodoAction(""));

      verify(repository.saveTodos(any)).called(7);
    });
  });
}
