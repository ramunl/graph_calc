// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:graph_calc/reducers/app_state_reducer.dart';
import 'package:graph_calc/res/localization.dart';
import 'package:graph_calc/view/routes.dart';
import 'package:graph_calc/view/screens/calculator/expression_create.dart';
import 'package:graph_calc/view/screens/home/home_screen.dart';
import 'package:graph_calc/view/themes/theme.dart';
import 'package:redux/redux.dart';

import 'actions/items_load_action.dart';
import 'middleware/middleware_items_repo.dart';
import 'models/app_state.dart';

void main() {
  runApp(CalcApp());
}

class CalcApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: createStoreItemsMiddleware(),
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
          ArchRoutes.home: (context) {
            return HomeScreen(
              onInit: () {
                StoreProvider.of<AppState>(context).dispatch(ItemsLoadAction());
              },
            );
          }
        },
      ),
    );
  }
}
