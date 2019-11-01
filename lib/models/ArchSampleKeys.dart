// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // Home Screens
  static final homeScreen = const Key('__homeScreen__');
  static final addTodoFab = const Key('__addTodoFab__');
  static final snackbar = const Key('__snackbar__');
  static final todoList = const Key('__todoList__');

  // Todos
  static final todosLoading = const Key('__todosLoading__');
  static final todoItem = (String id) => Key('TodoItem__${id}');
  static final todoItemCheckbox =
      (String id) => Key('TodoItem__${id}__Checkbox');
  static final todoItemTask = (String id) => Key('TodoItem__${id}__Task');
  static final todoItemNote = (String id) => Key('TodoItem__${id}__Note');
  static final tabs = const Key('__tabs__');

  // Tabs
  static final todoTab = const Key('__todoTab__');
  static final statsTab = const Key('__statsTab__');
  static final calcTab = const Key('__calcTab__');
  static final extraActionsButton = const Key('__extraActionsButton__');

  // Extra Actions
  static final toggleAll = const Key('__markAllDone__');
  static final clearCompleted = const Key('__clearCompleted__');
  static final filterButton = const Key('__filterButton__');

  // Filters
  static final allFilter = const Key('__allFilter__');
  static final activeFilter = const Key('__activeFilter__');
  static final completedFilter = const Key('__completedFilter__');
  static final statsCounter = const Key('__statsCounter__');

  // Stats
  static final statsLoading = const Key('__statsLoading__');
  static final statsNumActive = const Key('__statsActiveItems__');
  static final statsNumCompleted = const Key('__statsCompletedItems__');
  static final editTodoFab = const Key('__editTodoFab__');

  // Details Screen
  static final deleteTodoButton = const Key('__deleteTodoFab__');
  static final createFuncScreen = const Key('__createFuncScreen__');
  static final detailsTodoItemCheckbox = Key('DetailsTodo__Checkbox');
  static final detailsTodoItemTask = Key('DetailsTodo__Task');
  static final detailsTodoItemNote = Key('DetailsTodo__Note');
  static final addTodoScreen = const Key('__addTodoScreen__');

  // Add Screen
  static final saveFunction = const Key('__saveNewTodo__');
  static final taskField = const Key('__taskField__');
  static final noteField = const Key('__noteField__');
  static final editTodoScreen = const Key('__editTodoScreen__');

  // Edit Screen
  static final saveTodoFab = const Key('__saveTodoFab__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');
}
