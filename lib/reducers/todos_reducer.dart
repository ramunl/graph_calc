// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/actions/add_todo_action.dart';
import 'package:graph_calc/actions/delete_todo_action.dart';
import 'package:graph_calc/actions/todos_loaded_action.dart';
import 'package:graph_calc/actions/todos_not_loaded_action.dart';
import 'package:graph_calc/actions/update_todo_action.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:redux/redux.dart';

final todosReducer = combineReducers<List<CalcExpression>>([
  TypedReducer<List<CalcExpression>, SaveExpressionAction>(_addTodo),
  TypedReducer<List<CalcExpression>, DeleteTodoAction>(_deleteTodo),
  //TypedReducer<List<CalcExpression>, UpdateTodoAction>(_updateTodo),
  //TypedReducer<List<CalcExpression>, ClearCompletedAction>(_clearCompleted),
  //TypedReducer<List<CalcExpression>, ToggleAllAction>(_toggleAll),
  TypedReducer<List<CalcExpression>, TodosLoadedAction>(_setLoadedTodos),
  TypedReducer<List<CalcExpression>, TodosNotLoadedAction>(_setNoTodos),
]);

List<CalcExpression> _addTodo(
    List<CalcExpression> todos, SaveExpressionAction action) {
  return List.from(todos)..add(action.calcExpression);
}

List<CalcExpression> _deleteTodo(
    List<CalcExpression> todos, DeleteTodoAction action) {
  return todos
      .where((calcExpression) => calcExpression.id != action.id)
      .toList();
}

List<CalcExpression> _setLoadedTodos(
    List<CalcExpression> todos, TodosLoadedAction action) {
  return action.todos;
}

/*
List<CalcExpression> _clearCompleted(List<CalcExpression> todos, ClearCompletedAction action) {
  return todos.where((calcExpression) => !calcExpression.complete).toList();
}

List<CalcExpression> _toggleAll(List<CalcExpression> todos, ToggleAllAction action) {
  final allComplete = allCompleteSelector(todos);

  return todos.map((calcExpression) => calcExpression.copyWith(complete: !allComplete)).toList();
}*/

List<CalcExpression> _setNoTodos(
    List<CalcExpression> todos, TodosNotLoadedAction action) {
  return [];
}

List<CalcExpression> _updateTodo(
    List<CalcExpression> todos, UpdateTodoAction action) {
  return todos
      .map((calcExpression) =>
          calcExpression.id == action.id ? action.updatedTodo : calcExpression)
      .toList();
}
