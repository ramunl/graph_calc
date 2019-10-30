// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:meta/meta.dart';
import 'package:graph_calc/models/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<CalcExpression> todos;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState(
      {this.isLoading = false,
      this.todos = const [],
      this.activeTab = AppTab.history,
      this.activeFilter = VisibilityFilter.all});

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<CalcExpression> todos,
    AppTab activeTab,
    VisibilityFilter activeFilter,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      todos: todos ?? this.todos,
      activeTab: activeTab ?? this.activeTab,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      todos.hashCode ^
      activeTab.hashCode ^
      activeFilter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          todos == other.todos &&
          activeTab == other.activeTab &&
          activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, todos: $todos, activeTab: $activeTab, activeFilter: $activeFilter}';
  }
}
