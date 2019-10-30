// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';

import '../optional.dart';

List<CalcExpression> todosSelector(AppState state) => state.todos;

VisibilityFilter activeFilterSelector(AppState state) => state.activeFilter;

AppTab activeTabSelector(AppState state) => state.activeTab;

bool isLoadingSelector(AppState state) => state.isLoading;

/*
bool allCompleteSelector(List<CalcExpression> todos) =>
    todos.every((calcExpression) => calcExpression.complete);

int numActiveSelector(List<CalcExpression> todos) =>
    todos.fold(0, (sum, calcExpression) => !calcExpression.complete ? ++sum : sum);

int numCompletedSelector(List<CalcExpression> todos) =>
    todos.fold(0, (sum, calcExpression) => calcExpression.complete ? ++sum : sum);
*/

List<CalcExpression> filteredTodosSelector(
  List<CalcExpression> todos,
  VisibilityFilter activeFilter,
) {
  return todos.where((calcExpression) {
    if (activeFilter == VisibilityFilter.all) {
      return true;
    }/* else if (activeFilter == VisibilityFilter.active) {
      return !calcExpression.complete;
    } else if (activeFilter == VisibilityFilter.completed) {
      return calcExpression.complete;
    }*/
  }).toList();
}

Optional<CalcExpression> todoSelector(List<CalcExpression> todos, String id) {
  try {
    return Optional.of(todos.firstWhere((calcExpression) => calcExpression.id == id));
  } catch (e) {
    return Optional.absent();
  }
}
