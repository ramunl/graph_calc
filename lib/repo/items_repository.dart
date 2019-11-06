// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'expression_entity.dart';

/// A class that Loads and Persists items. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as items_repository_simple or items_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ItemsRepository {
  /// Loads items first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Items from a Web Client.
  Future<List<ExpressionEntity>> loadItems();

  // Persists items to local disk and the web
  Future saveItems(List<ExpressionEntity> items);

  // Persists items to local disk and the web
  Future deleteItems();
}
