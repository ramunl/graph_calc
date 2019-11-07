// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:graph_calc/mapper/expression_entity_mapper.dart';

import 'expression_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Items to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 1000)]);

  /// Mock that "fetches" some Items from a "web service" after a short delay
  Future<List<ExpressionEntity>> fetchItems() async {
    return Future.delayed(
        delay,
        () => [
              ExpressionEntity(generateEntityId(), ["x", "+", "2"], 10, 100),
              ExpressionEntity(generateEntityId(), ["x", "*", "3"], -100, 100),
              ExpressionEntity(generateEntityId(), ["x", "/", "4"], -1, 1),
              ExpressionEntity(generateEntityId(), ["10", "2"], 0, 1000),
              ExpressionEntity(generateEntityId(), ["10", "2"], -100, 0),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postItems(List<ExpressionEntity> items) async {
    return Future.value(true);
  }
}
