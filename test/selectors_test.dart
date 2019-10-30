// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:quiver/core.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/selectors/selectors.dart';

main() {
  group('Selectors', () {
    test('should calculate the number of active todos', () {
      final todos = [
        CalcExpression('a'),
        CalcExpression('b'),
        CalcExpression('c', complete: true),
      ];

      expect(numActiveSelector(todos), 2);
    });

    test('should calculate the number of completed todos', () {
      final todos = [
        CalcExpression('a'),
        CalcExpression('b'),
        CalcExpression('c', complete: true),
      ];

      expect(numCompletedSelector(todos), 1);
    });

    test('should return all todos if the VisibilityFilter is all', () {
      final todos = [
        CalcExpression('a'),
        CalcExpression('b'),
        CalcExpression('c', complete: true),
      ];

      expect(filteredTodosSelector(todos, VisibilityFilter.all), todos);
    });

    test('should return active todos if the VisibilityFilter is active', () {
      final todo1 = CalcExpression('a');
      final todo2 = CalcExpression('b');
      final todo3 = CalcExpression('c', complete: true);
      final todos = [
        todo1,
        todo2,
        todo3,
      ];

      expect(filteredTodosSelector(todos, VisibilityFilter.active), [
        todo1,
        todo2,
      ]);
    });

    test('should return completed todos if the VisibilityFilter is completed',
        () {
      final todo1 = CalcExpression('a');
      final todo2 = CalcExpression('b');
      final todo3 = CalcExpression('c', complete: true);
      final todos = [
        todo1,
        todo2,
        todo3,
      ];

      expect(filteredTodosSelector(todos, VisibilityFilter.completed), [todo3]);
    });

    test('should return an Optional calcExpression based on id', () {
      final todo1 = CalcExpression('a', id: "1");
      final todo2 = CalcExpression('b');
      final todo3 = CalcExpression('c', complete: true);
      final todos = [
        todo1,
        todo2,
        todo3,
      ];

      expect(todoSelector(todos, "1"), Optional.of(todo1));
    });

    test('should return an absent Optional if the id is not found', () {
      final todo1 = CalcExpression('a', id: "1");
      final todo2 = CalcExpression('b');
      final todo3 = CalcExpression('c', complete: true);
      final todos = [
        todo1,
        todo2,
        todo3,
      ];

      expect(todoSelector(todos, "2"), Optional.absent());
    });
  });
}
