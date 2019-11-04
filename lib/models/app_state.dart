// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<CalcExpression> items;

  AppState(
      {this.isLoading = false,
      this.items = const []});

  factory AppState.loading() => AppState(isLoading: true);

  @override
  int get hashCode =>
      isLoading.hashCode ^
      items.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          items == other.items;

  AppState copyWith({
    bool isLoading,
    List<CalcExpression> items,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, items: $items}';
  }
}
