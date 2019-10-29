// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:graph_calc/view/containers/add_todo.dart';
import 'package:graph_calc/view/localization.dart';
import 'package:graph_calc/view/routes.dart';
import 'package:graph_calc/view/screens/home_screen.dart';
import 'package:graph_calc/view/themes/theme.dart';
import 'package:redux/redux.dart';
import 'package:graph_calc/actions/actions.dart';
import 'package:graph_calc/middleware/store_todos_middleware.dart';
import 'package:graph_calc/models/models.dart';
import 'package:graph_calc/reducers/app_state_reducer.dart';

void main() {
  runApp(ReduxApp());
}

class ReduxApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: createStoreTodosMiddleware(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: ReduxLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          ReduxLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) {
            return HomeScreen(
              onInit: () {
                StoreProvider.of<AppState>(context).dispatch(LoadTodosAction());
              },
            );
          },
          ArchSampleRoutes.addTodo: (context) {
            return AddTodo();
          },
        },
      ),
    );
  }
}
