// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/actions/item_add_action.dart';
import 'package:graph_calc/actions/items_delete_action.dart';
import 'package:graph_calc/actions/items_loaded_action.dart';
import 'package:graph_calc/actions/items_not_loaded_action.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:redux/redux.dart';

final itemsReducer = combineReducers<List<CalcExpression>>([
  TypedReducer<List<CalcExpression>, ItemAddAction>(_addTodo),
  TypedReducer<List<CalcExpression>, ItemsDeleteAction>(_deleteTodo),
  TypedReducer<List<CalcExpression>, ItemsLoadedAction>(_setLoadedItems),
  TypedReducer<List<CalcExpression>, ItemsNotLoadedAction>(_setNoItems),
]);

List<CalcExpression> _addTodo(
    List<CalcExpression> items, ItemAddAction action) {
  return List.from(items)..insert(0, action.calcExpression);
}

List<CalcExpression> _deleteTodo(List<CalcExpression> items, ItemsDeleteAction action) {
  return [];
}

List<CalcExpression> _setLoadedItems(
    List<CalcExpression> items, ItemsLoadedAction action) {
  return action.items;
}

List<CalcExpression> _setNoItems(
    List<CalcExpression> items, ItemsNotLoadedAction action) {
  return [];
}

