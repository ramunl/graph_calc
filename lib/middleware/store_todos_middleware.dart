// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/actions/items_load_action.dart';
import 'package:graph_calc/models/app_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:graph_calc/actions/item_add_action.dart';
import 'package:graph_calc/actions/items_delete_action.dart';
import 'package:graph_calc/actions/items_loaded_action.dart';
import 'package:graph_calc/actions/items_not_loaded_action.dart';
import 'package:graph_calc/mapper/expression_entity_mapper.dart';
import 'package:graph_calc/store/file_storage.dart';
import 'package:graph_calc/store/items_repository.dart';
import 'package:redux/redux.dart';

import '../store/repository.dart';

List<Middleware<AppState>> createStoreItemsMiddleware([
  ItemsRepository repository = const ItemsRepositoryFlutter(
    fileStorage:
        const FileStorage('graph_store', getApplicationDocumentsDirectory),
  ),
]) {
  final saveItems = _saveItems(repository);
  final loadItems = _loadItems(repository);
  final deleteItems = _deleteItems(repository);

  return [
    TypedMiddleware<AppState, ItemsLoadAction>(loadItems),
    TypedMiddleware<AppState, ItemAddAction>(saveItems),
    TypedMiddleware<AppState, ItemsLoadedAction>(saveItems),
    TypedMiddleware<AppState, ItemsDeleteAction>(deleteItems),
  ];
}

Middleware<AppState> _loadItems(ItemsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadItems().then(
      (items) {
        store.dispatch(
          ItemsLoadedAction(
            items.map(fromEntity).toList(),
          ),
        );
      },
    ).catchError((_) => store.dispatch(ItemsNotLoadedAction()));
    next(action);
  };
}

Middleware<AppState> _deleteItems(ItemsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    repository.deleteItems();
  };
}

Middleware<AppState> _saveItems(ItemsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    repository.saveItems(
      store.state.items
          .map((calcExpression) => toEntity(calcExpression))
          .toList(),
    );
  };
}
