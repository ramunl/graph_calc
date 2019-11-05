// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:graph_calc/repo/expression_entity.dart';
import 'package:meta/meta.dart';

import 'file_storage.dart';
import 'items_repository.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Items and Persist items.
class ItemsRepositoryFlutter implements ItemsRepository {
  final FileStorage fileStorage;

  //final WebClient webClient;

  const ItemsRepositoryFlutter({
    @required this.fileStorage,
    //  this.webClient = const WebClient(),
  });

  /// Loads items first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Items from a Web Client.
  @override
  Future<List<ExpressionEntity>> loadItems() async {
    try {
      return await fileStorage.loadItems();
    } catch (e) {
      print(e);
      //    final items = await webClient.fetchItems();
      //   fileStorage.saveToFdos(items);
      return null;
    }
  }

  // Persists items to local disk and the web
  @override
  Future saveItems(List<ExpressionEntity> items) {
    return Future.wait<dynamic>([
      fileStorage.saveItems(items),
      // webClient.postItems(items),
    ]);
  }

  @override
  Future deleteItems() {
    return Future.wait<dynamic>([
      fileStorage.clean(),
    ]);
  }
}
