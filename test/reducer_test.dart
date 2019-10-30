// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:graph_calc/actions/todos_not_loaded_action.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/reducers/app_state_reducer.dart';
import 'package:graph_calc/selectors/selectors.dart';

main() {
  group('State Reducer', () {
    test('should add a calcExpression to the list in response to an AddTodoAction', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState.loading(),
      );
      final calcExpression = CalcExpression("Hallo");

      store.dispatch(AddTodoAction(calcExpression));

      expect(todosSelector(store.state), [calcExpression]);
    });

    test('should remove from the list in response to a DeleteTodoAction', () {
      final calcExpression = CalcExpression("Hallo");
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [calcExpression]),
      );

      expect(todosSelector(store.state), [calcExpression]);

      store.dispatch(DeleteTodoAction(calcExpression.id));

      expect(todosSelector(store.state), []);
    });

    test('should update a calcExpression in response to an UpdateTodoAction', () {
      final calcExpression = CalcExpression("Hallo");
      final updatedTodo = calcExpression.copyWith(task: "Tschüss");
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [calcExpression]),
      );

      store.dispatch(UpdateTodoAction(calcExpression.id, updatedTodo));

      expect(todosSelector(store.state), [updatedTodo]);
    });

    test('should clear completed todos', () {
      final todo1 = CalcExpression("Hallo");
      final todo2 = CalcExpression("Tschüss", complete: true);
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [todo1, todo2]),
      );

      expect(todosSelector(store.state), [todo1, todo2]);

      store.dispatch(ClearCompletedAction());

      expect(todosSelector(store.state), [todo1]);
    });

    test('should mark all as completed if some todos are incomplete', () {
      final todo1 = CalcExpression("Hallo");
      final todo2 = CalcExpression("Tschüss", complete: true);
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [todo1, todo2]),
      );

      expect(todosSelector(store.state), [todo1, todo2]);

      store.dispatch(ToggleAllAction());

      expect(allCompleteSelector(todosSelector(store.state)), isTrue);
    });

    test('should mark all as incomplete if all todos are complete', () {
      final todo1 = CalcExpression("Hallo", complete: true);
      final todo2 = CalcExpression("Tschüss", complete: true);
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [todo1, todo2]),
      );

      expect(todosSelector(store.state), [todo1, todo2]);

      store.dispatch(ToggleAllAction());

      expect(allCompleteSelector(todosSelector(store.state)), isFalse);
    });

    test('should update the VisibilityFilter', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(activeFilter: VisibilityFilter.active),
      );

      store.dispatch(UpdateFilterAction(VisibilityFilter.completed));

      expect(store.state.activeFilter, VisibilityFilter.completed);
    });

    test('should update the AppTab', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(activeTab: AppTab.history),
      );

      store.dispatch(UpdateTabAction(AppTab.stats));

      expect(store.state.activeTab, AppTab.stats);
    });
  });
}
